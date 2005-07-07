From: Jens Axboe <axboe@suse.de>
Subject: Re: sata_sil 3112 activity LED patch
Date: Thu, 7 Jul 2005 17:11:10 +0200
Message-ID: <20050707151110.GF24401@suse.de>
References: <20050706025136.GA15493@alumni.uwaterloo.ca> <42CBF3A1.1020508@pobox.com> <20050707124702.GB24401@suse.de> <20050707142301.GA11182@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:47072 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261424AbVGGPJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 11:09:41 -0400
Content-Disposition: inline
In-Reply-To: <20050707142301.GA11182@alumni.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aric Cyr <acyr@alumni.uwaterloo.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Jul 07 2005, Aric Cyr wrote:
> > There's also an existing variant of this in the block layer, the
> > activity_fn, that we use on the ibook/powerbook to use the sleep led as
> > an activity light. Just in case you prefer that to overloading the bmdma
> > start/stop handlers.
> 
> You suggestion at first looked to be incredibly nice... until I looked
> at how much implementation was required.  I am considering trying it,
> but I cannot find a place for an sata driver to call the
> blk_queue_activity_fn() with meaningful parameters during init.
> 
> On a second look, I guess I would have to override
> ata_scsi_slave_config() in the driver and hook up the activity light
> there.  This would be fine I guess.  Unless I am interpreting this
> incorrectly, however, I would need to use a timer or something to turn
> the light back off?  I'm probably missing something, so is there a
> simpler way to do this?

Hmm yes, it will require more work for you. It should be cleaned up a
little to pass in a START/STOP variable and handle everything in the
block layer instead. You probably just want to continue using the bmdma
hooks now, that is actually a fine implementation imo.

-- 
Jens Axboe

