From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x completely broken
Date: Tue, 22 Jul 2008 21:39:54 +0100
Message-ID: <20080722213954.47563d6a@lxorguk.ukuu.org.uk>
References: <200807042153.56644.linux@rainbow-software.org>
	<200807221959.53669.linux@rainbow-software.org>
	<20080722191022.0417f45c@lxorguk.ukuu.org.uk>
	<200807222116.19077.linux@rainbow-software.org>
	<48863680.4080203@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56938 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbYGVU5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 16:57:33 -0400
In-Reply-To: <48863680.4080203@keyaccess.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Ondrej Zary <linux@rainbow-software.org>, Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> Looking at a Western Digital "FileCard 30" consisting of a Seagate 
> ST-125 and WDQC16 8-bit ISA controller. MFM I believe.
> 
> I put a sticker on it with: "io=0x320, irq=5, dma=3 615/4/26 (or 614)"

xt driver should support that including DMA 8)

