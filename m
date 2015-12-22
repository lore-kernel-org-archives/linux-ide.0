From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Tue, 22 Dec 2015 10:10:18 +0500
Message-ID: <c25511a245fdde4a4965bc93b62b79ea@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151221065528.GA3873@htj.duckdns.org>
 <e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
 <20151221193550.GM4026@mtj.duckdns.org>
 <20151221200721.GN4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0069.b.hostedemail.com ([64.98.42.69]:36329 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750705AbbLVFKX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Dec 2015 00:10:23 -0500
In-Reply-To: <20151221200721.GN4026@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Artem S. Tashkinov" <t.artem@mailcity.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>, Tejun Heo <htejun@gmail.com>

On 2015-12-22 01:07, Tejun Heo wrote:
> Hello, Artem.
> 
> Can you please apply the following patch on top and see whether
> anything changes?  If it does make the issue go away, can you please
> revert the ".can_queue" part and test again?
> 
> Thanks.
> 
> ---
>  drivers/ata/ahci.h    |    2 +-
>  drivers/ata/libahci.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -365,7 +365,7 @@ extern struct device_attribute *ahci_sde
>   */
>  #define AHCI_SHT(drv_name)						\
>  	ATA_NCQ_SHT(drv_name),						\
> -	.can_queue		= AHCI_MAX_CMDS - 1,			\
> +	.can_queue		= 1/*AHCI_MAX_CMDS - 1*/,		\
>  	.sg_tablesize		= AHCI_MAX_SG,				\
>  	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
>  	.shost_attrs		= ahci_shost_attrs,			\
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -420,7 +420,7 @@ void ahci_save_initial_config(struct dev
>  		hpriv->saved_cap2 = cap2 = 0;
> 
>  	/* some chips have errata preventing 64bit use */
> -	if ((cap & HOST_CAP_64) && (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)) {
> +	if ((cap & HOST_CAP_64)/* && (hpriv->flags & 
> AHCI_HFLAG_32BIT_ONLY)*/) {
>  		dev_info(dev, "controller can't do 64bit DMA, forcing 32bit\n");
>  		cap &= ~HOST_CAP_64;
>  	}

This patch fixes the issue for me. Now rechecking without .can_queue 
part.

BTW, since I left debugging on, here's the part you wanted:

[    0.613851] XXX port 0 dma_sz=91392 mem=c0020000 mem_dma=00020000 
cmd_slot=0 rx_fis=1024 cmd_tbl=1280
[    0.613865] XXX port 1 dma_sz=91392 mem=eea00000 mem_dma=2ea00000 
cmd_slot=0 rx_fis=1024 cmd_tbl=1280
[    0.620464] XXX port 2 dma_sz=91392 mem=eea20000 mem_dma=2ea20000 
cmd_slot=0 rx_fis=1024 cmd_tbl=1280
[    0.627121] XXX port 3 dma_sz=91392 mem=eea40000 mem_dma=2ea40000 
cmd_slot=0 rx_fis=1024 cmd_tbl=1280
[    0.633791] XXX port 4 dma_sz=91392 mem=eea60000 mem_dma=2ea60000 
cmd_slot=0 rx_fis=1024 cmd_tbl=1280
[    0.640445] XXX port 5 dma_sz=91392 mem=eea80000 mem_dma=2ea80000 
cmd_slot=0 rx_fis=1024 cmd_tbl=1280

