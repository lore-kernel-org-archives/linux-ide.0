From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Fri, 11 Jul 2014 18:28:33 +0200
Message-ID: <2816657.3zG0MhsyLF@amdc1032>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38159 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbaGKQ2r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 12:28:47 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N8K00EJI33XQGB0@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Sat, 12 Jul 2014 01:28:45 +0900 (KST)
In-reply-to: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>


Hi,

On Friday, July 11, 2014 02:10:26 PM Kevin Hao wrote:
> The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> ("libata/ahci: accommodate tag ordered controllers"). The reason is
> that the ata controller on this SoC only implement a queue depth of
> 16. When issuing the commands in tag order, all the commands in tag
> 16 ~ 31 are mapped to tag 0 unconditionally and then causes the sata
> malfunction. It makes no senses to use a 32 queue in software while
> the hardware has less queue depth. So consider the queue depth
> implemented by the hardware when requesting a command tag.
> 
> Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v3: Use ap->scsi_host->can_queue for the queue depth implemented by hardware.
>     Patch 2 in v2 is also dropped due to this change.
> 
> v2: Remove the changes for the ata tag helper functions
> 
> Hi Tejun,
> 
> I didn't get explicit objection for the codes at http://marc.info/?l=linux-ide&m=140478830920334&w=2
> So I assume that you are OK wit it. The code in this patch is the same as that,
> just add the commit log.
> 
>  drivers/ata/libata-core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8f3043165048..4792fea79acf 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4728,14 +4728,17 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>  static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
>  {
>  	struct ata_queued_cmd *qc = NULL;
> -	unsigned int i, tag;
> +	unsigned int i, tag, max_queue;
> +
> +	max_queue = ap->scsi_host->can_queue;
> +	WARN_ON_ONCE(max_queue > ATA_MAX_QUEUE);

Why not handle this properly by just doing what ata_dev_config_ncq() does and
using

	min(ap->scsi_host->can_queue, ATA_MAX_QUEUE - 1);

for obtaining max_queue?
 
>  	/* no command while frozen */
>  	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
>  		return NULL;
>  
> -	for (i = 0; i < ATA_MAX_QUEUE; i++) {
> -		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
> +	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
> +		tag = tag < max_queue ? tag : 0;
>  
>  		/* the last tag is reserved for internal command. */
>  		if (tag == ATA_TAG_INTERNAL)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

