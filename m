From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Full hostlock pushdown available
Date: Tue, 2 Nov 2010 10:21:11 +0100
Message-ID: <20101102092111.GK25817@basil.fritz.box>
References: <20101028150508.GA2385@basil.fritz.box>
 <4CCD5F7F.8020808@panasas.com>
 <tkrat.c4793af298337eff@s5r6.in-berlin.de>
 <4CCE271D.7040400@garzik.org>
 <20101101135338.GA25817@basil.fritz.box>
 <4CCEE33F.5030300@garzik.org>
 <20101101175742.GG25817@basil.fritz.box>
 <4CCF0DFE.4050106@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:33154 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab0KBJVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2010 05:21:18 -0400
Content-Disposition: inline
In-Reply-To: <4CCF0DFE.4050106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andi Kleen <andi@firstfloor.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Boaz Harrosh <bharrosh@panasas.com>, James.Bottomley@suse.de, nab@linux-iscsi.org, linux-scsi@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

> It's a bit disappointing that libata's lock profile in this patch is
> quite different than that of current upstream: with your patch,
> libata holds the scsi host lock for a considerably longer period of
> time, while also holding the ATA port/host spinlock.

The goal here is not really what comes out of this patch,
but dropping the host lock completely. This is just the first step.

> 
> IOW, it's doing the exact opposite of what the previous code did
> (release the scsi host lock, before acquiring the ATA port/host
> spinlock), not at all an equivalent transformation.
> 
> The following sequence would seem to better preserve the existing
> lock profile, correct?

Possibly, but it's not a mechanic change.

-Andi

