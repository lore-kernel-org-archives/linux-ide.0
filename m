From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 20:18:51 +0300
Message-ID: <4979FBFB.1030304@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<20090123133352.60add80e@lxorguk.ukuu.org.uk>	<4979CBC1.3040106@ru.mvista.com>	<20090123154340.7adf5a9e@lxorguk.ukuu.org.uk>	<4979F0C3.50501@ru.mvista.com> <20090123164152.51327c62@lxorguk.ukuu.org.uk> <4979F7FF.3030506@ru.mvista.com> <4979FA93.3070406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2928 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752914AbZAWRSU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 12:18:20 -0500
In-Reply-To: <4979FA93.3070406@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello.

Mark Lord wrote:

> Sergei Shtylyov wrote:

>>> In other words, as I said, you removed a correct check rather than
>>> correcting others which may not be correct.

    I'm now seeing that I misunderstood Alan. I got somewhat angered by 
linux-usb mails right before that.

>>    Yes. But I have no time to fix everything for everybody.

> ..

> No issue with that, is there?

    We'll see... :-)

> Just keep the check in the code you're touching, that's all.

    Sure, I'll repost the patch.

> Cheers

MBR, Sergei
