From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes
 passed from user-space
Date: Mon, 02 Jul 2007 14:00:34 -0400
Message-ID: <46893D42.9070603@garzik.org>
References: <200706302110.20766.bzolnier@gmail.com> <46891CD4.7020703@ru.mvista.com> <200707021956.32844.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53363 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbXGBSAj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 14:00:39 -0400
In-Reply-To: <200707021956.32844.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> This would brake setups which currently work OK, i.e. BIOS set things up
> (reminds me about cmd64x vs broken MWDMA)...
> 
> The RightThing(tm) to do is to fix alim15x3 driver to program DMA timings
> (especially given that pata_ali seems to already contain the needed code).

I am not ready to trust that pata_ali works as well as alim15x3 in all 
cases.  Someone should test e.g. Alpha AXP systems with IDE (use 
alim15x3) to make sure all is well.

alim15x3 covers buggy, ugly, quirky chipsets.  I consider that coverage 
in general highly fragile.

	Jeff


