From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 10:08:33 +0100
Message-ID: <20100409100833.666f64f1@lxorguk.ukuu.org.uk>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60591 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753111Ab0DIJEV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 05:04:21 -0400
In-Reply-To: <4BBE6CA6.1010808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: =?ISO-8859-14?B?ROJuaWVs?= Fraga <fragabr@gmail.com>, linux-ide@vger.kernel.org

> Depends on a lot of things, and what you mean by "significant". You 
> don't get NCQ in legacy mode, and you also don't get 64-bit DMA support, 
> which gets more significant the more RAM you have.

You also don't get the CPU having to handle each command itself and poke
the drive which causes signficiant stalls (doubly so because Jeff Garzik
hasn't applied my patches to fix the bogus ones yet ;))

So not only do you get 64bit DMA and NCQ but the inter command delay is
lower so its faster overall. You also get less CPU stalls for I/O which
can be very slow with legacy mode although it usually only upsets real
time people.

Alan
