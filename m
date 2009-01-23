From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 20:01:51 +0300
Message-ID: <4979F7FF.3030506@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<20090123133352.60add80e@lxorguk.ukuu.org.uk>	<4979CBC1.3040106@ru.mvista.com>	<20090123154340.7adf5a9e@lxorguk.ukuu.org.uk>	<4979F0C3.50501@ru.mvista.com> <20090123164152.51327c62@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2177 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753293AbZAWRBU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 12:01:20 -0500
In-Reply-To: <20090123164152.51327c62@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello.

Alan Cox wrote:

>>>No reason to go removing ones that are correct

>>    You've just effectively claimed them to be incorrect with your claim what 
>>validity bits are not sufficient and ATA revision must be checked. Check the 

> Nope. Please go re-read what I wrote.

    Then I don't understand why you wrote it -- I didn't urge you to fix the 
correct inlines.

>>source please -- I wouldn't have dropped the revision check if the rest of the 
>>inlines that check word 82/82 were using it.

> In other words, as I said, you removed a correct check rather than
> correcting others which may not be correct.

    Yes. But I have no time to fix everything for everybody.

MBR, Sergei
