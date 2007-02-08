From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: remove broken SW/MW DMA support
Date: Thu, 8 Feb 2007 09:58:45 +0100 (MET)
Message-ID: <200702080858.l188wjmG008432@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:42027 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423057AbXBHI7M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 03:59:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, sshtylyov@ru.mvista.com
Cc: linux-ide@vger.kernel.org

On Thu, 8 Feb 2007 00:00:32 +0300, Sergei Shtylyov wrote:
>Remove the bogus code pretending to set SW/MW DMA timings -- I wonder whether
>its author really thought that he could achieve that wrtiting to BMIDE status
>registers?  Stop fiddling with the DMA capable bits in the speedproc() -- they
>do not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;
>also, get rid of the duplicate reads/writes of UDIDETCRx registers, and do some
>coding style and whitespace changes while at it...
>
>Unfortunately, fixing the SW/MW DMA support would requre a major driver rewrite
>along with some more fixing, so I'm putting it off...
>
>Warning: this has been compile-tested only.

Worked fine on my SPARC Ultra5.

/Mikael
