From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 06:12:52 -0300
Message-ID: <4bbeef97.6202be0a.13e4.166e@mx.google.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
	<20100409100833.666f64f1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:58886 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab0DIJM5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 05:12:57 -0400
Received: by ywh32 with SMTP id 32so363747ywh.33
        for <linux-ide@vger.kernel.org>; Fri, 09 Apr 2010 02:12:56 -0700 (PDT)
In-Reply-To: <20100409100833.666f64f1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On Fri, 9 Apr 2010 10:08:33 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> You also don't get the CPU having to handle each command itself and poke
> the drive which causes signficiant stalls (doubly so because Jeff Garzik
> hasn't applied my patches to fix the bogus ones yet ;))
> 
> So not only do you get 64bit DMA and NCQ but the inter command delay is
> lower so its faster overall. You also get less CPU stalls for I/O which
> can be very slow with legacy mode although it usually only upsets real
> time people.

	Interesting. With my old motherboard (sata_nv) I used to have
some stalls, mainly on GTK+ apps like Claws-mail during intense I/O
and Firefox. Now with AHCI it's barely noticeable, but it happens too,
although not as frequent as it used to happen with sata_nv.

	I hope your patches get applied soon.

-- 
