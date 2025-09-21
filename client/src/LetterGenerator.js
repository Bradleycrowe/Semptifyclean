export function LetterGenerator() {
    return (
      <div>
        <h2>Letter Generator</h2>
        <form>
          <input placeholder="Your name" />
          <input placeholder="Landlord name" />
          <select><option value="repair">Repair Request</option></select>
          <button>Generate Letter</button>
        </form>
      </div>
    );
  }