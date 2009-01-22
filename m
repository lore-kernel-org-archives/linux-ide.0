From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: motherboard-info based blacklist for ide-dma
Date: Thu, 22 Jan 2009 18:51:33 +0300
Message-ID: <49789605.9090707@ru.mvista.com>
References: <1230651239-29388-1-git-send-email-kirr@mns.spb.ru> <497877EF.5070100@ru.mvista.com> <49787A85.6000001@ru.mvista.com> <200901221758.07007.gdu@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29589 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751404AbZAVPvC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 10:51:02 -0500
In-Reply-To: <200901221758.07007.gdu@mns.spb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Gryazin <gdu@mns.spb.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kirill Smelkov <kirr@mns.spb.ru>, linux-ide@vger.kernel.org, navy-patches@mns.spb.ru

Hello.

Dmitry Gryazin wrote:

>>>>>>>>>True.  However it should be possible to handle it correctly by
>>>>>>>>>adding
>>>>>>>>>the
>>>>>>>>>DMA quirk to the respective host drivers (seems to be via82cxxx.c
>>>>>>>>>in case of
>>>>>>>>>IEI PCISA-C3/EDEN).
>>>>>>>>
>>>>>>>> Yeah, this seems a viable approach...
>>>>>>>>
>>>>>>>>
>>>>>>>>>Kirill, could you please look into adding such quirk to via82cxxx
>>>>>>>>>instead?
>>>>>>>>>
>>>>>>>>>[ It seems the best place to add it would be via_init_one() as we
>>>>>>>>>could just
>>>>>>>>
>>>>>>>> No, not really -- the issue is not at all as simple as this patch
>>>>>>>>tried to present it. Looking at its "Quick Startup Reference"
>>>>>>>>(http://f.ipc2u.ru/files/add/doc/496/M_PCISA-C800EV_ENG.pdf), the
>>>>>>>>EPIC
>>>>>>>>board has *two* normal IDE connectors in addition to the CF slot
>>>>>>>>(connected to the secondary port -- and it seems possible that a
>>>>>>>>hard drive can be connected to the same port as CF), so the right
>>>>>>>>place seems to rather be in [mu]dma_filter() methods -- and the
>>>>>>>>decision should be strictly based on the drive type indicating CF,
>>>>>>>>i.e. by calling ata_id_is_cfa().
>>>>
>>>>I have tried my old Trancend 64Mb, RamStar 521Mb and NCP 64Mb cards.
>>>>My old cards returned right id[ATA_ID_CONFIG] = 0x848A.
>>>>
>>>>But I have to use Kingston CF Card 1Gb 2008.
>>>>ata_id_is_cfa() returns 0 for it and
>>>>id[ATA_ID_MAJOR_VER]    = 0
>>>>id[ATA_ID_CONFIG]        = 0x044A

>>>   That seems non-standard CF as ATA specifies that it must have 0x848A
>>>there.

>>>>I have only CF+ specification revision 2.0,  but I've found in wiki:

>>>   Try googling for cfspc_41.pdf (and other versions), you'll be
>>>surprised in a good way. ;-)

>>>>(http://en.wikipedia.org/wiki/CompactFlash#CF.2B_specification_revisions
>>>>) "... While the current revision 4.1 from 2004 works only in ATA mode,
>>>>..."

>>>>So I have reached an impasse. How to identify modern CF cards?

>>>   Hm, I should consult the specs...

>>    ATA/PI-7 rev. 4b has this in 4.10:

>>Devices reporting the value 848Ah in IDENTIFY DEVICE data word 0 or devices
>>having bit 2 of IDENTIFY DEVICE data word 83 set to one shall support the
>>CFA feature Set. If the CFA feature set is implemented, all five commands
>>shall be implemented.

> id[ATA_ID_COMMAND_SET_2] = 0 /* For my Kingston 1Gb CF card, kernel v2.6.28.1 
> */

    Then I guess we need a new quirk. :-/
    Besides, what does it have in id[163] (CF specific transfer modes)?

WBR, Sergei
