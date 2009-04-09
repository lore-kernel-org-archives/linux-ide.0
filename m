From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 32-bit IO to-do item...
Date: Thu, 9 Apr 2009 11:22:00 +0100
Message-ID: <20090409112200.4830f5c2@lxorguk.ukuu.org.uk>
References: <49DD86D4.3090304@garzik.org>
	<20090409095415.585cc759@lxorguk.ukuu.org.uk>
	<49DDC476.3080604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54053 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753027AbZDIKVs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 06:21:48 -0400
In-Reply-To: <49DDC476.3080604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

> I'd say pio-over-dma returns '1', so as to imply '0' meaning boring, 
> slow, legacy compatible 16-bit I/O.  But it's a good question....

And 8bit transfers ?

The more I look at this the more I think we should just admit it was a
dumb interface and do something different. To start with do we mean the
controller-disk transfer is 32bit (meaningful only in some early proto
IDE stuff), or the controller-fifo transfer is 32bit (which is
meaningless as actually its posted)

