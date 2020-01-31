Return-Path: <SRS0=ZjTL=3U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC6C33CB2
	for <linux-ide@archiver.kernel.org>; Fri, 31 Jan 2020 12:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D954820705
	for <linux-ide@archiver.kernel.org>; Fri, 31 Jan 2020 12:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgAaM5y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:57:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:32982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgAaM5y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 31 Jan 2020 07:57:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B791AD69;
        Fri, 31 Jan 2020 12:57:50 +0000 (UTC)
Subject: Re: [PATCH 02/24] sata_nv: move DPRINTK to ata debugging
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20181213104716.31930-1-hare@suse.de>
 <CGME20181213104751epcas1p46f3208764bdb8b6a0c03ff234cbe61bf@epcas1p4.samsung.com>
 <20181213104716.31930-13-hare@suse.de>
 <9e9442f4-a8b1-71ac-dabc-a91496f3af78@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <caba9737-e370-5c0e-3d33-b1274739f8fd@suse.de>
Date:   Fri, 31 Jan 2020 13:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9e9442f4-a8b1-71ac-dabc-a91496f3af78@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/30/20 11:46 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 12/13/18 11:46 AM, Hannes Reinecke wrote:
>> Replace all DPRINTK calls with the ata_XXX_dbg functions.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/ata/sata_nv.c | 22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
>> index 72c9b922a77b..aa2611d638ea 100644
>> --- a/drivers/ata/sata_nv.c
>> +++ b/drivers/ata/sata_nv.c
>> @@ -1451,7 +1451,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
>>  
>>  	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
>>  
>> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
>> +	ata_dev_dbg(qc->dev, "Issued tag %u\n", qc->hw_tag);
> 
> Please preserve __func__ printing in the conversion.
>  
>>  	return 0;
>>  }
>> @@ -2029,8 +2029,6 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>>  	if (qc == NULL)
>>  		return 0;
>>  
>> -	DPRINTK("Enter\n");
>> -
> 
> Please either keep it or document the removal in the patch description.
> 
>>  	writel((1 << qc->hw_tag), pp->sactive_block);
>>  	pp->last_issue_tag = qc->hw_tag;
>>  	pp->dhfis_bits &= ~(1 << qc->hw_tag);
>> @@ -2040,7 +2038,7 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
>>  	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
>>  	ap->ops->sff_exec_command(ap, &qc->tf);
>>  
>> -	DPRINTK("Issued tag %u\n", qc->hw_tag);
>> +	ata_dev_dbg(qc->dev, "Issued tag %u\n", qc->hw_tag);
> 
> Please preserve __func__ printing in the conversion.
>  
>>  	return 0;
>>  }
>> @@ -2053,7 +2051,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
>>  	if (qc->tf.protocol != ATA_PROT_NCQ)
>>  		return ata_bmdma_qc_issue(qc);
>>  
>> -	DPRINTK("Enter\n");
>> +	ata_dev_dbg(qc->dev, "Enter\n");
> 
> ditto
>  
>>  	if (!pp->qc_active)
>>  		nv_swncq_issue_atacmd(ap, qc);
>> @@ -2121,7 +2119,7 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>>  	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>>  
>>  	if (!ap->qc_active) {
>> -		DPRINTK("over\n");
>> +		ata_port_dbg(ap, "over\n");
> 
> ditto
> 
>>  		nv_swncq_pp_reinit(ap);
>>  		return 0;
>>  	}
>> @@ -2136,10 +2134,10 @@ static int nv_swncq_sdbfis(struct ata_port *ap)
>>  		 */
>>  		lack_dhfis = 1;
>>  
>> -	DPRINTK("id 0x%x QC: qc_active 0x%x,"
>> +	ata_port_dbg(ap, "QC: qc_active 0x%llx,"
> 
> ditto
> 
>>  		"SWNCQ:qc_active 0x%X defer_bits %X "
>>  		"dhfis 0x%X dmafis 0x%X last_issue_tag %x\n",
>> -		ap->print_id, ap->qc_active, pp->qc_active,
>> +		ap->qc_active, pp->qc_active,
>>  		pp->defer_queue.defer_bits, pp->dhfis_bits,
>>  		pp->dmafis_bits, pp->last_issue_tag);
>>  
>> @@ -2181,7 +2179,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
>>  	__ata_bmdma_stop(ap);
>>  	tag = nv_swncq_tag(ap);
>>  
>> -	DPRINTK("dma setup tag 0x%x\n", tag);
>> +	ata_port_dbg(ap, "dma setup tag 0x%x\n", tag);
> 
> ditto
> 
>>  	qc = ata_qc_from_tag(ap, tag);
>>  
>>  	if (unlikely(!qc))
>> @@ -2249,9 +2247,9 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>>  
>>  	if (fis & NV_SWNCQ_IRQ_SDBFIS) {
>>  		pp->ncq_flags |= ncq_saw_sdb;
>> -		DPRINTK("id 0x%x SWNCQ: qc_active 0x%X "
>> +		ata_port_dbg(ap, "SWNCQ: qc_active 0x%X "
> 
> ditto
> 
>>  			"dhfis 0x%X dmafis 0x%X sactive 0x%X\n",
>> -			ap->print_id, pp->qc_active, pp->dhfis_bits,
>> +			pp->qc_active, pp->dhfis_bits,
>>  			pp->dmafis_bits, readl(pp->sactive_block));
>>  		if (nv_swncq_sdbfis(ap) < 0)
>>  			goto irq_error;
>> @@ -2277,7 +2275,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
>>  				goto irq_exit;
>>  
>>  			if (pp->defer_queue.defer_bits) {
>> -				DPRINTK("send next command\n");
>> +				ata_port_dbg(ap, "send next command\n");
> 
> ditto
> 
>>  				qc = nv_swncq_qc_from_dq(ap);
>>  				nv_swncq_issue_atacmd(ap, qc);
>>  			}
>>
I've moved the __func__ argument into the ata_XXX_dbg() macros; this
should take care of it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
