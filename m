From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 22:13:34 +0300
Message-ID: <497A16DE.4050300@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<20090123133352.60add80e@lxorguk.ukuu.org.uk>	<4979FE03.9060806@ru.mvista.com> <20090123175329.222418cc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5654 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751383AbZAWTNE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 14:13:04 -0500
In-Reply-To: <20090123175329.222418cc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>>>When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 in word
>>>>82 of the identify data instead the word 83.  It also checks the ATA revision
>>>>in the  word 80 instead of usual validity check for the words 82-83 -- word 83
>>>>bit 14 set, bit 15 cleared.

>>>The word 82 validity bit is not sufficient as that bit is itself not
>>>defined in ATA < 3. Otherwise the change looks correct.

>>    Besides, I find the necessity of ATA revison check somewhat arguable. 
>>Words 64-127 were reserved since ATA-1 which meant that they shall be set to 0.

> One reason for the 0xC000/0x4000 check is that they were not - various
> very old devices like to return 0xFFFF for all the spare bits as do a
> fair number of EIDE devices.

    Yes, but bit 14/15 check should cover such case without the revision check.

> Yes it's probably paranoia but this is ATA ;)

    So, we want ot stay paranoid WRT ata_id_is_cf()? We then have to be 
paranoid consitently. :-)

MBR, Sergei
