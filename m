From: Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 10:00:14 +0200
Message-ID: <20050527080014.GS1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de> <4296CC5C.5000807@pobox.com> <20050527073307.GP1435@suse.de> <4296D16F.9030805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:19427 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261967AbVE0H7K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2005 03:59:10 -0400
Content-Disposition: inline
In-Reply-To: <4296D16F.9030805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Fri, May 27 2005, Jeff Garzik wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
> >>>_after_ successful ap->ops->qc_issue(qc) and clear it _after_
> >>>__ata_qc_complete(qc) then I can just use that bit and kill
> >>>ATA_QCFLAG_ACCOUNT.
> >>>
> >>>What do you think?
> >>
> >>Fine with me.
> >>
> >>Keep in mind that the attached patch was applied recently...
> >
> >
> >Yeah, the two hunks from the ncq patch would look like this then. Ok?
> 
> ACK (modulo my distaste for 'depth' and 'ncq_depth', of course... :))

Ok, lets get that fixed then... Would you like just a single
ap->queue_depth and a ATA_DFLAG_NCQ_IN_FLIGHT type flag instead?

-- 
Jens Axboe

