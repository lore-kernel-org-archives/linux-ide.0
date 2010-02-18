From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC 1/4] libata: cache device select
Date: Thu, 18 Feb 2010 10:16:03 +0000
Message-ID: <20100218101603.23c16786@lxorguk.ukuu.org.uk>
References: <20100217130847.16338.55586.stgit@localhost.localdomain>
	<4B7CCC7E.3060108@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41566 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753938Ab0BRKTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2010 05:19:20 -0500
In-Reply-To: <4B7CCC7E.3060108@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Alan Cox <alan@linux.intel.com>, jeff@garzik.org.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

O> I totally agree with this patch, but question the timings used to justify it.
> Surely the overhead is only 1-2usec for the case where the device
> is the one that was already selected (on a "smart" interface) ?

IFF you have a smart interface. A lot of the controllers in the PCI space
don't appear to be that clever.

> And for the case where the currently selected device is different
> than the desired device (the 1msec case), this patch makes little/no difference?

Correct, but even with two devices per cable (which is not the most
common setup) you win. Worst case (which I've never seen) you draw.

Alan
