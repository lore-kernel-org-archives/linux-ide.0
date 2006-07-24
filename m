From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/17] libata-link: introduce ata_link
Date: Mon, 24 Jul 2006 15:19:27 +0900
Message-ID: <44C4666F.10801@gmail.com>
References: <11523375354124-git-send-email-htejun@gmail.com> <44BE9591.5050201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:27161 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWGXJ4j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:39 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506047pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:05 -0700 (PDT)
In-Reply-To: <44BE9591.5050201@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> @@ -496,6 +496,23 @@ struct ata_eh_context {
>>      unsigned int        did_probe_mask;
>>  };
>>  
>> +struct ata_link {
>> +    struct ata_port        *ap;
>> +
>> +    unsigned int        active_tag;    /* active tag on this link */
>> +    u32            sactive;    /* active NCQ commands */
>> +
>> +    unsigned int        hw_sata_spd_limit;
>> +    unsigned int        sata_spd_limit;
>> +
>> +    /* record runtime error info, protected by host_set lock */
>> +    struct ata_eh_info    eh_info;
>> +    /* EH context */
>> +    struct ata_eh_context    eh_context;
>> +
>> +    struct ata_device    device[1];
>> +};
>> +
>>  struct ata_port {
>>      struct Scsi_Host    *host;    /* our co-allocated scsi host */
>>      const struct ata_port_operations *ops;
>> @@ -520,22 +537,13 @@ struct ata_port {
>>      unsigned int        mwdma_mask;
>>      unsigned int        udma_mask;
>>      unsigned int        cbl;    /* cable type; ATA_CBL_xxx */
>> -    unsigned int        hw_sata_spd_limit;
>> -    unsigned int        sata_spd_limit;    /* SATA PHY speed limit */
>> -
>> -    /* record runtime error info, protected by host_set lock */
>> -    struct ata_eh_info    eh_info;
>> -    /* EH context owned by EH */
>> -    struct ata_eh_context    eh_context;
>> -
>> -    struct ata_device    device[ATA_MAX_DEVICES];
>>  
>>      struct ata_queued_cmd    qcmd[ATA_MAX_QUEUE];
>>      unsigned long        qc_allocated;
>>      unsigned int        qc_active;
>>  
>> -    unsigned int        active_tag;
>> -    u32            sactive;
>> +    struct ata_link        link;    /* host default link */
>> +    struct ata_device    __dev1;    /* storage for link.device[1] */
> 
> This storage mess for link.device[] is NAK'd.
> 
> This patch overall looks good, but it should really be entirely an 
> equivalent-transformation patch, one that is easy to review and prove 
> correct.
> 
> As such, this patch should move 'struct ata_device 
> device[ATA_MAX_DEVICES]' into struct ata_link, rather than the strange 
> arrangement you have above.  If you want to do something unusual like 
> this, it's better to do it in a separate patch.

Okay, will separate out __dev1 thing.

-- 
tejun

