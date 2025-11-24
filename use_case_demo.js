// Prediction algorithm based on Airbnb ML system design
document.getElementById('predictionForm').addEventListener('submit', function (e) {
    e.preventDefault();

    // Get form values
    const propertyType = document.getElementById('propertyType').value;
    const bedrooms = parseInt(document.getElementById('bedrooms').value);
    const bathrooms = parseFloat(document.getElementById('bathrooms').value);
    const location = document.getElementById('location').value;
    const responseRate = parseInt(document.getElementById('responseRate').value);
    const rating = parseFloat(document.getElementById('rating').value);
    const distanceMetro = parseFloat(document.getElementById('distanceMetro').value);

    // Get selected amenities
    const amenities = Array.from(document.querySelectorAll('.amenity:checked')).map(cb => cb.value);

    // Calculate base price based on property type
    let basePrice = 0;
    switch (propertyType) {
        case 'entire_home':
            basePrice = 120;
            break;
        case 'private_room':
            basePrice = 60;
            break;
        case 'shared_room':
            basePrice = 30;
            break;
    }

    // Feature calculations
    let locationScore = 0;
    switch (location) {
        case 'downtown':
            locationScore = 1.5;
            break;
        case 'beach':
            locationScore = 1.4;
            break;
        case 'suburban':
            locationScore = 1.0;
            break;
        case 'rural':
            locationScore = 0.8;
            break;
    }

    // Distance to metro impact (closer = better)
    const metroScore = Math.max(0.8, 1.3 - (distanceMetro * 0.1));

    // Amenities score
    const amenitiesScore = 1 + (amenities.length * 0.08);

    // Host quality score
    const hostScore = (responseRate / 100) * (rating / 5);

    // Size score
    const sizeScore = 1 + (bedrooms * 0.15) + (bathrooms * 0.1);

    // Calculate final price using weighted features
    let predictedPrice = basePrice * locationScore * metroScore * amenitiesScore * (0.9 + hostScore * 0.2) * sizeScore;

    // Add some variance for realism
    predictedPrice = Math.round(predictedPrice);

    // Calculate confidence (based on data quality)
    const confidence = Math.min(98, 75 + (responseRate > 90 ? 10 : 0) + (rating > 4.5 ? 8 : 0) + (amenities.length > 2 ? 5 : 0));

    // Calculate feature importance percentages (SHAP-like values)
    const totalImpact = locationScore + metroScore + amenitiesScore + hostScore + sizeScore;
    const locationImp = Math.round((locationScore / totalImpact) * 100);
    const sizeImp = Math.round((sizeScore / totalImpact) * 100);
    const amenitiesImp = Math.round((amenitiesScore / totalImpact) * 100);
    const hostImp = Math.round((hostScore / totalImpact) * 100);

    // Display results
    displayPrediction(predictedPrice, confidence, {
        location: locationImp,
        size: sizeImp,
        amenities: amenitiesImp,
        host: hostImp
    }, {
        propertyType,
        bedrooms,
        bathrooms,
        location,
        amenities,
        responseRate,
        rating,
        distanceMetro
    });
});

function displayPrediction(price, confidence, importance, propertyData) {
    // Show result section
    const resultSection = document.getElementById('predictionResult');
    resultSection.classList.add('show');

    // Animate price
    animateValue('predictedPrice', 0, price, 1500, '$');

    // Update confidence
    document.getElementById('confidence').textContent = confidence;
    document.getElementById('confidenceFill').style.width = confidence + '%';

    // Update feature importance
    setTimeout(() => {
        document.getElementById('locationImp').textContent = importance.location + '%';
        document.getElementById('locationFill').style.width = importance.location + '%';

        document.getElementById('sizeImp').textContent = importance.size + '%';
        document.getElementById('sizeFill').style.width = importance.size + '%';

        document.getElementById('amenitiesImp').textContent = importance.amenities + '%';
        document.getElementById('amenitiesFill').style.width = importance.amenities + '%';

        document.getElementById('hostImp').textContent = importance.host + '%';
        document.getElementById('hostFill').style.width = importance.host + '%';
    }, 500);

    // Generate recommendations
    generateRecommendations(propertyData, price);

    // Scroll to results
    setTimeout(() => {
        resultSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }, 300);
}

function animateValue(elementId, start, end, duration, prefix = '') {
    const element = document.getElementById(elementId);
    const range = end - start;
    const increment = range / (duration / 16);
    let current = start;

    const timer = setInterval(() => {
        current += increment;
        if ((increment > 0 && current >= end) || (increment < 0 && current <= end)) {
            current = end;
            clearInterval(timer);
        }
        element.textContent = prefix + Math.round(current);
    }, 16);
}

function generateRecommendations(data, currentPrice) {
    const recommendations = [];

    // Check amenities
    if (!data.amenities.includes('wifi')) {
        recommendations.push({
            icon: '📶',
            text: 'Add WiFi to your listing',
            impact: '+$8-12/night',
            reason: 'WiFi is expected by 95% of guests and significantly increases booking rates'
        });
    }

    if (!data.amenities.includes('parking')) {
        recommendations.push({
            icon: '🅿️',
            text: 'Provide parking space',
            impact: '+$10-15/night',
            reason: 'Parking availability increases value, especially in urban areas'
        });
    }

    if (!data.amenities.includes('pool')) {
        recommendations.push({
            icon: '🏊',
            text: 'Consider adding a pool',
            impact: '+$25-40/night',
            reason: 'Properties with pools command premium prices and higher occupancy'
        });
    }

    // Check host quality
    if (data.responseRate < 90) {
        recommendations.push({
            icon: '⚡',
            text: 'Improve response rate to 90%+',
            impact: '+$5-10/night',
            reason: 'Fast responses increase guest confidence and booking conversion by 20%'
        });
    }

    // Check rating
    if (data.rating < 4.5) {
        recommendations.push({
            icon: '⭐',
            text: 'Focus on improving guest ratings',
            impact: '+$8-15/night',
            reason: 'Higher ratings directly correlate with increased bookings and pricing power'
        });
    }

    // Location-based recommendations
    if (data.distanceMetro > 2) {
        recommendations.push({
            icon: '🚇',
            text: 'Highlight nearby transport options',
            impact: '+$3-7/night',
            reason: 'Clear transportation info reduces guest anxiety and improves perceived value'
        });
    }

    // Professional photos
    recommendations.push({
        icon: '📸',
        text: 'Invest in professional photography',
        impact: '+$15-25/night',
        reason: 'Professional photos increase click-through rates by 40% and bookings by 24%'
    });

    // Dynamic pricing
    recommendations.push({
        icon: '💰',
        text: 'Implement dynamic pricing',
        impact: '+15-20% revenue',
        reason: 'Adjust prices based on demand, events, and seasonality to maximize revenue'
    });

    // Render recommendations
    const container = document.getElementById('recommendationsList');
    container.innerHTML = recommendations.slice(0, 5).map(rec => `
        <div class="recommendation-item">
            <div class="recommendation-icon">${rec.icon}</div>
            <div class="recommendation-text">
                <strong>${rec.text}</strong>
                <div style="color: var(--text-gray); font-size: 0.875rem; margin-top: 0.25rem;">
                    ${rec.reason}
                </div>
                <div class="recommendation-impact">${rec.impact}</div>
            </div>
        </div>
    `).join('');
}

// Add smooth animations on load
window.addEventListener('load', () => {
    const steps = document.querySelectorAll('.pipeline-step');
    steps.forEach((step, index) => {
        step.style.opacity = '0';
        step.style.transform = 'translateX(-30px)';
        setTimeout(() => {
            step.style.transition = 'all 0.5s ease';
            step.style.opacity = '1';
            step.style.transform = 'translateX(0)';
        }, index * 100);
    });
});

// Add hover effects to flow nodes
document.querySelectorAll('.flow-node').forEach(node => {
    node.addEventListener('mouseenter', function () {
        this.style.transform = 'scale(1.05)';
        this.style.borderColor = 'var(--accent)';
    });

    node.addEventListener('mouseleave', function () {
        this.style.transform = 'scale(1)';
        this.style.borderColor = 'var(--primary)';
    });
});

console.log('🎯 Airbnb ML Use Case Demo - Interactive prediction system ready!');
