From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
 non-ATAPI data commands
Date: Fri, 31 Jul 2009 10:20:39 +0900
Message-ID: <4A7246E7.90907@kernel.org>
References: <4A71FE71.7040002@gmail.com> <4A72084E.1030508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53932 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbZGaBV5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 21:21:57 -0400
In-Reply-To: <4A72084E.1030508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, ide <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Jeff Garzik wrote:
>> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
>> index 77aa8d7..e6946fc 100644
>> --- a/drivers/ata/sata_sil24.c
>> +++ b/drivers/ata/sata_sil24.c
>> @@ -846,6 +846,17 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
>>      if (!ata_is_atapi(qc->tf.protocol)) {
>>          prb = &cb->ata.prb;
>>          sge = cb->ata.sge;
>> +        if (ata_is_data(qc->tf.protocol)) {
>> +            u16 prot = 0;
>> +            ctrl = PRB_CTRL_PROTOCOL;
>> +            if (ata_is_ncq(qc->tf.protocol))
>> +                prot |= PRB_PROT_NCQ;
>> +            if (qc->tf.flags & ATA_TFLAG_WRITE)
>> +                prot |= PRB_PROT_WRITE;
>> +            else
>> +                prot |= PRB_PROT_READ;
>> +            prb->prot = cpu_to_le16(prot);
>> +        }
> 
> I'm trying to remember why we did not do this originally -- Tejun,
> do you recall?

Because that was how the example driver from SIMG worked.  :-)

> I do not see any prohibition in the docs, so I am inclined to apply
> this.

Eh... My original thought was to set the protocol only for new cmds
for the sake of least surprise but it does make sense to set the
protocol always.  Going through the doc...  Yeap, it should just be
fine.

Thanks.

-- 
tejun
