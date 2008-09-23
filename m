From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Tue, 23 Sep 2008 19:11:04 +0200
Message-ID: <9ea470500809231011p5ea37fc4u71eeeddf6ccec45a@mail.gmail.com>
References: <20080921185138.GA16310@localhost> <48D79ABD.8060805@ru.mvista.com>
	 <9ea470500809220656j6dfcf4c9q7a5a4185481ec994@mail.gmail.com>
	 <20080922204129.GA3495@localhost> <48D80949.4080901@ru.mvista.com>
	 <20080923074845.GB5656@gollum.tnic> <20080923165914.GA7803@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:64087 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYIWRLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Sep 2008 13:11:05 -0400
Received: by yx-out-2324.google.com with SMTP id 8so333807yxm.1
        for <linux-ide@vger.kernel.org>; Tue, 23 Sep 2008 10:11:04 -0700 (PDT)
In-Reply-To: <20080923165914.GA7803@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 23, 2008 at 6:59 PM, Mark de Wever <koraq@xs4all.nl> wrote:
> On Tue, Sep 23, 2008 at 09:48:45AM +0200, Borislav Petkov wrote:
>> ---
>> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
>> index 1bce84b..3833189 100644
>> --- a/drivers/ide/ide-tape.c
>> +++ b/drivers/ide/ide-tape.c
>> @@ -2338,7 +2338,7 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
>>  {
>>       idetape_tape_t *tape = drive->driver_data;
>>       struct ide_atapi_pc pc;
>> -     char fw_rev[6], vendor_id[10], product_id[18];
>> +     char fw_rev[4], vendor_id[8], product_id[16];
>>
>>       idetape_create_inquiry_cmd(&pc);
>>       if (idetape_queue_pc_tail(drive, &pc)) {
>> @@ -2350,11 +2350,11 @@ static void idetape_get_inquiry_results(ide_drive_t *drive)
>>       memcpy(product_id, &pc.buf[16], 16);
>>       memcpy(fw_rev, &pc.buf[32], 4);
>>
>> -     ide_fixstring(vendor_id, 10, 0);
>> -     ide_fixstring(product_id, 18, 0);
>> -     ide_fixstring(fw_rev, 6, 0);
>> +     ide_fixstring(vendor_id, 8, 0);
>> +     ide_fixstring(product_id, 16, 0);
>> +     ide_fixstring(fw_rev, 4, 0);
>>
>> -     printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n",
>> +     printk(KERN_INFO "ide-tape: %s <-> %s: %.8s %.16s rev %.4s\n",
>>                       drive->name, tape->name, vendor_id, product_id, fw_rev);
>>  }
>>
>>
>
> I think this patch looks good, better as all previous versions
> (including my initial version). I just tested it and it solves the
> problem. Feel free to add my tested-by.
>
> Regards,
> Mark de Wever
>
> PS I was not able to test earlier ;-)

No worries and thanks. By the way, you mentioned something about other problems
with ide-tape. FWIW, it seems you're its only user and we were about to kill it
but decided not to yet and did the whole cleanup kinda only by compile-testing
since almost no one (well, except you :)) has the hardware. So, feel free to
send me any dmesg/debug/error messages you get and I'll look into them. Also,
set IDETAPE_DEBUG_LOG to 1 before compiling for full debug info.

Thanks.

-- 
Regards/Gruss,
Boris
