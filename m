From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] (2.6.20) pata_oldpiix: fix PIO2 underclocking
Date: Mon, 1 Jun 2009 14:41:12 +0100
Message-ID: <20090601144112.55538667@lxorguk.ukuu.org.uk>
References: <200702051945.38972.sshtylyov@ru.mvista.com>
	<4A22853A.2050600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53644 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753659AbZFANkU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 09:40:20 -0400
In-Reply-To: <4A22853A.2050600@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, 31 May 2009 17:25:14 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello, I wrote:
> 
> > Fix the PIO mode 2 using mode 0 timings -- this driver should enable the
> > fast timing bank starting with PIO2, just like the ata_piix driver does.
> > Also, fix/rephrase some comments while at it.
> >
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>    Hm, looks like pata_efar still needs the same fix...

I can't find the original email (not in my archive for 2008 or 2009) but
the comment makes sense
