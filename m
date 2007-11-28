From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_ali: Lots of problems still showing up with small
 ATAPI DMA
Date: Wed, 28 Nov 2007 13:05:39 +0000
Message-ID: <20071128130539.3d1d8cec@the-village.bc.nu>
References: <20071119143758.3c6b85ee@the-village.bc.nu>
	<474CC60F.9040807@gmail.com>
	<20071128092518.5f2ca7df@the-village.bc.nu>
	<474D5077.3090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48342 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756567AbXK1NJD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 08:09:03 -0500
In-Reply-To: <474D5077.3090203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

O> Does READ_CD work fine via DMA?  2K+ filtering filters most if not all
> misc commands so usually only sector (2K) aligned READ and WRITEs are
> done via DMA.  Interesting exceptions are READ_CD[_MSF] and
> READ/WRITE_BUFFER which usually exceed 2K but aren't aligned to 2K.  I
> guess it's about time to write a test case program which issues a bunch
> of problematic commands and see which works.

I'm not 100% sure but the reports for both IT821x and ALi with that are
that it does and the IT821x case I'm pretty certain of.

Getting a tester to move a CD drive between the ALi and a PIIX
controller shows the behaviour is controller specific

Alan
