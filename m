From: Priyanka Gupta <ankaguptaca@gmail.com>
Subject: Re: Adding runtime PM support to sata_mv driver
Date: Sun, 2 Jan 2011 23:07:43 -0600
Message-ID: <AANLkTiksyiR3b3QZu-B7VnfhK_P4t1Y5kHxhAZ4XU+en@mail.gmail.com>
References: <Pine.LNX.4.44L0.1012292303080.13580-100000@netrider.rowland.org>
	<201012310009.11718.rjw@sisk.pl>
	<20101231120118.GI18831@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51132 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1ACFHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 00:07:44 -0500
Received: by pva4 with SMTP id 4so2401122pva.19
        for <linux-ide@vger.kernel.org>; Sun, 02 Jan 2011 21:07:44 -0800 (PST)
In-Reply-To: <20101231120118.GI18831@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-ide@vger.kernel.org

Hi,

Thanks for your replies. I am ccing the ide list now (and re-pasting
the ide patch).

Let me try and elaborate on what I am trying to achieve: I would like
to add a way to move the marvell sata controller to D3hot to save some
power. For my short term use case, I am just interested in turning off
the controllers which don't have any disks attached to them. For this,
I guess I don't really need to do much as the pci pm subsystem takes
care of suspending the controller. However, my goal is to keep the
patch generic, i.e. be able to turn off any marvell controller. So, if
there are disks attached to it, then I think that it should spin down
all the disks and power off the controller.

I would think that some userspace algorithm would decide if the
sata_mv controller should be moved into auto mode (i.e runtime power
managed). This might be done when there are no disks attached or the
system doesn't expect to use the disks behind the controller. If there
is intermittent disk usage, then the user space would not move it into
auto and keep the state as ON.

I am using the ata_pci_device_suspend for the runtime _suspend method
also because AFAICT it does exactly what I am trying to achieve. This
will try and do error handling (scsi_error_handler) which tries to
resume a device if its in the suspending state causing both threads to
be stuck.

Rafael, you mentioned in one of your emails that the patch doesn't
seem to be doing anything useful. How else do I suspend the sata_mv
controller in a proper way? Do you think that there isn't a need to
suspend the disks attached to the controller?

Thanks a lot,
Priyanka


=46rom: Priyanka Gupta <ankaguptaca@gmail.com>
Date: Tue, 28 Dec 2010 20:49:45 -0600
Subject: [PATCH] Marvell controller Runtime Power Management

---
=A0arch/x86/configs/x86_64_defconfig | =A0 =A01 +
=A0drivers/ata/sata_mv.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 46 +++++++++++++=
++++++++++++++++++++++-
=A02 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/configs/x86_64_defconfig
b/arch/x86/configs/x86_64_defconfig
index ee01a9d..b48d6ae 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -55,6 +55,7 @@ CONFIG_KEXEC=3Dy
=A0CONFIG_CRASH_DUMP=3Dy
=A0# CONFIG_COMPAT_VDSO is not set
=A0CONFIG_PM=3Dy
+CONFIG_PM_RUNTIME=3Dy
=A0CONFIG_PM_DEBUG=3Dy
=A0CONFIG_PM_TRACE_RTC=3Dy
=A0CONFIG_HIBERNATION=3Dy
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index bf74a36..34a2eed 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -65,6 +65,7 @@
=A0#include <linux/mbus.h>
=A0#include <linux/bitops.h>
=A0#include <linux/gfp.h>
+#include <linux/pm_runtime.h>
=A0#include <scsi/scsi_host.h>
=A0#include <scsi/scsi_cmnd.h>
=A0#include <scsi/scsi_device.h>
@@ -4191,21 +4192,35 @@ static struct platform_driver mv_platform_drive=
r =3D {
=A0#ifdef CONFIG_PCI
=A0static int mv_pci_init_one(struct pci_dev *pdev,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct pci_de=
vice_id *ent);
+
+void mv_pci_remove_one(struct pci_dev *pdev);
+
=A0#ifdef CONFIG_PM
=A0static int mv_pci_device_resume(struct pci_dev *pdev);
=A0#endif

+#ifdef CONFIG_PM_OPS
+static int mv_pci_runtime_device_suspend(struct device *dev);
+static int mv_pci_runtime_device_resume(struct device *dev);
+
+static const struct dev_pm_ops mv_pm_ops =3D {
+ =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(ata_pci_device_suspend, mv_pci_de=
vice_resume)
+ =A0 =A0 =A0 SET_RUNTIME_PM_OPS(mv_pci_runtime_device_suspend,
mv_pci_runtime_device_resume, NULL)
+};
+#endif

=A0static struct pci_driver mv_pci_driver =3D {
=A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D DRV_NAME,
=A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mv_pci_tbl,
=A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mv_pci_ini=
t_one,
- =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D ata_pci_remov=
e_one,
+ =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mv_pci_remove=
_one,
=A0#ifdef CONFIG_PM
=A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ata_pci_devi=
ce_suspend,
=A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mv_pci_devic=
e_resume,
=A0#endif
-
+#ifdef CONFIG_PM_OPS
+ =A0 =A0 =A0 .driver.pm=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0=3D &mv_pm_ops,
+#endif
=A0};

=A0/* move to PCI layer or libata core? */
@@ -4284,6 +4299,18 @@ static void mv_print_info(struct ata_host *host)
=A0}

=A0/**
+ * =A0 =A0 =A0mv_pci_remove_one - handle a removal of the marvell cont=
roller
+ * =A0 =A0 =A0@pdev: PCI device to be removed
+ *
+ * =A0 =A0 =A0LOCKING:
+ * =A0 =A0 =A0Inherited from caller.
+ */
+void mv_pci_remove_one(struct pci_dev *pdev) {
+ =A0 =A0 =A0 ata_pci_remove_one(pdev);
+ =A0 =A0 =A0 pm_runtime_get_noresume(&pdev->dev);
+}
+
+/**
=A0* =A0 =A0 =A0mv_pci_init_one - handle a positive probe of a PCI Marv=
ell host
=A0* =A0 =A0 =A0@pdev: PCI device found
=A0* =A0 =A0 =A0@ent: PCI device ID entry for the matched host
@@ -4359,10 +4386,25 @@ static int mv_pci_init_one(struct pci_dev *pdev=
,

=A0 =A0 =A0 =A0pci_set_master(pdev);
=A0 =A0 =A0 =A0pci_try_set_mwi(pdev);
+ =A0 =A0 =A0 pm_runtime_put_noidle(&pdev->dev);
=A0 =A0 =A0 =A0return ata_host_activate(host, pdev->irq, mv_interrupt, =
IRQF_SHARED,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IS_GEN_=
I(hpriv) ? &mv5_sht : &mv6_sht);
=A0}

+#ifdef CONFIG_PM_OPS
+static int mv_pci_runtime_device_suspend(struct device *dev)
+{
+ =A0 =A0 =A0 struct pci_dev *pdev =3D to_pci_dev(dev);
+ =A0 =A0 =A0 return ata_pci_device_suspend(pdev, PMSG_SUSPEND);
+}
+
+static int mv_pci_runtime_device_resume(struct device *dev)
+{
+ =A0 =A0 =A0 struct pci_dev *pdev =3D to_pci_dev(dev);
+ =A0 =A0 =A0 return mv_pci_device_resume(pdev);
+}
+#endif
+
=A0#ifdef CONFIG_PM
=A0static int mv_pci_device_resume(struct pci_dev *pdev)
=A0{
--
1.7.3.1


On Fri, Dec 31, 2010 at 6:01 AM, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Dec 31, 2010 at 12:09:11AM +0100, Rafael J. Wysocki wrote:
> > Adding Tejun to the CC list, because he's our SATA expert.
> >
> > Also appending the patch so that he can actually see it.
>
> And you forgot. :-)
>
> > [Priyanka, it usually is better do discuss such things on mailing
> > lists, so that people can look into the archives and see the patche=
s
> > etc.]
>
> Yes, when you reply, please at least cc linux-ide@vger.kernel.org.
>
> > > > already been moved to SUSPENDING state by the __pm_runtime_susp=
end).
> > > > This in turn invokes the scsi_error_handler to run, which ends =
up
> > > > calling scsi_autopm_get_host which then tries to get the device=
 and
> > > > hence tries to resume it. And they end up stuck, one thread try=
ing to
> > > > suspend which won't succeed, and the other thread trying to res=
ume.
> > > > See below the stack trace for both.
> > > >
> > > > If I skip the error handling the suspend works fine as you woul=
d
> > > > expect. However, that isn't a solution. I was wondering if you =
can
> > > > suggest what might be the best possible solution to this proble=
m?
> > > >
> > > > I am attaching a patch as an attachment. Hope you can help.
> > >
> > > The problem is that you call ata_pci_device_suspend(). =A0That ro=
utine
> > > apparently was not meant for use by runtime PM.
> >
> > Agreed.
>
> Hmmm... I'm not familiar with runtime PM. =A0What's it supposed to
> achieve? =A0Should it spin down the drive and power off the controlle=
r?
> If so, the only proper way would be going through EH, but how often i=
s
> this gonna be activated? =A0Even auto-spindown feature implemented in
> hardware often doesn't help much (or even consumes more power) unless
> the idle period is quite long.
>
> Thanks.
>
> --
> tejun
