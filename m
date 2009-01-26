From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 23:47:26 +0300
Message-ID: <497E215E.20007@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0EF3.2000201@ru.mvista.com>	<497E101C.9040008@ru.mvista.com>	<20090126194237.4897b6ce@lxorguk.ukuu.org.uk>	<497E1550.1000501@ru.mvista.com> <20090126200143.733b0cec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5002 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752056AbZAZUq5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:46:57 -0500
In-Reply-To: <20090126200143.733b0cec@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:

>>    I have explained everything in the prior mail. I hadn't expect you to 
>>start the patch fencing.

> I don't see an explanation just points I queried. I shall draw the obvious
> conclusion from the fact you don't feel like providing one

> The logic is this

> ATA-3 or higher - that word has a defined meaning
> ATA < 3 that word should be 0x0000

    Dunno why but I removed my remark: they are reserved and so "shall be 
zero" starting aith ATA-1. I've already stated that.

MBR, Sergei
