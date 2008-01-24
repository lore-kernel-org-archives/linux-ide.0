From: Mark Lord <liml@rtr.ca>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Thu, 24 Jan 2008 10:56:22 -0500
Message-ID: <4798B526.4020709@rtr.ca>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4460 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849AbYAXP40 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 10:56:26 -0500
In-Reply-To: <4798AE28.4000408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun,
>>
>> During testing with NCQ on sata_mv (patches coming shortly),
>> I found this gem in the syslog.  This doesn't look like something
>> that a LLD could cause, but rather a race perhaps in libata-core.
> 
> Hmmm... This isn't supposed to happen.
> 
>> System is a 2.4GHz 32-bit Core2Quad, 2GB RAM (during this test),
>> running 2.6.24-rc6-git12 + newer sata_mv, with two sata_mv controller
>> cards, each with one NCQ drive performing heavy R/W activity.
>>
>> Other than that, I'm not sure what triggered this.
> 
> Can you please tell me which version you were using?  Or tell me which
> one of the three WARN_ON()'s in ata_qc_issue() was triggered?  Thanks.
..
>> [  289.892890] WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
..

The first one shown below, at drivers/ata/libata-core.c:5988:

> void ata_qc_issue(struct ata_queued_cmd *qc)
> {
>         struct ata_port *ap = qc->ap;
>         struct ata_link *link = qc->dev->link;
> 
>         /* Make sure only one non-NCQ command is outstanding.  The
>          * check is skipped for old EH because it reuses active qc to
>          * request ATAPI sense.
>          */
=         WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));
> 
>         if (qc->tf.protocol == ATA_PROT_NCQ) {
>                 WARN_ON(link->sactive & (1 << qc->tag));
> 
..
