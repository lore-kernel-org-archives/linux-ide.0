From: Tejun Heo <htejun@gmail.com>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Tue, 12 Feb 2008 10:14:08 +0900
Message-ID: <47B0F2E0.9020204@gmail.com>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com>	<871w7k9b8y.fsf@denkblock.local> <47B00AA1.3010104@gmail.com> <87r6fj2lsx.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:53158 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbYBLBOP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 20:14:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3517532rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 17:14:14 -0800 (PST)
In-Reply-To: <87r6fj2lsx.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> +static int piix_qc_defer(struct ata_queued_cmd *qc)
> +{
> +	static struct ata_port *ap = NULL;
> +	struct ata_queued_cmd qcmd[ATA_MAX_QUEUE];

missing static?

> +	static int count = 0;
> +#define PIIX_QC_DEFER_THRESHOLD 5000
> +
> +	if (!ap)
> +		ap = qc->ap;
> +	else if (ap != qc->ap)
> +		return 0;
> +
> +	if (count > PIIX_QC_DEFER_THRESHOLD + 100)
> +		return 0;
> +
> +	count++;
> +	if (count < PIIX_QC_DEFER_THRESHOLD)
> +		return 0;
> +	else if (count == PIIX_QC_DEFER_THRESHOLD) {
> +		int i;
> +		if (ap->qc_allocated) {
> +			for (i = 0; i < ATA_MAX_QUEUE; i++)
> +				qcmd[i] = ap->qcmd[i];
> +			printk(KERN_DEBUG "piix_qc_defer(): saved current state\n");
> +			msleep(5000);
> +		} else
> +			count--;
> +	} else if (count == PIIX_QC_DEFER_THRESHOLD + 100) {
> +		dump_stack();
> +		count++;
> +	} else if (memcmp(qcmd, ap->qcmd, sizeof(qcmd[0]) * ATA_MAX_QUEUE))

memcmp() will always mismatch.  qcmd contains garbage.

> +		return ATA_DEFER_LINK;
> +	else
> +		count = 0;
> +	return 0;
> +}
> +
>  static const struct piix_map_db ich5_map_db = {
>  	.mask = 0x7,
>  	.port_enable = 0x3,
> ---
> 
> 
> ====================================================================
> Feb 11 20:33:05 denkblock kernel: piix_qc_defer(): saved current state
> Feb 11 20:33:11 denkblock kernel: BUG: scheduling while atomic: swapper/0/0x00000100

You can't call msleep(5000) there.

Thanks.

-- 
tejun
