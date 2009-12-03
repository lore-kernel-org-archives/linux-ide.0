From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 3 Dec 2009 16:59:47 +0000
Message-ID: <20091203165947.13841802@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<4B1771CD.3090409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53332 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754964AbZLCQ5q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 11:57:46 -0500
In-Reply-To: <4B1771CD.3090409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> The merge window is upon us, which by strict rules means that anything 
> not already in libata-dev.git#upstream needs to wait until 2.6.34.

Not quite yet - Linus hasn't said "go"

> However, bug fixes and the like should definitely be in 2.6.33. 
> ->init_host is definitely 2.6.34 material.  Some of the other stuff 
> could go either way.

The bits that probably should be delayed a bit more (if any) IMHO are the
32bit enables for hardware that doesn't use 32bit by default on the
drivers/ide stack, and tweaks for obscure old hardware that won't get
much testing.

The sooner it's all upstream the better.

Alan
