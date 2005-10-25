From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH/RFC] SCSI mid-layer suspend/resume
Date: Tue, 25 Oct 2005 14:25:29 -0700
Message-ID: <20051025142529.7b23bbc0.randy_d_dunlap@linux.intel.com>
References: <20051024160531.7d879a7c.randy_d_dunlap@linux.intel.com>
	<435D6E47.1030409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:13457 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932387AbVJYVXt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Oct 2005 17:23:49 -0400
In-Reply-To: <435D6E47.1030409@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, axboe@suse.de, hch@lst.de

On Mon, 24 Oct 2005 19:29:11 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Randy Dunlap wrote:
> > Jeff's comments[2]:
> > - Issue hardware or software reset on suspend (not done).
> 
> Note that's an ATA-specific comment.

So it is.  Thanks for the reminder.

How/where can I put low-level driver specific suspend/resume
code, for PATA or SATA or usb-storage or ieee1394 or SCSI?
What is the linkage (chain, pointers, whatever) thru the
SCSI stack to each driver's "methods"?  Or do those not
exist yet?

---
~Randy
