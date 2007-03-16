From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:16:35 +0300
Message-ID: <45FAA6C3.8090209@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca>	<45FA8D7A.3040504@rtr.ca>	<45FAA35C.2090902@ru.mvista.com> <20070316151508.543486ec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33244 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752169AbXCPOQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:16:48 -0400
In-Reply-To: <20070316151508.543486ec@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Alan Cox wrote:
>>    Which requires from the drivers to be able to turn off IDE prefetch (and 
>>maybe posting too).  I don't see that in this patch (or are you expecting them 
>>to just "snoop' the commands and do it automagically?).

> We need to see which drivers have that problem and if its only the odd
> one then we can handle it in qc_issue. We've already got controllers that
> wrap qc_issue to peek at commands and reject some of them (eg the 8212 in
> hardware raid mode)

    I'd expect this to be needed with all drives, since IIUC prefetch is 
working based on either fixed or programmable sector size. And here the 
out-of-band PIO protocol itself (which fails to be taken into account by the 
patch) implies mixed 8- and 16- bit I/O which should also be muddling up the 
prefetch logic.

> Alan

WBR, Sergei
