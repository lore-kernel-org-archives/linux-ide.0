From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]
Date: Tue, 2 Oct 2007 16:43:06 +0100
Message-ID: <20071002164306.07e04601@the-village.bc.nu>
References: <20070822231940.278c02e8@the-village.bc.nu>
	<470264BC.5050404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47642 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755691AbXJBPiB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 11:38:01 -0400
In-Reply-To: <470264BC.5050404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

> Should this be queued for 2.6.24?
> 
> The note I have on this is "low priority, make sure it gets testing in 
> -mm first"


Its been tested without any reports. There are two things it sorts out

#1 non x86 systems with firmware that doesn't init the chip into PIO0
(not many as most chips power up in pio0)

#2 A few obscure cases where we error and then can't recover an ATA drive
as we are talking PIO4 at it and its in PIO0 so we are burbling too fast
(the other way around is of course ok)

Alan
