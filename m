From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 1/2] sgiioc4: sgiioc4_read_status drive busy check fix
Date: Thu, 20 Nov 2008 01:43:46 -0800
Message-ID: <20081120094346.GL262904@sgi.com>
References: <200809282348.52748.sshtylyov@ru.mvista.com> <200810031849.11365.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:46491 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752920AbYKTJnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 04:43:49 -0500
Content-Disposition: inline
In-Reply-To: <200810031849.11365.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylylov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Fri, Oct 03, 2008 at 06:49:10PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 28 September 2008, Sergei Shtylylov wrote:
> > Fix the drive non-busy criterion used by sgiioc4_read_status(): neither of the
> > bits it expects to be set guarantees that the drive is not busy (and might be
> > interrupting), only the BSY bit itself being zero gurantees that.
> > While at it, use ATA_BUSY instead of hardcoded value everywhere...
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> applied patches #1-2

I finally got around to trying these patches, and they work fine.  Thanks
for the cleanups, Sergei!

Acked-by: Jeremy Higdon <jeremy@sgi.com>
