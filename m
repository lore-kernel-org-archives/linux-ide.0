From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [4/12]
Date: Sun, 13 Jun 2004 10:58:59 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1087142338.8210.178.camel@gaston>
References: <200406111755.02325.bzolnier@elka.pw.edu.pl>
	 <20040611181106.GB12953@linux-sh.org>
	 <200406112047.58373.bzolnier@elka.pw.edu.pl>
	 <20040611190639.GC12953@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45250 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265198AbUFMQEb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jun 2004 12:04:31 -0400
In-Reply-To: <20040611190639.GC12953@linux-sh.org>
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>


> It's used for the DMA channel number, or NO_DMA for falling back on PIO.

It is a chipset/platform specific information and has no meaning outside
of the chipset driver, thus it should be in the chipset local state data
structures and not in the common one.

Ben.


