From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: [RESEND][PATCH] sata_via: Add SATA support for vt8237a
Date: Thu, 24 Aug 2006 19:34:46 -0500
Message-ID: <44EE45A6.6050503@bellsouth.net>
References: <20060814031030.GA3088@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:48011 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1030493AbWHYAe6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 20:34:58 -0400
Received: from ibm64aec.bellsouth.net ([70.144.210.122])
          by imf20aec.mail.bellsouth.net with ESMTP
          id <20060825003457.WHIB29175.imf20aec.mail.bellsouth.net@ibm64aec.bellsouth.net>
          for <linux-ide@vger.kernel.org>; Thu, 24 Aug 2006 20:34:57 -0400
In-Reply-To: <20060814031030.GA3088@osprey.hogchain.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jay Cliburn wrote:
> The initial submittal of this patch was erroneously sent to the wrong
> list (linux-scsi), and I neglected to cc the maintainer.  Never
> received an ACK.
> 
> This patch adds support for the VIA Technologies VT8237A SATA controller.
> 
> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
> 
> ---
> diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
> index 03baec2..d939fc8 100644
> --- a/drivers/scsi/sata_via.c
> +++ b/drivers/scsi/sata_via.c
> @@ -76,6 +76,7 @@ static u32 svia_scr_read (struct ata_por
>  static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
>  
>  static const struct pci_device_id svia_pci_tbl[] = {
> +	{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
>  	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
>  	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
>  
> -

Please apply this patch.  It's trivial and it works.  I own a
motherboard that contains the VT8237A SATA controller, and I've tested
the patch with Fedora Core 5, Fedora Core 6 test 2, and current Fedora
Core rawhide (2.6.18rc4-git1).  I'm receiving personal requests for
assistance in getting kernels to recognize and boot from the 8237A, and
it would really help if the patch were applied.

If there's something wrong with the patch, or if you'd rather receive it
from a more trusted source, just say so and I'll comply.  Any feedback
at all would be greatly appreciated.

Best regards,
Jay


