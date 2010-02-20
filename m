From: Asdo <asdo@shiftmail.org>
Subject: Re: How to reread disk size?
Date: Sat, 20 Feb 2010 22:30:47 +0100
Message-ID: <4B805487.2010900@shiftmail.org>
References: <4B7F234F.9000107@shiftmail.org> <4B802BDF.9020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.isti.cnr.it ([194.119.192.4]:4569 "EHLO mx2.isti.cnr.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078Ab0BTVbW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Feb 2010 16:31:22 -0500
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5-b2 #31825) id <01NJWH6T5R8WBF4MD9@mx.isti.cnr.it> for
 linux-ide@vger.kernel.org; Sat, 20 Feb 2010 22:30:51 +0100
In-reply-to: <4B802BDF.9020509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
>> [CUT]
>> In the past I was doing:
>>
>> blockdev --rereadpt /dev/sdX
>>
>> and it usually worked on other controllers to reread the size visible
>> from "blockdev --getsize" or "blockdev --getsize64". One time I think it
>> even worked on exactly *that* controller... but it's not working now,
>> it's strange.
>>
>> Is there a technique, or I am out of luck?
>> The machine should not be rebooted
>> I would even enter the size manually if possible: I know how many LBA
>> blocks are in that disk.
>
> What dmesg output do you get when you do this?

with "this" I suppose you mean the blockdev --rereadpt?

This is the dmesg I get upon blockdev --rereadpt:

[508100.472337] sd 3:0:1:0: [sdr] 1465149168 512-byte hardware sectors 
(750156 MB)
[508100.472376] sd 3:0:1:0: [sdr] Write Protect is off
[508100.472381] sd 3:0:1:0: [sdr] Mode Sense: 00 3a 00 00
[508100.472412] sd 3:0:1:0: [sdr] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[508100.472418]  sdr: unknown partition table


It rereads the wrong size, i.e. the one of the old disk :-(
I am sure sdr is the correct disk, I even identified it by doing dd 
if=/dev/sdr of=/dev/null and then looking at the activity led to confirm 
it's the right drive. It should have read a size of 1TB.

Thanks for your help
