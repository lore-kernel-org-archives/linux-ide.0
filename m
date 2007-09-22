From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sat, 22 Sep 2007 19:12:48 +0100
Message-ID: <20070922191248.5f2bc74a@the-village.bc.nu>
References: <46C69913.1060505@g7.org>
	<46C799E8.8080407@rtr.ca>
	<20070819175632.349d11c5@the-village.bc.nu>
	<46EC70A0.1000800@g7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37807 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750981AbXIVSGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Sep 2007 14:06:14 -0400
In-Reply-To: <46EC70A0.1000800@g7.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Malcolm Gillies <malcolm@g7.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

> I've acquired a new CF card that is capable of UDMA2, and with the same 
> connectors, wiring and adaptor (i.e. I popped out the MWDMA card and 
> inserted the UDMA one), I can now boot and read data on both devices 
> without error at reasonable speeds.

Fascinating. Does point more to a driver funny you are right. At the
moment I'm at a loss to guess what
