From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Thu, 05 Jul 2007 20:31:26 -0400
Message-ID: <468D8D5E.3060905@garzik.org>
References: <200706232004.08914.bzolnier@gmail.com> <46816E5A.6010208@ru.mvista.com> <200706300012.12394.bzolnier@gmail.com> <468BC7D2.2030901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52296 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764AbXGFAb3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jul 2007 20:31:29 -0400
In-Reply-To: <468BC7D2.2030901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>    Not sure if VDMA support would be worth it...


IMO, it is useless.  It requires per-IRQ handling of each DRQ block, 
which just adds complexity to existing "PIO-ish" data paths.  You have 
to set up and tear down DMA engine for each DRQ block.

VDMA would be far more useful if it handled the entire transfer in one 
go, like a normal BMDMA transaction.

	Jeff


