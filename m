From: Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 04/10] ata: add ata_is_fpdma() accessor
Date: Thu, 14 Jul 2016 17:15:51 +0200
Message-ID: <5787ACA7.9050808@suse.com>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-5-git-send-email-hch@lst.de>
 <20160714143756.GF15005@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41477 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbcGNPQP (ORCPT
	<rfc822;groupwise-linux-ide@vger.kernel.org:0:0>);
	Thu, 14 Jul 2016 11:16:15 -0400
In-Reply-To: <20160714143756.GF15005@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On 07/14/2016 04:37 PM, Tejun Heo wrote:
> Hello,
> 
> I'm still a bit confused about this patch.
> 
> On Thu, Jul 14, 2016 at 09:05:45AM +0900, Christoph Hellwig wrote:
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index a723ae9..acfb865 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -534,7 +534,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>>  	VPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x\n",
>>  		cd->cfis[0], cd->cfis[1], cd->cfis[2]);
>>  
>> -	if (qc->tf.protocol == ATA_PROT_NCQ) {
>> +	if (ata_is_fpdma(qc->tf.protocol)) {
> 
> ata_is_fpdma() tests NCQ or DMA.  Is this right?
> 
Yes. The 'sata_fsl' driver has no means (or at least none which I could
detect) allowing it to send NCQ NON-DATA commands.
So for this driver the check for ncq is actually a check for fpdma.

>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -1173,7 +1173,7 @@ static void mv_set_irq_coalescing(struct ata_host *host,
>>  static void mv_start_edma(struct ata_port *ap, void __iomem *port_mmio,
>>  			 struct mv_port_priv *pp, u8 protocol)
>>  {
>> -	int want_ncq = (protocol == ATA_PROT_NCQ);
>> +	int want_ncq = (ata_is_fpdma(protocol));
> 
> Let's get rid of the parentheses while at it.
> 
Okay.

>>  
>>  	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
>>  		int using_ncq = ((pp->pp_flags & MV_PP_FLAG_NCQ_EN) != 0);
>> @@ -2156,8 +2156,7 @@ static void mv_qc_prep_iie(struct ata_queued_cmd *qc)
>>  	unsigned in_index;
>>  	u32 flags = 0;
>>  
>> -	if ((tf->protocol != ATA_PROT_DMA) &&
>> -	    (tf->protocol != ATA_PROT_NCQ))
>> +	if (!ata_is_fpdma(tf->protocol))
> 
> This is actually testing !DMA && !NCQ and an equivalent conversion but
> the rest aren't.
> 
Yes.

>> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
>> index 734f563..89e36aa 100644
>> --- a/drivers/ata/sata_nv.c
>> +++ b/drivers/ata/sata_nv.c
>> @@ -1407,7 +1407,7 @@ static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
>>  	cpb->next_cpb_idx	= 0;
>>  
>>  	/* turn on NCQ flags for NCQ commands */
>> -	if (qc->tf.protocol == ATA_PROT_NCQ)
>> +	if (ata_is_fpdma(qc->tf.protocol))
>>  		ctl_flags |= NV_CPB_CTL_QUEUE | NV_CPB_CTL_FPDMA;
> 
> And I don't know why testing NCQ or DMA would be safe for places like
> this.
> 
Again, this driver cannot handle NCQ NON-DATA command, so it always has
to assume that NCQ _actually_ means FPDMA.

>> +	ATA_PROT_FLAG_FPDMA	= ATA_PROT_FLAG_NCQ | ATA_PROT_FLAG_DMA,
> ...
>> +static inline bool ata_is_fpdma(u8 prot)
>> +{
>> +	return ata_prot_flags(prot) & ATA_PROT_FLAG_FPDMA;
>> +}
> 
> ???
> 
Yeah, strictly speaking there is no need for ATA_PROT_FLAG_FPDMA.
I'll be removing it if you insist.

Cheers,

Hannes

