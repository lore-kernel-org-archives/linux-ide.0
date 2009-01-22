From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: motherboard-info based blacklist for ide-dma
Date: Thu, 22 Jan 2009 20:10:05 +0300
Message-ID: <4978A86D.2070903@ru.mvista.com>
References: <1230651239-29388-1-git-send-email-kirr@mns.spb.ru> <49787A85.6000001@ru.mvista.com> <49787B98.8060106@ru.mvista.com> <200901221727.35574.gdu@mns.spb.ru> <49789227.2040201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31035 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752571AbZAVRJf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 12:09:35 -0500
In-Reply-To: <49789227.2040201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Dmitry Gryazin <gdu@mns.spb.ru>, Kirill Smelkov <kirr@mns.spb.ru>, linux-ide@vger.kernel.org, navy-patches@mns.spb.ru

Hello, I wrote:


>>>>>> I have tried my old Trancend 64Mb, RamStar 521Mb and NCP 64Mb cards.
>>>>>> My old cards returned right id[ATA_ID_CONFIG] = 0x848A.

>>>>>> But I have to use Kingston CF Card 1Gb 2008.
>>>>>> ata_id_is_cfa() returns 0 for it and
>>>>>> id[ATA_ID_MAJOR_VER]    = 0

>    Ah, so it doesn't bother to report the ATA/PI support... haven't 
> noticed that at first. Too many lists ot watch and things to do. :-]

>>>>>> id[ATA_ID_CONFIG]        = 0x044A

>>>>>   That seems non-standard CF as ATA specifies that it must have
>>>>> 0x848A there.

>    No, it mustn't.
>    What does it have in id[ATA_ID_COMMAND_SET_2]?

    Well, you've already replied: it has 0 there.

>>>>>> I have only CF+ specification revision 2.0,  but I've found in wiki:

>>>>>   Try googling for cfspc_41.pdf (and other versions), you'll be
>>>>> surprised in a good way. ;-)

>>>>>> (http://en.wikipedia.org/wiki/CompactFlash#CF.2B_specification_revisions) 

>>>>>> "... While the current revision 4.1 from 2004 works only in ATA mode,
>>>>>> ..."

>>>>>> So I have reached an impasse. How to identify modern CF cards?

>>>>>   Hm, I should consult the specs...

>>>>   ATA/PI-7 rev. 4b has this in 4.10:

>>>> Devices reporting the value 848Ah in IDENTIFY DEVICE data word 0 or
>>>> devices having bit 2 of IDENTIFY DEVICE data word 83 set to one shall
>>>> support the CFA feature Set. If the CFA feature set is implemented, all
>>>> five commands shall be implemented.

>>>>   Alan, looks like the libata's CF criterion needs to be enhanced.

>>>    Oops, my bad -- I should've looked first. :-<
>>>    Dmitry, just use the modern version of ata_id_is_cfa().

>> Sergei, I use the latest kernel from git repository
>> (http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git), 
>> if you are talking about this patch:
>> 37014c64079748c47fd109ef2d91ecd785a8c764

>    No, about this:

> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=b352e57dc3bb5033996adaa67c2f69b795eddd39 

    OK, I think I've found an issue in ata_id_is_cfa() as well: it tests bit 2 
in the word 82 instead of the word 83.

>> Regards, Dmitry

MBR, Sergei
