From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: [patch ide-dev 7/9] convert disk flush functions to use REQ_DRIVE_TASKFILE
Date: Mon, 28 Feb 2005 17:17:06 +0100
Message-ID: <200502281717.06753.bzolnier@elka.pw.edu.pl>
References: <Pine.GSO.4.58.0502241545041.13534@mion.elka.pw.edu.pl> <200502271739.16076.bzolnier@elka.pw.edu.pl> <422334CB.4010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:10655 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261673AbVB1QPh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 11:15:37 -0500
In-Reply-To: <422334CB.4010408@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 28 February 2005 16:12, Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 27 February 2005 05:51, Tejun Heo wrote:
> > 
> >> Hello, Bartlomiej,
> >>
> >>On Thu, Feb 24, 2005 at 03:45:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> >>
> >>>Original patch from Tejun Heo <htejun@gmail.com>,
> >>>ported over recent IDE changes by me.
> >>>
> >>>* teach ide_tf_get_address() about CHS
> >>
> >> IMHO, as patch #4 moves LBA/CHS selection into taskfile, I think
> >>using taskfile->device to determine whether LBA or CHS is used instead
> >>of drive->select makes more sense.
> >>
> >>
> >>>* use ide_tf_get_address() and remove ide_get_error_location()
> >>
> >> IIRC, error responses for WIN_FLUSH_CACHE is in CHS if the LBA bit in
> >>the device register is zero; likewise, in LBA if the LBA bit is one.
> >>I don't know if drives can change the LBA bit when posting error
> >>result.  The original code reads back the device register on error to
> >>determine whether to interpret the error response in CHS or LBA.
> >>(ATA/ATAPI-6 isn't clear on this issue.  Is ATA/ATAPI-7 updated?)
> > 
> > 
> > The thing is that LBA bit is marked as "na" for FLUSH CACHE
> > in all ATA/ATAPI drafts that I've seen.
> > 
> 
>   Yeah, and nothing is mentioned about the LBA bit in the normal output 
> description even though the lcyl, hcyl.. registers are described to be 
> in either form of CHS or LBA.  Strange...
> 
> > 
> >> This change combined with patch #2/#5 can make error address
> >>calculation wrong on LBA28 drives.  I think setting the LBA bit in the
> >>device register according to the drive's addressing mode in
> >>ide_task_init_flush() and use taskfile->device in ide_tf_get_address()
> >>should fix the problem.
> > 
> > 
> > I will change the code to set LBA bit, it shouldn't hurt. :-)
> 
>   IMHO, there can be cases where just setting the LBA bit isn't enough. 
>   Theoretically, drives can report CHS and clear the LBA bit in the 
> device register even when the LBA bit was set when the command was 
> issued.  Maybe the intention of the original code was to handle 
> something like this?

/me suspects that disks that support LBA always report LBA and disks
that use only CHS always report CHS but this is pure speculation
