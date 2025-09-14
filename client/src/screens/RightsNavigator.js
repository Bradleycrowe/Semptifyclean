import React from 'react';

function RightsNavigator() {
  return (
    <div style={styles.container}>
      <h2>Know Your Rights</h2>
      <ul>
        <li>What if my landlord won’t fix things?</li>
        <li>Can I withhold rent legally?</li>
        <li>What are my rights during eviction?</li>
      </ul>
    </div>
  );
}

const styles = {
  container: {
    margin: '50px',
    fontFamily: 'Arial, sans-serif',
  },
};

export default RightsNavigator;
