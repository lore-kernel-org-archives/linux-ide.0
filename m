From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
Date: Wed, 11 Apr 2007 16:23:16 +0100
Message-ID: <20070411162316.41a913e6@the-village.bc.nu>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
	<461BB8C7.9050900@garzik.org>
	<20070410172942.7f63d49c@the-village.bc.nu>
	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
	<20070411094702.74774d25@the-village.bc.nu>
	<1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37292 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753012AbXDKPU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 11:20:28 -0400
In-Reply-To: <1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael <michaelzwrk@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

On Wed, 11 Apr 2007 17:10:12 +0200
Michael <michaelzwrk@gmail.com> wrote:

> I see.
> The problem is I am constrained to 2.6.14 kernel.

Make sure you backport any relevant network security fixes in that case.

If you are working to 2.6.14, then your easiest route may be to write a
polling CF driver from scratch. If you only have to support PIO and you
only do ATA not ATAPI then it isn't a large amount of code.

Alan
