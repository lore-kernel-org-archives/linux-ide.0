From: Jens Axboe <axboe@suse.de>
Subject: Re: Happy New Year, libata hackers
Date: Tue, 3 Jan 2006 19:57:03 +0100
Message-ID: <20060103185702.GX2772@suse.de>
References: <43BAB977.3010203@pobox.com> <20060103183328.GW2772@suse.de> <43BAC822.6090501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:22309 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932484AbWACSzN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 13:55:13 -0500
Content-Disposition: inline
In-Reply-To: <43BAC822.6090501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Tue, Jan 03 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Tue, Jan 03 2006, Jeff Garzik wrote:
> >
> >>Port multiplier and NCQ (queueing) support are the two other big to-do 
> >>items on the list.
> >
> >
> >I'll get NCQ updated and tested again in the not-so-distant future.
> 
> FWIW I've kept it moderately up-to-date in the 'ncq' branch.  It's 
> definitely moldy, with a few FIXMEs in libata-scsi's read/write 
> translation, for example, which is missing the NCQ portion of that code.
> 
> 	Jeff

Yeah that, and Tejun had some good updates for it as well. I'll take a
look as soon as I get some time to do so.

-- 
Jens Axboe

