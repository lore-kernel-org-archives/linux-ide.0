From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 0/7] ZPODD patches
Date: Fri, 31 Aug 2012 10:33:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208311017001.1328-100000@iolanthe.rowland.org>
References: <1346406155-4768-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1346406155-4768-1-git-send-email-aaron.lu@intel.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Fri, 31 Aug 2012, Aaron Lu wrote:

> v5:
> Add may_power_off flag to scsi device.
> Alan Stern suggested that I should not mess runtime suspend with
> runtime power off, but the current zpodd implementation made it not
> easy to seperate. So I re-wrote the zpodd implementation, the end
> result is, normal ODD can also enter runtime suspended state, but
> their power won't be removed.

This looks good.  I noticed only a few things:

In patch 5/7, your implementation of may_power_off is written in such a
way that if the drive is already powered off when userspace clears the
flag, the drive is not automatically powered back on.  Maybe this is
what you want?

In patch 1/7 you call both scsi_autopm_get_device() and 
scsi_autopm_put_device() twice in sr_check_events().  With a little 
rewriting it should be possible to call them only once.  Just replace
the "return events" lines with gotos.

What happens if you have an idle ZPODD with may_power_off clear?  A
regular ODD would get runtime-suspended.  In the same way, a ZPODD
should also be runtime-suspended but left at full power.  Does patch
7/7 work this way?  It seems to, but I can't tell for sure.

Alan Stern

