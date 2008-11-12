From: Mark Lord <liml@rtr.ca>
Subject: Re: trouble with seagate 1.5TB - 2.6.27.4
Date: Tue, 11 Nov 2008 20:14:57 -0500
Message-ID: <491A2E11.9040102@rtr.ca>
References: <000901c93b0a$774ff3d0$b902a8c0@kyle> <491124AC.2030406@daa.com.au> <491129D5.2070009@rtr.ca> <009c01c93f09$efc54bf0$b902a8c0@kyle> <4919472C.7020904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:45224 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbYKLBOM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 20:14:12 -0500
In-Reply-To: <4919472C.7020904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: kyle <kylewong@southa.com>, James Andrewartha <jamesa@daa.com.au>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> kyle wrote:
>> ----- Original Message ----- 
>> From: "Mark Lord" <liml@rtr.ca>
>> To: "James Andrewartha" <jamesa@daa.com.au>
>> Cc: "kyle" <kylewong@southa.com>; <linux-ide@vger.kernel.org>
>> Sent: Wednesday, November 05, 2008 1:06 PM
>> Subject: Re: trouble with seagate 1.5TB - 2.6.27.4
>>
>>
>>> James Andrewartha wrote:
>>>> kyle wrote:
>>>>> Please cc me if possible.
>>>>>
>>>>> I just built a new server with some seagate 1.5TB harddisks with
>> mirrored
>>>>> /boot and root partition , The system sometime degrade the root
>> partition
>>>>> with error message as follow, this happened 4 times within 2 days.
>>>> It appears that model of drive is broken:
>>>>
>> http://forums.seagate.com/stx/board/message?board.id=ata_drives&thread.id=2390
>>>> http://www.techreport.com/discussions.x/15837
>>>> Apparently disabling the write cache is a workaround.
>>>> ..
>>> Heh, I wonder if there's been some firmware spying between Seagate and
>> Hitachi..
>>> because my two Hitachi 750GB drives can be made to have the same problem.
>>>
>>> Triggers quite reliably (perhaps 1/5 attempts?) by running "hddtemp"
>>> (to read drive temperature) during heavy I/O.  Bingo.
>>>
>>> I imagine the smartmontools would have a similar effect.
>>>
>>> Cheers
>>>
>> Now I have to rebuild the raid everyday since every morning when I check out
>> the mirrored root partition, one of the drives (not always the same) fails
>> with the mentioned error. Strange the the 6x1.5TB raid 0 storage partition
>> even down because of this.
> 
> Yikes, I'll ask Seagate what's going on and post it on linux-ata wiki
> when I know more.
..

Now slashdotted:  http://techreport.com/discussions.x/15863
