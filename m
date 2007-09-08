From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Remove sync waiting code from libata
Date: Sat, 8 Sep 2007 19:47:14 +0100
Message-ID: <20070908194714.5915dd10@the-village.bc.nu>
References: <20070907024632.GH27404@parisc-linux.org>
	<46E259DD.5090609@gmail.com>
	<20070908171731.GB6809@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46972 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751452AbXIHSjB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 14:39:01 -0400
In-Reply-To: <20070908171731.GB6809@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> async probing also keeps device numbering stable.  As long as the device
> responds within ten seconds (and the current code has half a second as
> the timeout), it'll get the same number it would have had, even though
> other hosts have successfully completed their probes during that time.

The usual probe time for a device which is spun down is nearer 30 seconds.
