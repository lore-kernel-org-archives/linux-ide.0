From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Tue, 15 Jan 2008 11:35:52 +0000
Message-ID: <20080115113552.75731bf8@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080115025435.1e21b703.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43127 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750708AbYAOLim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 06:38:42 -0500
In-Reply-To: <20080115025435.1e21b703.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > [ 9031.028000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
> > frozen
> > [ 9031.028000] ata1.00: cmd c8/00:08:90:ca:ce/00:00:00:00:00/e0 tag 0 cdb 0x0 
> > data 4096 in
> > [ 9031.028000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 
> > (timeout)

We got bored of waiting for the drive to respond to our request. I still
think we have the timeouts too short or are accounting queue time
somewhere we shouldn't as there a few other examples where we don't allow
long enough for a drive to retry out and fail with a media error on a bad
sector.

Alan
