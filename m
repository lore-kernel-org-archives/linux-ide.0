From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux v2.6.22-rc3
Date: Sun, 27 May 2007 09:24:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705270922030.26602@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>
  <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>
 <46599E6B.1000209@pobox.com>
 <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:52534 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754769AbXE0QYQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 May 2007 12:24:16 -0400
In-Reply-To: <9d2cd630705270907y4722653cpf79f073fa8f12f08@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregor Jasny <gjasny@googlemail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>



On Sun, 27 May 2007, Gregor Jasny wrote:

> 2007/5/27, Jeff Garzik <jgarzik@pobox.com>:
> > Does the attached patch fix things?
> 
> No it doesn't. Note that I'm using ata_piix.

The commit message for that thing is badly worded. It definitely hits 
ata_piix too, and it concerns a lot more than just the LITE-ON CD-ROM 
drives (ie that patch fixes a bug for me on a PIIX system I have access 
to, with a TDK drive).

But if it doesn't help for you, you have some other issue (which is not 
surprising - yours wasn't a SETFXSR error, and I don't think it would have 
worked very well before either).

So since it apparently _did_ work for you before, can you bisect it?

		Linus
