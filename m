From: Conke Hu <conke.hu@amd.com>
Subject: Re: [git patches] libata fixes
Date: Wed, 07 Feb 2007 15:11:57 +0800
Message-ID: <1170832317.3787.20.camel@localhost.localdomain>
References: <20070202165842.GA6412@havoc.gtf.org>
Reply-To: conke.hu@amd.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:6024 "EHLO
	outbound1-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965645AbXBGHLa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 02:11:30 -0500
In-Reply-To: <20070202165842.GA6412@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, 2007-02-02 at 11:58 -0500, Jeff Garzik wrote:
> Brian and Tejun's patches fix really ugly bugs, Alan's are of less
> importance
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/ata/libata-core.c  |    1 +
>  drivers/ata/pata_atiixp.c  |   11 +++++++++--
>  drivers/ata/pata_jmicron.c |   18 +++++-------------
>  drivers/ata/pata_via.c     |    3 ++-
>  drivers/pci/quirks.c       |    4 ++--
>  include/linux/libata.h     |    2 ++
>  6 files changed, 21 insertions(+), 18 deletions(-)
> 
> Alan (3):
>       pata_atiixp: propogate cable detection hack from drivers/ide to the new driver
>       pata_via: Correct missing comments
>       libata: Fix ata_busy_wait() kernel docs
> 
> Brian King (1):
>       libata: Initialize nbytes for internal sg commands
> 
> Tejun Heo (1):
>       ahci/pata_jmicron: fix JMicron quirk
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cf70702..667acd2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1250,6 +1250,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  
>  		ata_sg_init(qc, sg, n_elem);
>  		qc->nsect = buflen / ATA_SECT_SIZE;
> +		qc->nbytes = buflen;
>  	}
>  
>  	qc->private_data = &wait;
> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 6f6672c..504e1db 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -36,15 +36,22 @@ enum {
>  static int atiixp_pre_reset(struct ata_port *ap)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> -	static struct pci_bits atiixp_enable_bits[] = {
> +	static const struct pci_bits atiixp_enable_bits[] = {
>  		{ 0x48, 1, 0x01, 0x00 },
>  		{ 0x48, 1, 0x08, 0x00 }
>  	};
> +	u8 udma;
>  
>  	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
>  		return -ENOENT;
>  
> -	ap->cbl = ATA_CBL_PATA80;
> +	/* Hack from drivers/ide/pci. Really we want to know how to do the
> +	   raw detection not play follow the bios mode guess */
> +	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ap->port_no, &udma);
> +	if ((udma & 0x07) >= 0x04 || (udma & 0x70) >= 0x40)
> +		ap->cbl = ATA_CBL_PATA80;
> +	else
> +		ap->cbl = ATA_CBL_PATA40;
>  	return ata_std_prereset(ap);
>  }
> (snip)
>  

Alan's patch is also important. Thank you :)

Without the patch, OS on 40-pin cable maybe get IDE DMA error (CRC
error, system hang, or even data crash).

Conke


