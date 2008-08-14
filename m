From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load
 2.6.24-7
Date: Thu, 14 Aug 2008 11:50:05 +0100
Message-ID: <20080814115005.1495a0b1@lxorguk.ukuu.org.uk>
References: <48A35FE6.1080903@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55534 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752951AbYHNLJt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Aug 2008 07:09:49 -0400
In-Reply-To: <48A35FE6.1080903@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-ide@vger.kernel.org

> The disk is a Western Digital-1TB (new disk).
> The controller is a Promise SATA 300TX4 (4-port Serial 3G with
> NCQ/TCQ Support).

Your drive appears to fall off the bus.

> 13 10:12:20 kern: res ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x12 
> (ATA bus error)

Splat

> 13 10:12:20 kern: ata4.00: exception Emask 0x10 SAct 0x0 SErr 0x19 0002 
> action 0xa frozen
> 13 10:12:20 kern: ata4.00: hotplug_status 0x4
> 13 10:12:20 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar }

SATA link dies

> 13 10:13:25 kern: ata4: limiting SATA link speed to 1.5 Gbps

We try 1.5GBit

> 13 10:14:30 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar DevExch }
> 13 10:14:37 kern: ata4: port is slow to respond, please be patient 
> (Status 0xff)

First guess would be a dud drive but it could be power or cabling or
firmware or ...

In all the sane cases I would have expected it to recover, particularly
if it was cabling.


Alan
