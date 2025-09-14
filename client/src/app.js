// App.js
// Main entry point for Semptify frontend

import React from 'react';
import HomeScreen from './screens/HomeScreen';
import RightsNavigator from './screens/RightsNavigator';

function App() {
  return (
    <div style={styles.appContainer}>
      <HomeScreen />
      <RightsNavigator />
    </div>
  );
}

const styles = {
  appContainer: {
    fontFamily: 'Arial, sans-serif',
    padding: '20px',
    backgroundColor: '#f9f9f9',
    minHeight: '100vh',
  },
};

export default App;

