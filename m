From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] new Power Management for libata
Date: Tue, 13 Jun 2006 21:25:46 -0400
Message-ID: <448F659A.5010606@pobox.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61097 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964865AbWFNBZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2006 21:25:51 -0400
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This patchset implements new Power Management for libata.  Currently,
> only controller-wide suspend and resume are supported.  No per-device
> power management yet.  Both memsleep and disksleep work on supported
> controllers.

I suppose this is just an RFC?

We don't want to lose to SCSI device suspend, so merging that would be a 
regression AFAICS?  While we're still married to the SCSI layer, we need 
to do suspend through sd.c and similar paths.

I also wonder if any developers or users make use of the ability to 
suspend/resume individual pieces of hardware, as is (somewhat) supported 
in ata_piix in 2.6.17-rcX.

	Jeff



