using System;
using System.Windows.Forms;

namespace VeterinariaFinalFinal
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            
            Application.Run(new MenuForm()); // Ahora inicia desde el menú principal
        }
    }
}
