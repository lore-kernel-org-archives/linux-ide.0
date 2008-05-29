From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 19:29:16 +0100
Message-ID: <20080529192916.0c1cdb02@core>
References: <20080529161453.24735.805.stgit@core>
	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>
	<483EEBE5.5030708@garzik.org>
	<alpine.LFD.1.10.0805291102370.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58573 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbYE2SnU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 14:43:20 -0400
In-Reply-To: <alpine.LFD.1.10.0805291102370.2958@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> So it's "ata_sdd_sync()" that I think is bogus. Based on its name alone, 
> it shouldn't have a delay in it (except, as mentioned, possibly for the 
> fallback case where no port can be used for reading).

It should indeed not have the delay in it.

Alan
