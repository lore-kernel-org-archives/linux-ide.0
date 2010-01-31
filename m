From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] ahci: disable FPDMA auto-activate optimization on NVIDIA
	AHCI
Date: Sun, 31 Jan 2010 11:10:19 -0600
Message-ID: <51f3faa71001310910h1d810eebx392201ac4143bacf@mail.gmail.com>
References: <4B5FC213.1060601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f173.google.com ([209.85.223.173]:52249 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab0AaRKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jan 2010 12:10:20 -0500
In-Reply-To: <4B5FC213.1060601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Cui <cuicui@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Hi Mike, have you had a chance to try out this patch yet?

On Tue, Jan 26, 2010 at 10:33 PM, Robert Hancock <hancockrwd@gmail.com>=
 wrote:
> Mike Cui reported that his system with an NVIDIA MCP79 (aka MCP7A) ch=
ipset
> stopped working with 2.6.32. The problem appears to be that 2.6.32 no=
w enables
> the FPDMA auto-activate optimization in the ahci driver. The drive wo=
rks fine
> with this enabled on an Intel AHCI so this appears to be a chipset bu=
g.
> Since MCP79 is a fairly recent NVIDIA chipset and we don't have any i=
nfo on
> whether any other NVIDIA chipsets have this issue, disable FPDMA AA o=
ptimization
> on all NVIDIA AHCI controllers for now.
>
> Should address http://bugzilla.kernel.org/show_bug.cgi?id=3D14922
>
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
>
> ---
>
> Mike, can you test this out and make sure this resolves the problem f=
or you?
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index b8bea10..47e57dc 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -3067,8 +3067,16 @@ static int ahci_init_one(struct pci_dev *pdev,=
 const struct pci_device_id *ent)
> =A0 =A0 =A0 =A0ahci_save_initial_config(pdev, hpriv);
>
> =A0 =A0 =A0 =A0/* prepare host */
> - =A0 =A0 =A0 if (hpriv->cap & HOST_CAP_NCQ)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_NCQ | ATA_FLAG_F=
PDMA_AA;
> + =A0 =A0 =A0 if (hpriv->cap & HOST_CAP_NCQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_NCQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Auto-activate optimization is suppos=
ed to be supported on
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0all AHCI controllers indicating =
NCQ support, but it seems
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to be broken at least on some NV=
IDIA MCP79 chipsets.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Until we get info on which NVIDI=
A chipsets don't have this
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0issue, if any, disable AA on all=
 NVIDIA AHCIs. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdev->vendor !=3D PCI_VENDOR_ID_NVI=
DIA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pi.flags |=3D ATA_FLAG_=
=46PDMA_AA;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (hpriv->cap & HOST_CAP_PMP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pi.flags |=3D ATA_FLAG_PMP;
>
