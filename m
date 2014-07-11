From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3] libata: support the ata host which implements a queue
 depth less than 32
Date: Fri, 11 Jul 2014 15:57:01 +0400
Message-ID: <53BFD10D.3080005@cogentembedded.com>
References: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:57715 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbaGKL4x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2014 07:56:53 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so784425lab.37
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2014 04:56:51 -0700 (PDT)
In-Reply-To: <1405059026-18673-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

Hello.

On 11-07-2014 10:10, Kevin Hao wrote:

> The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> ("libata/ahci: accommodate tag ordered controllers"). The reason is
> that the ata controller on this SoC only implement a queue depth of
> 16. When issuing the commands in tag order, all the commands in tag
> 16 ~ 31 are mapped to tag 0 unconditionally and then causes the sata
> malfunction. It makes no senses to use a 32 queue in software while
> the hardware has less queue depth. So consider the queue depth
> implemented by the hardware when requesting a command tag.

> Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v3: Use ap->scsi_host->can_queue for the queue depth implemented by hardware.
>      Patch 2 in v2 is also dropped due to this change.

> v2: Remove the changes for the ata tag helper functions

> Hi Tejun,

> I didn't get explicit objection for the codes at http://marc.info/?l=linux-ide&m=140478830920334&w=2
> So I assume that you are OK wit it. The code in this patch is the same as that,
> just add the commit log.

>   drivers/ata/libata-core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8f3043165048..4792fea79acf 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4728,14 +4728,17 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>   static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
>   {
>   	struct ata_queued_cmd *qc = NULL;
> -	unsigned int i, tag;
> +	unsigned int i, tag, max_queue;
> +
> +	max_queue = ap->scsi_host->can_queue;
> +	WARN_ON_ONCE(max_queue > ATA_MAX_QUEUE);
>
>   	/* no command while frozen */
>   	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
>   		return NULL;
>
> -	for (i = 0; i < ATA_MAX_QUEUE; i++) {
> -		tag = (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
> +	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
> +		tag = tag < max_queue ? tag : 0;

    Assigning 'tag' back to 'tag' is quite stupid, don't you think? Why not:

		if (tag >= max_queue)
			tag = 0;

MBR, Sergei

