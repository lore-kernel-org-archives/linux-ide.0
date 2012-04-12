From: Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 1/1] ata_piix: defer disks to the Hyper-V paravirtualised
 drivers by default
Date: Thu, 12 Apr 2012 16:55:01 +0100
Message-ID: <CAAq6er1fKFhdDEeT9dAaTk6HuXAyFjvZVSGrnVGZKM0a=9aANA@mail.gmail.com>
References: <1333042130-9634-1-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48112 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965265Ab2DLPzD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 11:55:03 -0400
Received: by wgbdr13 with SMTP id dr13so2148783wgb.1
        for <linux-ide@vger.kernel.org>; Thu, 12 Apr 2012 08:55:01 -0700 (PDT)
In-Reply-To: <1333042130-9634-1-git-send-email-apw@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, Mar 29, 2012 at 6:28 PM, Andy Whitcroft <apw@canonical.com> wro=
te:
> When we are hosted on a Hyper-V hypervisor the guest disks are expose=
d
> both via the Hyper-V paravirtualised drivers and via an emulated SATA=
 disk
> controller. =A0We want to use the paravirtualised drivers where possi=
ble as
> they are much more performant. =A0The Hyper-V paravirtualised drivers=
 only
> expose the virtual hard disk devices, the CDROM/DVD devices must stil=
l
> be enumerated on the virtualised SATA controller. =A0As we have no co=
ntrol
> over kernel probe order for these two drivers especially when one dri=
ver
> is builtin to the kernel and the other a module, we need to prevent t=
he
> ata_piix driver from claiming the disks devices by default when runni=
ng
> on a Hyper-V hypervisor.
>
> When enumerating the drives look at the aquired device ID and if it
> appears to be a disk device then report it as disconnected. =A0Limit =
this
> behaviour to when we have detected a Hyper-V hypervisor. =A0Finally a=
llow
> this behaviour to be overriden via a new module parameter.
>
> BugLink: http://bugs.launchpad.net/bugs/929545
> BugLink: http://bugs.launchpad.net/bugs/942316
> Signed-off-by: Andy Whitcroft <apw@canonical.com>
> ---
> =A0drivers/ata/ata_piix.c | =A0 29 +++++++++++++++++++++++++++++
> =A01 files changed, 29 insertions(+), 0 deletions(-)
>
> =A0 =A0This was discovered when doing some boot testing on a Hyper-V
> =A0 =A0host. =A0Performance was found to be bad as out builtin ata_pi=
ix
> =A0 =A0driver was grabbing the disks. =A0I am Cc:ing a couple of the
> =A0 =A0Microsoft people who worked on the HV driver set as well.
>
> =A0 =A0Note that the device id data is converted from device to host
> =A0 =A0order in the caller which makes examining the data problematic=
=2E
> =A0 =A0As this code only make sense on X86 and we know we are in
> =A0 =A0matching order we can access the data without first fixing it.
> =A0 =A0Alternativly we could add a new callback from the ata core
> =A0 =A0after the code has been fixed for validation.
>
> =A0 =A0Comments?
>
> =A0 =A0-apw
>
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 68013f9..64895f8 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -94,6 +94,9 @@
> =A0#include <scsi/scsi_host.h>
> =A0#include <linux/libata.h>
> =A0#include <linux/dmi.h>
> +#ifdef CONFIG_X86
> +#include <asm/hypervisor.h>
> +#endif
>
> =A0#define DRV_NAME =A0 =A0 =A0 "ata_piix"
> =A0#define DRV_VERSION =A0 =A0"2.13"
> @@ -188,6 +191,29 @@ static int piix_pci_device_resume(struct pci_dev=
 *pdev);
>
> =A0static unsigned int in_module_init =3D 1;
>
> +static int prefer_ms_hyperv =3D 1;
> +
> +unsigned int ata_piix_read_id(struct ata_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct ata_taskfile *tf, u16 *id)
> +{
> + =A0 =A0 =A0 int ret =3D ata_do_dev_read_id(dev, tf, id);
> +
> +#ifdef CONFIG_X86
> + =A0 =A0 =A0 /* XXX: note that the device id is in little-endian ord=
er, the caller
> + =A0 =A0 =A0 =A0* will shift it to host order, but we are working wi=
th little-endian.
> + =A0 =A0 =A0 =A0* As this is _only_ used on x86 we can actually dire=
ctly access it
> + =A0 =A0 =A0 =A0* as host is also little-endian.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!ret && prefer_ms_hyperv && x86_hyper =3D=3D &x86_h=
yper_ms_hyperv &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_id_is_ata(id)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ata_dev_printk(dev, KERN_WARNING, "ATA =
disk ignored deferring to Hyper-V paravirt driver\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AC_ERR_DEV|AC_ERR_NODEV_HINT;
> + =A0 =A0 =A0 }
> +#endif
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0static const struct pci_device_id piix_pci_tbl[] =3D {
> =A0 =A0 =A0 =A0/* Intel PIIX3 for the 430HX etc */
> =A0 =A0 =A0 =A0{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_p=
ata_mwdma },
> @@ -359,6 +385,7 @@ static struct ata_port_operations piix_pata_ops =3D=
 {
> =A0 =A0 =A0 =A0.set_piomode =A0 =A0 =A0 =A0 =A0 =A0=3D piix_set_piomo=
de,
> =A0 =A0 =A0 =A0.set_dmamode =A0 =A0 =A0 =A0 =A0 =A0=3D piix_set_dmamo=
de,
> =A0 =A0 =A0 =A0.prereset =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D piix_pata_pr=
ereset,
> + =A0 =A0 =A0 .read_id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ata_piix_re=
ad_id,
> =A0};
>
> =A0static struct ata_port_operations piix_vmw_ops =3D {
> @@ -1703,3 +1730,5 @@ static void __exit piix_exit(void)
>
> =A0module_init(piix_init);
> =A0module_exit(piix_exit);
> +
> +module_param(prefer_ms_hyperv, int, 0);

Jeff, any thoughts on this patch?

-apw
