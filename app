// Export: PDF (entire page screenshot)
function exportPDF() {
  const { jsPDF } = window.jspdf;
  const pdfContent = document.getElementById("pdf-content");

  if (!pdfContent) {
    alert("PDF content not found.");
    return;
  }

  // Use a timeout to ensure elements are fully loaded before capture
  setTimeout(() => {
    html2canvas(pdfContent, {
      scale: 2,
      logging: true,
      useCORS: true // Ensures external resources load
    }).then(canvas => {
      const pdf = new jsPDF("p", "pt", "letter");
      const pageWidth = pdf.internal.pageSize.getWidth();
      const margin = 10;
      const imgWidth = pageWidth - margin * 2;
      const imgHeight = (canvas.height / canvas.width) * imgWidth;

      const imgData = canvas.toDataURL("image/png");
      pdf.addImage(imgData, "PNG", margin, margin, imgWidth, imgHeight);
      pdf.save("Deangelo_Checklist_Report.pdf");
    }).catch(error => {
      alert("An error occurred while generating the PDF. Try again.");
      console.error("html2canvas error:", error);
    });
  }, 300);
}
