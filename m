From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression] 2.6.25-rc4-git3: Handling of audio CDs broken on pata_ali
Date: Mon, 10 Mar 2008 22:36:30 +0100
Message-ID: <200803102236.30790.rjw@sisk.pl>
References: <200803082246.47987.rjw@sisk.pl> <47D4E78A.10507@gmail.com> <47D523A1.7070808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57984 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbYCJVhs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 17:37:48 -0400
In-Reply-To: <47D523A1.7070808@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday, 10 of March 2008, Tejun Heo wrote:
> Tejun Heo wrote:
> > Tejun Heo wrote:
> >> Rafael J. Wysocki wrote:
> >>>>> where ata1 is:
> >>>>>
> >>>>> scsi0 : pata_ali
> >>>>> scsi1 : pata_ali
> >>>> Oh, is it only with audio CDs? I am unable to use DVD on pata_ali in DMA at
> >>>> all. Have you tried to disable ATAPI DMA (libata.dma=1)?
> >>> Data CDs seem to work fine here.
> >> * Does booting into runlevel 1, putting in an audio cd and running
> >> cdparanoia give the same result?
> >>
> >> * Does setting module parameter libata.force to "1.00:pio4" make any
> >> difference?
> > 
> > Oh, never mind.  I have a hunch.  I'll report back in a while.
> > 
> 
> Does the attached patch fix the problem?

Yes, it does.  Please push upstream.

Thanks,
Rafael
