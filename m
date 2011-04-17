From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Sun, 17 Apr 2011 18:58:24 -0500
Message-ID: <1303084704.2583.23.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46087 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab1DQX61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2011 19:58:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: 622997@bugs.debian.org

I've got a parisc system where the DVD drive is hardwired to a silicon
image controller:

00:02.0 IDE interface: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to
ATA Host Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Silicon Image, Inc. SiI 0649 Ultra ATA/100 PCI to ATA
Host Controller
        Flags: bus master, medium devsel, latency 64, IRQ 69
        I/O ports at 0d18 [size=8]
        I/O ports at 0d24 [size=4]
        I/O ports at 0d10 [size=8]
        I/O ports at 0d20 [size=4]
        I/O ports at 0d00 [size=16]
        Capabilities: [60] Power Management version 2
        Kernel driver in use: pata_cmd64x

The specific problem is that any access to the registers where the
secondary port should be causes an instant fault on the box (I think
because the second port just isn't wired up internally, so the memory
doesn't respond), so the default libata-sff driver that pata_cmd64x is
attached to causes this by insisting on probing both ports.

I can get all of this working by fixing up all the hard coded knowledge
in libata-sff only to use a single port.

However, I can't fix the libata-sff driver until I know how to tell
there's only one port wired.  Does anyone with cmd649 knowledge have any
idea how I might tell this?

James


