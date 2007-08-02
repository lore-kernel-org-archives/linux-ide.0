From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Early ATA devices
Date: Thu, 2 Aug 2007 21:47:06 +0100
Message-ID: <20070802214706.50c3040c@the-village.bc.nu>
References: <20070801014137.4ab39e94@the-village.bc.nu>
	<46B021FC.20507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54659 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751143AbXHBUju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 16:39:50 -0400
In-Reply-To: <46B021FC.20507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

> > So in theory we can persuade libata to drive original MFM/RLL disks with
> > relatively few changes
> 
> Does anyone have a working device to test?

I'm currently testing a 40MB pre-ATA IDE drive and with the LBA/non-LBA
fix I sent to Andrew and the 'its ancient, its PIO < 2 who cares if
SETXFER isn't a known command' patch likewise it is running.

That one has a pre-ATA version of identify however. Not yet found one
without to play with

Alan
