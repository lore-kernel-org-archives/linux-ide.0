From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp c pl atform
Date: Fri, 26 May 2006 18:15:18 +0200
Message-ID: <20060526161517.GB11778@powerlinux.fr>
References: <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca> <20060526114245.GA32330@powerlinux.fr> <44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr> <447722FF.9020202@rtr.ca> <20060526160156.GA11778@powerlinux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.wanadoo.fr ([193.252.22.27]:44123 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751012AbWEZQUa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 12:20:30 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0407.wanadoo.fr (SMTP Server) with ESMTP id 781661C003EB
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 18:20:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20060526160156.GA11778@powerlinux.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>

On Fri, May 26, 2006 at 06:01:56PM +0200, Sven Luther wrote:
> > Can you access the disk?  Eg.  hexdump -C /dev/sda
> 
> Trying to partition the disk with parted yielded the last set of debug
> messages, and a : 

Interesting. Using dd, i am able to write some stuff to disk :

dd if=/dev/sda of=/tmp/blah count=1 -> hexdump /tmp/blah yields only 0s.
dd if=/dev/random of=/dev/sda count=4 (count = 4, because /dev/random outputs blocks of 128 bytes)
dd if=/dev/sda of=/tmp/blah count=1 -> hexdump /tmp/blah yield random non-0 content

Trying to write past the first block, seems to freeze the disk or someting, at
least dd doesn't come back without me ctr-c'ing it.

Friendly,

Sven Luther


