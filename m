From: "Andrew Chew" <achew@nvidia.com>
Subject: IDE class driver with SATA controllers
Date: Tue, 31 Aug 2004 14:03:41 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate02.nvidia.com ([216.228.112.145]:25869 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S269176AbUHaVDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2004 17:03:47 -0400
Content-class: urn:content-classes:message
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, B.Zolnierkiewicz@elka.pw.edu.pl

In my perusal of the kernel code, I noticed that the IDE subsystem
handles IDE controllers at legacy IO ports if no other driver claims
them (albeit without DMA support).  I was wondering if it could be
extended to support SATA controllers 
that aren't mapped to legacy I/O ports.

I'm aware of the idex=base,ctl,irq kernel option, but I can't seem to
get this to work with my SATA controller (using ide6=base,ctl,irq).

The reason I'm asking is because it would seem like a good thing to have
SATA controllers that are broadly compatible with IDE to be usable
without having to modify the core kernel drivers.  This would at least
allow a user to perform a Linux install on a SATA drive even if that
kernel doesn't have explicit support for the SATA controller.  A
kernel/driver update can then take place after the install.

Also, are there plans for libata to take over the IDE class driver
functionality in the future?
