From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480, take #2
Date: Sat, 19 May 2007 07:13:55 -0500
Message-ID: <20070519071355.4a7617e2@osprey.hogchain.net>
References: <4641BD26.1020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:58265 "EHLO
	imf16aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760832AbXESMN6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 May 2007 08:13:58 -0400
In-Reply-To: <4641BD26.1020501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Greg K-H <greg@kroah.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, =?UTF-8?B?TWF0w63CrWFz?= Alejandro Torres <torresmat@gmail.com>

Can someone (Greg K-H?) tell me the status of the below patch?  Is it
planned for 2.6.22?  It looks like a useful generic "let's disable msi
on board x" that I might want to use for the atl1 network driver.

Thanks,
Jay

On Wed, 09 May 2007 14:23:02 +0200
Tejun Heo <htejun@gmail.com> wrote:

> MSI doesn't work on RS400-200 and RS480 requiring pci=3Dnomsi kernel
> boot parameter for ahci to work.  This patch renames quirk_svw_msi()
> to quirk_disable_all_msi() and use it to disable MSI on those chips.
>=20
>   http://thread.gmane.org/gmane.linux.ide/17820
>   http://thread.gmane.org/gmane.linux.ide/17516
>   https://bugzilla.novell.com/show_bug.cgi?id=3D263893
>=20
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mat=C3=AD=C2=ADas Alejandro Torres <torresmat@gmail.com>
> ---
> Okay, this is the fixed version and should probably included in
> -stable too as there have been quite some number of reports which got
> resolved by adding 'pci=3Dnomsi'.  Verified by Mat=C3=AD=C2=ADas Alej=
andro Torres.
>=20
> Thanks.
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3411483..1e3070e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1624,18 +1624,20 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_N
>  			quirk_nvidia_ck804_pcie_aer_ext_cap);
> =20
>  #ifdef CONFIG_PCI_MSI
> -/* The Serverworks PCI-X chipset does not support MSI. We cannot
> easily rely
> - * on setting PCI_BUS_FLAGS_NO_MSI in its bus flags because there
> are actually
> - * some other busses controlled by the chipset even if Linux is not
> aware of it.
> - * Instead of setting the flag on all busses in the machine, simply
> disable MSI
> - * globally.
> +/* Some chipsets do not support MSI. We cannot easily rely on settin=
g
> + * PCI_BUS_FLAGS_NO_MSI in its bus flags because there are actually
> + * some other busses controlled by the chipset even if Linux is not
> + * aware of it.  Instead of setting the flag on all busses in the
> + * machine, simply disable MSI globally.
>   */
> -static void __init quirk_svw_msi(struct pci_dev *dev)
> +static void __init quirk_disable_all_msi(struct pci_dev *dev)
>  {
>  	pci_no_msi();
>  	printk(KERN_WARNING "PCI: MSI quirk detected. MSI
> deactivated.\n"); }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS,
> PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS,
> PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_disable_all_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_RS400_200, quirk_disable_all_msi);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS480,
> quirk_disable_all_msi); /* Disable MSI on chipsets that are known to
> not support it */ static void __devinit quirk_disable_msi(struct
> pci_dev *dev) - To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html Please read the FAQ at
> http://www.tux.org/lkml/
