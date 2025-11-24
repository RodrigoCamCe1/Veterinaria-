using System;
using System.Windows.Forms;

namespace VeterinariaFinalFinal
{
    public class MenuForm : Form
    {
        private Button btnVerReportes;
        private Button btnRegistrarAnimal;
        private Button btnRegistrarCuidado;
        private Button btnRegistrarAtencion;
        private Button btnRegistrarAdopcion;
        private Button btnSalir;

        public MenuForm()
        {
            this.Text = "Menú Principal";
            this.StartPosition = FormStartPosition.CenterScreen;
            this.Size = new System.Drawing.Size(400, 500);
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;

            btnVerReportes = new Button
            {
                Text = "Ver Reportes",
                Width = 200,
                Height = 40,
                Top = 40,
                Left = 100
            };
            btnVerReportes.Click += (s, e) =>
            {
                this.Hide();
                var mainForm = new MainForm();
                mainForm.FormClosed += (s2, e2) => this.Show();
                mainForm.Show();
            };

            btnRegistrarAnimal = new Button
            {
                Text = "Registrar Animal Rescatado",
                Width = 200,
                Height = 40,
                Top = 100,
                Left = 100
            };
            btnRegistrarAnimal.Click += (s, e) =>
            {
                this.Hide();
                var form = new RegistrarAnimalForm();
                form.FormClosed += (s2, e2) => this.Show();
                form.Show();
            };
            btnRegistrarCuidado = new Button
            {
                Text = "Registrar Cuidado",
                Width = 200,
                Height = 40,
                Top = 160,
                Left = 100
            };
            btnRegistrarCuidado.Click += (s, e) =>
            {
                this.Hide();
                var form = new RegistrarCuidadoForm();
                form.FormClosed += (s2, e2) => this.Show();
                form.Show();
            };
            Controls.Add(btnRegistrarCuidado);

            btnRegistrarAtencion = new Button
            {
                Text = "Registrar Atención Médica",
                Width = 200,
                Height = 40,
                Top = 220,
                Left = 100
            };
            btnRegistrarAtencion.Click += (s, e) =>
            {
                this.Hide();
                var form = new RegistrarAtencionForm();
                form.FormClosed += (s2, e2) => this.Show();
                form.Show();
            };
            Controls.Add(btnRegistrarAtencion);
            btnRegistrarAdopcion = new Button
            {
                Text = "Registrar Adopción + Gastos",
                Width = 200,
                Height = 40,
                Top = 280,
                Left = 100
            };
            btnRegistrarAdopcion.Click += (s, e) =>
            {
                this.Hide();
                var form = new RegistrarAdopcionForm();
                form.FormClosed += (s2, e2) => this.Show();
                form.Show();
            };
            Controls.Add(btnRegistrarAdopcion);

            btnSalir = new Button
            {
                Text = "Salir",
                Width = 200,
                Height = 40,
                Top = 160,
                Left = 100
            };
            btnSalir.Click += (s, e) => Application.Exit();

            Controls.Add(btnVerReportes);
            Controls.Add(btnRegistrarAnimal);
            Controls.Add(btnSalir);

        }
    }
}
