From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 16/16] libata-eh-fw: update ata_interrupt() to handle
 frozen port properly
Date: Thu, 13 Apr 2006 11:59:12 +0900
Message-ID: <443DBE80.1090700@gmail.com>
References: <1144762975582-git-send-email-htejun@gmail.com> <443D81EE.7090800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.231]:14823 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932433AbWDMC7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 22:59:23 -0400
Received: by wproxy.gmail.com with SMTP id i21so1383951wra
        for <linux-ide@vger.kernel.org>; Wed, 12 Apr 2006 19:59:23 -0700 (PDT)
In-Reply-To: <443D81EE.7090800@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Update the stock interrupt handler such that it unconditionally clears
>> interrupts from a frozen port.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/libata-core.c |   14 +++++++++++---
>>  1 files changed, 11 insertions(+), 3 deletions(-)
>>
>> 07f4b12b7a523dc928576fd5a2f18f40969a47ee
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index c7b7de9..d4c75cb 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -4517,12 +4517,20 @@ irqreturn_t ata_interrupt (int irq, void
>>  
>>      for (i = 0; i < host_set->n_ports; i++) {
>>          struct ata_port *ap;
>> +        struct ata_queued_cmd *qc;
>>  
>>          ap = host_set->ports[i];
>> -        if (ap &&
>> -            !(ap->flags & (ATA_FLAG_DISABLED | ATA_FLAG_NOINTR))) {
>> -            struct ata_queued_cmd *qc;
>> +        if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
>> +            continue;
>>  
>> +        if (unlikely(ap->flags & ATA_FLAG_FROZEN)) {
>> +            /* port frozen, ack unconditionally */
>> +            ata_irq_ack(ap, 0);
>> +            handled = 1;
>> +            continue;
> 
> NAK unless you can give me some reasonable justification for clearing 
> the interrupts here.
> 
> Frozen or not, this is not really an appropriate place to put this.
> 

Frozen state can be implemented in one of two ways.

1. (much preferred) masking all IRQs from the port in hardware.  Most 
modern controllers can do this.  sata_sil and sata_sil24 are converted 
to new EH this way.  Stock BMDMA freeze routine does this by turning on 
ATA_NIEN which sort of achieves the goal but a bit unreliable.

2. (plan b) making IRQ handler ack and clear IRQs unconditionally and do 
nothing else while frozen.  This works best if the controller has 
pending IRQ indication.  It's less reliable than #1 but except for 
screaming IRQ condition, it works most of the time.  Unfortunately, AHCI 
implements frozen state this way because ICH7 gets messed up if IRQ mask 
is diddled with while things are in progress.

For dumb BMDMA controllers, #2 is a bit tricky because they don't have 
IRQ pending indication, so there is no reliable way whether it's raising 
the interrupt or some other thing sharing the interrupt line is.  Also, 
as noted above, ATA_NIEN isn't the most reliable way to achieve IRQ silence.

So, the stock BMDMA interrupt handler is updated as above.  While 
frozen, it acks and clears interrupts unconditionally and tell IRQ layer 
that it handled the IRQ.  It will even ack and clear IRQs which don't 
origin from it.  Basically, it's saying "dude, I don't know where I am 
and the IRQ might or might not be mine.  Sorry for the inconvenience but 
my EH will kick in and rescue me pretty soon."

AHCI and sata_sil24 don't use the stock interrupt handler and sata_sil 
has its own freezing mechanism.  ata_piix is frozen with ATA_NIEN but 
its datasheet says ATA_NIEN plugs its interrupt at the controller level, 
so this one should be safe too.  So, removing above code shouldn't 
affect any currently converted drivers but IMHO things are safer with 
above change.

Thanks.

-- 
tejun
