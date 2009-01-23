From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 20:27:31 +0300
Message-ID: <4979FE03.9060806@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com> <20090123133352.60add80e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3351 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754672AbZAWR1A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 12:27:00 -0500
In-Reply-To: <20090123133352.60add80e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>When checking for CFA feature set support, ata_id_is_cfa() tests bit 2 in word
>>82 of the identify data instead the word 83.  It also checks the ATA revision
>>in the  word 80 instead of usual validity check for the words 82-83 -- word 83
>>bit 14 set, bit 15 cleared.

> The word 82 validity bit is not sufficient as that bit is itself not
> defined in ATA < 3. Otherwise the change looks correct.

    Besides, I find the necessity of ATA revison check somewhat arguable. 
Words 64-127 were reserved since ATA-1 which meant that they shall be set to 0.

> Alan

MBR, Sergei
