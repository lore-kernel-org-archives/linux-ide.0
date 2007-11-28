From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_ali: Lots of problems still showing up with small
 ATAPI DMA
Date: Wed, 28 Nov 2007 09:25:18 +0000
Message-ID: <20071128092518.5f2ca7df@the-village.bc.nu>
References: <20071119143758.3c6b85ee@the-village.bc.nu>
	<474CC60F.9040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51451 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754980AbXK1J2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 04:28:51 -0500
In-Reply-To: <474CC60F.9040807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

On Wed, 28 Nov 2007 10:36:15 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> > Hopefully there is a better long term solution but for now lets favour
> > reliability.
> 
> I'm getting a lot of reports on pata_ali w/ misc ATAPI commands too.  Do
> you know whether it's a controller problem or drive one?  All the
> reports I got are laptops and I can't really ask them to disassemble
> their laptops.  :-)

ALi is one that most definitely appears to be controller related. Thats
why I sent Jeff a patch to use DMA for 2K+ transfers only. Some ALi also
required the patch to set the xfer lengths.

Its only some revs/combinations annoyingly - a lot of them (including the
ones I have direct access too) just work.

Alan
