From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Early ATA devices
Date: Wed, 1 Aug 2007 01:41:37 +0100
Message-ID: <20070801014137.4ab39e94@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41898 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755611AbXHAAe1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 20:34:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

So I've been doing a scan of the code versus the early ATA specifications
(English translation not the original Latin ;))

I've found a couple of problem cases we don't deal with but I'm not sure
matter, and an inconsistency

#1	We assume identify works. Early ATA actually lists this command
as optional
#2	We don't allow for INIT_DEV_PARAMS failing which it may do on
some early IDE pre ATA devices

and the inconsistency

We check ATA < 4 || non-LBA capable when deciding whether to issue
INIT_DEV_PARAMS. ATA 4+ however mandate LBA so the second case isn't
theoretically at least possible.

Aside from those cases the command issue (but not the detection paths)
appear to be clean for everything from ST412 upwards providing a drive is
being used in 16 head mode and does its own write precompensation
selection.

So in theory we can persuade libata to drive original MFM/RLL disks with
relatively few changes
