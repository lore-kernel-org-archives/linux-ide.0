From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 19:42:11 +0000
Message-ID: <20120116194211.2cd09fb3@pyramind.ukuu.org.uk>
References: <20120109003255.GA6598@havoc.gtf.org>
	<CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com>
	<4F12E57E.3090805@garzik.org>
	<1326676534.13517.3.camel@minggr>
	<1326691403.13517.21.camel@minggr>
	<CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44616 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab2APTlL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 14:41:11 -0500
In-Reply-To: <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lin Ming <ming.m.lin@intel.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> The IO ports are all there, the *only* reason we don't use AHCI seems
> to be that the firmware didn't turn off the legacy bit, so it doesn't
> show as an AHCI interface. That's kind of sad.

There are two sets of problems with that

The first is that quite a few machines crap themselves if you do this
because nobody has ever tested things like the IRQ routing or the
firmware on suspend/resume when they find the hardwared controller has
gone for a walk.

Putting it back on suspend might help in some cases but then you get to
pick your way through the documentation minefield, deal with device
changes while in non AHCI mode, figure out how to set up registers the
BIOS didn't etc.

Would be a good project for someone with a lot of patience anyway as the
AHCI mode is also 64bit capable and *much* faster overall as it doesn't
keep stalling the CPU poking imaginary registers and turning them into
messages on the SATA bus.

Alan
