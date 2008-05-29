From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 15:39:21 +0200
Message-ID: <20080529133921.GB9268@homac.suse.de>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <20080529133302.GA9268@homac.suse.de> <20080529133201.GA22476@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756353AbYE2Ngr@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080529133201.GA22476@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Thu 29. May - 14:32:01, Matthew Garrett wrote:
> On Thu, May 29, 2008 at 03:33:02PM +0200, Holger Macht wrote:
> 
> > Can you please give a bit more details? Does your userspace react on the
> > eject request? I tested with Thinkpads, too.
> 
> No, I'm not doing anything with userspace - just pulling the drive out 
> directly. I'm looking into it now.

This was one of my test scenarios. Just a hint for debugging, before my
patch, HAL accessed /dev/sr0 directly after removing the device, and that
caused the lockup. Hopefully that doesn't bite us again...

 - Holger
