From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_ali can't detect partitions
Date: Tue, 10 Nov 2009 11:11:25 +0000
Message-ID: <20091110111125.15a71ed7@lxorguk.ukuu.org.uk>
References: <20091109220338.GA1604@seek.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48378 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752942AbZKJLJw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 06:09:52 -0500
In-Reply-To: <20091109220338.GA1604@seek.priv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, gianluca@sottospazio.it

> commit 1b2c357c301b76118973763e886d9f70a7f50f7e
> pata_ali: force initialise a few bits
> 
> I tried to backout the commit but that didn't succeed. So I looked carefully
> at the diff and I came out with the attached patch which seems to fix the
> problem (at least now the kernel detects the partitions correctly).

Thanks for doing this. Can you send me an lspci -vvxxx and a dmesg of the
machine in question.

> Since I saw that the above commit is fixing some real bugs (sunblade related)
> I don't know whether the attached patch is right or is backing out the
> intended fix. All I know is that it works for me and for this reason I'm
> reporting it.

Some of the registers involved are deep magic (even with the official
documentation its unclear what should occur in all cases). I will have
another dig - probably it depends on the chip rev what the right setting
is.

Alan
