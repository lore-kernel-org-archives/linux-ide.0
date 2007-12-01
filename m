From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SAS v SATA interface performance
Date: Sat, 1 Dec 2007 00:17:40 +0000
Message-ID: <20071201001740.7ffce6f6@the-village.bc.nu>
References: <4750A523.7010501@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35113 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758141AbXLAAV1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 19:21:27 -0500
In-Reply-To: <4750A523.7010501@clear.net.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: linux-ide@vger.kernel.org

> The comment I saw, which I'm trying to verify, mentioned the SATA drives 
> "held the bus" or similar longer than SAS ones.

SATA normally uses one link per device so the device side isn't contended
unless you descend into the murky world of port multipliers. 

On the host side an AHCI controller offloads all the tedious operations
to the controller so you don't get long slow PCI side accesses slowing up
the CPU either.
