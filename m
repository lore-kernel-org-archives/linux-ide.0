From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: don't set PIO mode on pre-EIDE drives
Date: Fri, 16 Nov 2007 16:56:29 +0000
Message-ID: <20071116165629.6ba73708@the-village.bc.nu>
References: <200711161626.25580.sshtylyov@ru.mvista.com>
	<20071116164240.40b02300@the-village.bc.nu>
	<473DC942.20803@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58684 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753171AbXKPQ6G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 11:58:06 -0500
In-Reply-To: <473DC942.20803@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

On Fri, 16 Nov 2007 19:45:54 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Alan Cox wrote:
> 
> >>Fix handling of  the PIO modes for the pre-EIDE drives that did not support
> >>the PIO Flow Control Transfer Mode value (00001 nnn) of the Set Transfer Mode
> >>feature by  skipping the actual mode programming.
> 
> > You also need to cater for CF 1.1 compliant devices which do not have set
> > xfer mode.
> 
>     Do they have IORDY support?

Good question. 

CF 1.4 says set features supports 01/0A/55/66/81/8A/9A/BB/CC
(with 69/96/97 NOP or not recommended)

However it documents both the PIO mode and DMA word in identify. I've
never seen a CF 1.x card which does DMA or PIO > 2.

CF 1.x is sort of ATA-2 ish but without some set features (eg its got
idle immediate) and with some stuff that became general later (security
features)

Alan
