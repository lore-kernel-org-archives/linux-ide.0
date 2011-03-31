From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: HDD (PATA) 40-wire cable wrong detection
Date: Thu, 31 Mar 2011 11:32:31 +0100
Message-ID: <20110331113231.57befeca@lxorguk.ukuu.org.uk>
References: <bay146-w22DC3B44D3DF10B3DECB49F7BB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52351 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757166Ab1CaKb5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2011 06:31:57 -0400
In-Reply-To: <bay146-w22DC3B44D3DF10B3DECB49F7BB0@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Allen Weiner <alweiner7@hotmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 27 Mar 2011 21:23:16 +0000
Allen Weiner <alweiner7@hotmail.com> wrote:

> 
> My 133 MB/s PATA HDD is being configured for 33 MB/s due to incorrect detection of a 40-wire cable. 

You can force this (See Documentation)

> Q1: Is this problem most likely a faulty cable (I don't currently have a second cable to try a substitution), a BIOS bug, or a Linux bug? 

It's probably some weird combination of things. The board seems to have a
real mix of devices and it's possible that in the case of a VIA PATA add
on chip on an ATI chipset the rules are different somewhere.
 
> Q2: What additional steps can I take to debug this problem?

Adding debug to drivers/ata/pata_via:via_cable_detect to see which path
it takes might be instructive. (I assume the disk is on the VIA
controller).

Cable clearly is ok as the BIOS detects both states properly.
