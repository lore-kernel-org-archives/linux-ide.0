From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 06/22] ide-tape: struct idetape_tape_t: remove unused
 members
Date: Mon, 22 Sep 2008 19:50:54 +0400
Message-ID: <48D7BEDE.5040408@ru.mvista.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>	 <1202132440-26648-7-git-send-email-petkovbb@gmail.com>	 <48D79CD5.5000605@ru.mvista.com> <9ea470500809220658v38cd137fl8eb15e257f0e481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13974 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638AbYIVPtz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 11:49:55 -0400
In-Reply-To: <9ea470500809220658v38cd137fl8eb15e257f0e481@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Boris Petkov wrote:

>>>@@ -3438,9 +3419,9 @@ static int idetape_identify_device (ide_drive_t
>>>*drive)
>>>  static void idetape_get_inquiry_results(ide_drive_t *drive)
>>> {
>>>-       char *r;
>>>       idetape_tape_t *tape = drive->driver_data;
>>>       idetape_pc_t pc;
>>>+       char fw_rev[6], vendor_id[10], product_id[18];
>>>         idetape_create_inquiry_cmd(&pc);
>>>       if (idetape_queue_pc_tail(drive, &pc)) {
>>>@@ -3448,20 +3429,16 @@ static void
>>>idetape_get_inquiry_results(ide_drive_t *drive)
>>>                               tape->name);
>>>               return;
>>>       }
>>>-       memcpy(tape->vendor_id, &pc.buffer[8], 8);
>>>-       memcpy(tape->product_id, &pc.buffer[16], 16);
>>>-       memcpy(tape->firmware_revision, &pc.buffer[32], 4);
>>>-
>>>-       ide_fixstring(tape->vendor_id, 10, 0);
>>>-       ide_fixstring(tape->product_id, 18, 0);
>>>-       ide_fixstring(tape->firmware_revision, 6, 0);
>>>-       r = tape->firmware_revision;
>>>-       if (*(r + 1) == '.')
>>>-               tape->firmware_revision_num = (*r - '0') * 100 +
>>>-                       (*(r + 2) - '0') * 10 + *(r + 3) - '0';
>>>+       memcpy(vendor_id, &pc.buffer[8], 8);
>>>+       memcpy(product_id, &pc.buffer[16], 16);
>>>+       memcpy(fw_rev, &pc.buffer[32], 4);
>>>+
>>>+       ide_fixstring(vendor_id, 10, 0);
>>>+       ide_fixstring(product_id, 18, 0);
>>>+       ide_fixstring(fw_rev, 6, 0);

>>  It was wrong to call ide_fixstring() on unterminated strings and expecting
>>them to become terminated strings after that; plus it was useless to add 2
>>characters padding at the end. When these variables were the fields of
>>'struct ide_tape_obj', those bytes were 0 because of the variable of this
>>type being a static array. When they became local variables, they got
>>garbage bytes at the end which ide_fixdriveid() either honestly copied when
>>compressing spaces or just left where they were...

> LOL, i just sent out a similar fix :).

>>>+
>>>       printk(KERN_INFO "ide-tape: %s <-> %s: %s %s rev %s\n",

>>  Should've rather changed the string format to print only N characters
>>max...

    The fix that I have suggested isn't at all similar.  We don't need to 
waste memory on extra bytes, and even less on them being of the 'static' 
memory class...

MBR, Sergei
