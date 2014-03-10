From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 3/3] scsi: async sd resume
Date: Mon, 10 Mar 2014 16:59:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1403101658490.5966-100000@netrider.rowland.org>
References: <CAPcyv4ik5GhaqZsBCA+LJ5WN=bCBPqjHgWwud1PrrKB4LarBOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58353 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753430AbaCJVAA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2014 17:00:00 -0400
In-Reply-To: <CAPcyv4ik5GhaqZsBCA+LJ5WN=bCBPqjHgWwud1PrrKB4LarBOA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tejun Heo <tj@kernel.org>, James Bottomley <JBottomley@parallels.com>, Len Brown <len.brown@intel.com>, linux-scsi <linux-scsi@vger.kernel.org>, Phillip Susi <psusi@ubuntu.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>

On Mon, 10 Mar 2014, Dan Williams wrote:

> > The only thing which is a bit concerning is that this doesn't have any
> > throttling mechanism for simultaneous wakeups.  Would this be able to
> > blow up the PSU if used on a machine with a lot of spindles?
> 
> Good point.  The primary benefit is completing userspace resume
> without needlessly waiting for the disk.  For now I think it would be
> enough to have a mutex to maintain one disk at a time.  We can follow
> on later with something more complex to enable a max simultaneous
> spin-up tunable.

Why?  The existing code doesn't have anything like that.

Alan Stern

