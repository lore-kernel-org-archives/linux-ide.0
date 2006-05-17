From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 16:49:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171643510.10823@g5.osdl.org>
References: <20060515170006.GA29555@havoc.gtf.org>
 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
 <446914C7.1030702@garzik.org> <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
 <44694C4F.3000008@garzik.org> <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
 <Pine.LNX.4.64.0605160755170.3866@g5.osdl.org> <87ves44qrs.fsf@duaron.myhome.or.jp>
 <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:54242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbWEQXuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 19:50:20 -0400
In-Reply-To: <Pine.LNX.4.64.0605171632340.10823@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Avuton Olrich <avuton@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org



On Wed, 17 May 2006, Linus Torvalds wrote:
> 
> I think Neil already reported that it fixed a lost interrupt problem for 
> him, but I'm worried that it might result in interrupt storms for others. 

Of course, we could just decide to try to switch from level to 
edge-triggered if the irq storm thing ever triggers. Right now we disable 
the irq entirely, which means that _if_ it was just due to a polarity 
error, we're screwed even if it should have been easy to fix by just 
turning it into edge-high.

The code to do that should be trivial: make __report_bad_irq() try to 
switch to edge mode if it's not edge already. Hmm?

		Linus
