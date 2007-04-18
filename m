From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Loud "pop" coming from hard drive on reboot
Date: Wed, 18 Apr 2007 23:31:14 +0200
Message-ID: <200704182331.14515.bzolnier@gmail.com>
References: <461D4E2C.6000704@redhat.com> <46254416.6090202@rtr.ca> <4625AF20.7050904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:35776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992714AbXDRVVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 17:21:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so504695uga
        for <linux-ide@vger.kernel.org>; Wed, 18 Apr 2007 14:21:16 -0700 (PDT)
In-Reply-To: <4625AF20.7050904@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Chuck Ebbert <cebbert@redhat.com>, emisca <emisca.ml@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>


On Wednesday 18 April 2007, Tejun Heo wrote:
> Mark Lord wrote:
> > Chuck Ebbert wrote:
> >> Mark Lord wrote:
> >>> I'll patch it locally on my own machines, but what about the tens
> >>> of thousands of other Seagate notebook drive owners out there?
> >>>
> >>
> >> This is a problem with Seagate specifically, spinning back up
> >> on receipt of some command after spindown?
> > 
> > No, they just seem to be affected worse by it than some other brands.
> > The bug is that libata/SCSI now spin-down the drive before the distro's
> > scripts are done with it, so it spins down, and then gets spun up again
> > by the distro, and then spun down again by the distro.
> > 
> > And along the way, one/both of the two causes a full mechanism "park",
> > which is hard on things if abused (like this).
> > 
> > Or at least that's what I recall for it.  Tejun?
> 
> This really isn't a regression.  It's been always like that with libata.

Tejun, it is a regression over IDE subsystem
(so all PATA and some SATA also).

Dave/Chuck, this also seems like a FC7 regression
(because of the libata PATA switch).

>  libata doesn't make devices go into standby mode and shutdown(8) does
> it for libata.  The problem here is that libata does issue
> SYNCHRONIZE_CACHE on shutdown.  So, the sequence of event is...
> 
> 1. shutdown(8) issues SYNCHRONIZE_CACHE followed by STANDBY_NOW
> 2. kernel shutdown starts
> 3. libata shutdown issues SYNCHRONIZE_CACHE
> 4. power goes off
> 
> Some drives seem to spin up at step #3 even when its cache is clean and
> power goes off right after the disk finishes the command.  So, it's
> really bad when it happens - spin down, spin up followed by immediate
> power off.
> 
> SCSI part of the fix is queued in scsi-misc-2.6 tree and libata-dev part
> is acked and waiting to be merged, so the fix will be available in
> 2.6.22.  However, it's disabled by default to remain compatible with the
> current behavior and requires userland change to fully fix the problem.
