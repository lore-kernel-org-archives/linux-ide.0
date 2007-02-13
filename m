From: "Art Haas" <ahaas@airmail.net>
Subject: Re: [PATCH] libata: clear TF before IDENTIFYing
Date: Tue, 13 Feb 2007 13:38:50 -0600
Message-ID: <20070213193850.GA23600@artsapartment.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org> <45C93F1D.8090504@gmail.com> <20070207193513.GA1929@artsapartment.org> <45CA2DBF.9040403@pobox.com> <45CA3895.5010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:55769 "EHLO
	ms-smtp-01.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbXBMTi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 14:38:59 -0500
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-01.texas.rr.com (8.13.6/8.13.6) with ESMTP id l1DJcuXK019350
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 13:38:57 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <45CA3895.5010108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Wed, Feb 07, 2007 at 12:37:41PM -0800, Tejun Heo wrote:
> Some devices chock if Feature is not clear when IDENTIFY is issued.
> Set ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE for IDENTIFY such that whole
> TF is cleared when reading ID data.
> 
> Kudos to Art Haas for testing various futile patches over several
> months and Mark Lord for pointing out the fix.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Art Haas <ahaas@airmail.net>
> Cc: Mark Lord <mlord@pobox.com>
> ---
> I think this should go into -stable but a little bit hesitant because
> the code hasn't been tested widely.  This patch should really be
> harmless but who knows.  Jeff, Mark, what do you think?
> 
> [ ... snip patch ... ]

Hi.

I applied this patch for a kernel build on another PIIX based machine
around here, plus the 'ata_piix.c' patch that was tested earlier, and
the patched kernel booted without problems. I'm guessing that between
the time the patch was initially posted and now other people have tried
it out, but I can confirm the patches did not cause problems on the
machine (SMP PIII box).

A little more testing info for those wanting some results. The kernel,
btw, was Linus' git tree from this morning.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
