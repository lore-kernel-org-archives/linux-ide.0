From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PROPOSED] ata: Report 16/32bit PIO as best we can
Date: Thu, 9 Apr 2009 14:12:54 +0100
Message-ID: <20090409141254.283d9f11@lxorguk.ukuu.org.uk>
References: <20090409133221.18202.63779.stgit@t61.ukuu.org.uk>
	<49DDEF02.7090004@garzik.org>
	<20090409135323.5b2bed4b@lxorguk.ukuu.org.uk>
	<49DDF33E.6000102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59816 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759481AbZDINMn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2009 09:12:43 -0400
In-Reply-To: <49DDF33E.6000102@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> With the attached patch, you can use ->flags for the two new flags, and 
> you can set those bits in the driver where you set the other 
> ATA_FLAG_xxx bits.

Its half way but I realised there is another reason that doesn't work
(and indeed why the device private flags are asking for trouble)

What are the locking sematics for ap->flags ?
