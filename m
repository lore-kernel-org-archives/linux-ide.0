From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Fri, 23 Jan 2009 12:12:51 -0500
Message-ID: <4979FA93.3070406@rtr.ca>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<20090123133352.60add80e@lxorguk.ukuu.org.uk>	<4979CBC1.3040106@ru.mvista.com>	<20090123154340.7adf5a9e@lxorguk.ukuu.org.uk>	<4979F0C3.50501@ru.mvista.com> <20090123164152.51327c62@lxorguk.ukuu.org.uk> <4979F7FF.3030506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43461 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbZAWRMy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 12:12:54 -0500
In-Reply-To: <4979F7FF.3030506@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Sergei Shtylyov wrote:
..
>> In other words, as I said, you removed a correct check rather than
>> correcting others which may not be correct.
> 
>    Yes. But I have no time to fix everything for everybody.
..

No issue with that, is there?
Just keep the check in the code you're touching, that's all.

Cheers
