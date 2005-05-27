From: Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 09:15:52 +0200
Message-ID: <20050527071551.GM1435@suse.de>
References: <20050526140058.GR1419@suse.de> <42964498.9080909@rtr.ca> <20050527062802.GH1435@suse.de> <4296C505.2030806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:32715 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261929AbVE0HO5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2005 03:14:57 -0400
Content-Disposition: inline
In-Reply-To: <4296C505.2030806@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Yeah, I'm not a huge fan of the need for the above code... If every qc
> >was tied to a SCSI command, we could just ask for a later requeue of the
> >request as is currently done with NCQ commands. Alternatively, we could
> >add an internal libata qc queue for postponing these commands. That
> >would take a little effort, as the sync errors reported by
> >ata_qc_issue() would then be need to signalled async through the
> >completion callback instead.
> >
> >Jeff, what do you think?
> 
> Just use the SCSI layer for requeueing.  That's what I intended.

Yep, that is what I'm doing for SCSI originated commands.

> Every qc that matters can be requeued.  Just don't worry about
> non-queued, non-fast-path commands.  They are typically used in
> functions that will immediately notice a failure, and handle it
> accordingly.

So the current wait-around stuff is ok with you?

-- 
Jens Axboe

