From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil: Greatly improve DMA support
Date: Sat, 19 May 2007 18:03:44 -0400
Message-ID: <464F7440.10900@garzik.org>
References: <20070519053532.GA32522@havoc.gtf.org> <1441.81.207.0.53.1179591630.squirrel@secure.samage.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58364 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756755AbXESWDr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 May 2007 18:03:47 -0400
In-Reply-To: <1441.81.207.0.53.1179591630.squirrel@secure.samage.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Indan Zupancic <indan@nul.nu>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Indan Zupancic wrote:
> This patch seems to work with my SiI 3512, though I don't notice any
> difference, neither a speedup, nor a slowdown. Hdparm gives the same
> speeds (-tT), and cp -a'ing kernel sources is abysmal slow in both cases,
> (need to look into that one) so I didn't really test it that well.


It won't result in much of a speedup, except in situations where IOMMU 
or other situation that causes you to run into the 64k boundary being an 
issue -- generally only on huge transfers.

A good measure is to dd(1) to/from the block device, rather than using a 
filesystem.  As has been shown on LKML, the filesystem can really slow 
things down in some cases.

	Jeff


