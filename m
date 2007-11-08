From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/4] libata sata_qstor nuke idle state
Date: Thu, 8 Nov 2007 13:14:10 -0500
Message-ID: <20071108181410.GE3491@havoc.gtf.org>
References: <4731DF06.3050202@rtr.ca> <4731DF57.9010701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:33092 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758384AbXKHSOL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 13:14:11 -0500
Content-Disposition: inline
In-Reply-To: <4731DF57.9010701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Nov 07, 2007 at 10:52:55AM -0500, Mark Lord wrote:
> sata_qstor nuke idle state.
> 
> We're really only ever in one of two hardware states:  packet, or mmio.
> Get rid of unnecessary "qs_state_idle" state.
> 
> This belongs in 2.6.24.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

applied patches 2-4

Please put "this belongs in 2.6.24" comment behind the "---" separator,
as described in Documentation/SubmittingPatches, so that Linus's patch
merging tools automatically snip such comments.

	Jeff


