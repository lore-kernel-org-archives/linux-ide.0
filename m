From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel problem or faulty drive?
Date: Mon, 22 Nov 2010 14:07:55 +0000
Message-ID: <20101122140755.3b02abe6@lxorguk.ukuu.org.uk>
References: <201011221134.oAMBYAaO016345@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36192 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752102Ab0KVOJD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 09:09:03 -0500
In-Reply-To: <201011221134.oAMBYAaO016345@mercury.physics.adelaide.edu.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-ide@vger.kernel.org

> At various times the drive seems to get into a state whereby it has repeated
> trouble communicating with the kernel.  The drive clicks once, there's some
> seek activity by the drive and the following set of messages (along with
> variations) are written to the log:
> 
>   ata3: exception Emask 0x50 SAct 0x0 SErr 0x4010800 action 0xe frozen
>   ata3: irq_stat 0x00400040, connection status changed
>   ata3: SError: { HostInt PHYRdyChg DevExch }

It reported the drive being hot plugged.

>   ata3: hard resetting link
>   ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>   ata3.00: configured for UDMA/33

And a slightly odd choice of speed.

> This can occur a dozen or more times before the drive settles down, or it
> may occur only once.  All this is while Linux is not accessing the drive and
> none of its partitions are mounted.

Check the cables their connections and check your power is sufficient, a
drive dropping off the bus is a classic symptom of insufficient power on
the supply line it is using (with some PSUs moving to a different
'strand' of cable from the PSU box may be enough.
