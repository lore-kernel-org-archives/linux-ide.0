From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 1/4] libata: fix device iteration bugs
Date: Mon, 27 Oct 2008 18:07:59 +0900
Message-ID: <490584EF.8040700@kernel.org>
References: <49041323.9020309@kernel.org> <49044ABA.7050104@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47684 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbYJ0JIN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 05:08:13 -0400
In-Reply-To: <49044ABA.7050104@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
> Hello.
> 
> Tejun Heo wrote:
> 
>> There were several places where only enabled devices should be
>> iterated over but device enabledness wasn't checked.
>>
>> * IDENTIFY data 40 wire check in cable_is_40wire()
>> * xfer_mode/ncq_enabled saving in ata_scsi_error()
>> * DUBIOUS_XFER handling in ata_set_mode()
>>
>> While at it, reformat comment in cable_is_40wire().
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>>   
> 
>   More nitpicking... :-)
> 
>> Index: work/drivers/ata/libata-core.c
>> ===================================================================
>> --- work.orig/drivers/ata/libata-core.c
>> +++ work/drivers/ata/libata-core.c
>> @@ -4169,18 +4169,16 @@ static int cable_is_40wire(struct ata_po
>>      if (ap->cbl == ATA_CBL_PATA40_SHORT)
>>          return 0;
>>      /* If the controller doesn't know we scan
>> -
>> -       - Note: We look for all 40 wire detects at this point.
>> -         Any 80 wire detect is taken to be 80 wire cable
>> -         because
>> -         - In many setups only the one drive (slave if present)
>> -               will give a valid detect
>> -             - If you have a non detect capable drive you don't
>> -               want it to colour the choice
>> -        */
>> +     *
>> +     * - Note: We look for all 40 wire detects at this point.  Any
>> +     *   80 wire detect is taken to be 80 wire cable because - In
>> +     *   many setups only the one drive (slave if present) will
>> +     *   give a valid detect - If you have a non detect capable
>> +     *   drive you don't want it to colour the choice
>> +     */
>>   
> 
>   The comment formatting  now is worse than it was... I'd drop hyphen
> before "Note:" and align the bullets under this note (also doing s/If/if/).

Yeah, somehow I missed those bullets altogether.  Will regenerate the
patch.  Thanks.

-- 
tejun
