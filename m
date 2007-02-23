From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]: pcmcia - spot slave decode flaws (for testing)
Date: Fri, 23 Feb 2007 12:08:45 +0000
Message-ID: <20070223120845.19203fcb@lxorguk.ukuu.org.uk>
References: <20070220181836.524e5f9a@localhost.localdomain>
	<45DEC5A0.7050107@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59282 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932279AbXBWLFJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 06:05:09 -0500
In-Reply-To: <45DEC5A0.7050107@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Code looks OK. Not applied due to "for testing" note.
> 
> General comment:  it might be nice to do this in the core, just as a 
> sanity check for a variety of problems, past, present and future.

We tried that with old IDE and all hell broke loose. Lots of virtual disk
stuff and raid volumes have non-unique serial numbers. We even found a
case of identically serial numbered Maxtor drives.

It needs to stay in pcmcia, which is the only place we've seen the
duplication.



Alan
