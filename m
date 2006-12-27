From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] via82cxxx: fix cable detection
Date: Wed, 27 Dec 2006 12:20:11 -0500
Message-ID: <4592AB4B.1010609@pobox.com>
References: <20061227124659.GB10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45363 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010AbWL0RUS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Dec 2006 12:20:18 -0500
In-Reply-To: <20061227124659.GB10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Cable detection got broken probably while converting the driver to
> support multiple controllers.  Cable detection is done by examining
> how BIOS configured the attached devices.  The current code is broken
> in that it examines the status *after* modifying Clk66 configuration
> ending up detecting 40c cables as 80c.  This patch fixes it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> This certainly is a regression and there are users affected by this.
> I've verified this on both primary and secondary channel of vt6421.
> Who takes IDE patches these days?  Jeff, can you push this through
> libata-dev#upstream-fixes?

I would guess Alan or Andrew or (who just replied) Bart.

You can count on me to /not/ apply drivers/ide patches.  It's easier 
that way, if I stay out of that game.

	Jeff



