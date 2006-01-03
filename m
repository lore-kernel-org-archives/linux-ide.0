From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 13:00:27 -0800
Message-ID: <20060103130027.44bb8897.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de>
	<20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<20060103200603.GA3472@suse.de>
	<20060103201312.GB3472@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:50591 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S964787AbWACU7t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 15:59:49 -0500
In-Reply-To: <20060103201312.GB3472@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jhpark@tuhep.phys.tohoku.ac.jp, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On Tue, 3 Jan 2006 21:13:12 +0100
Jens Axboe <axboe@suse.de> wrote:

> On Tue, Jan 03 2006, Jens Axboe wrote:
> > On Tue, Jan 03 2006, Randy Dunlap wrote:
> > > 
> > > Ugh.  So the ACPI taskfile data looks like crap??
> > > I guess that I'll just invalidate gtf_address (set to NULL)
> > > if gtf_length looks invalid.  Is there something better to do?
> > 
> > Bugger me, I'm totally acpi ignorant. But did you see my note that if I
> > clear gtf_address before calling into the function (where you pass it by
> > reference), the problem goes away? That smells more like return-on-error
> > without setting it at all, hence kfree() blows up when passed a bogus
> > stack filled variable.

Yes, I'll just init gtf_length and gtf_address to 0
in do_drive_get_GTF().

> > > Jae-hyeon,
> > > 
> > > Please send me a dump of your ACPI tables (acpidump).
> > > 'acpidump' is at
> > > http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ .
> > > Use the latest pmtools tarball.
> > 
> > I've attached mine as well, in case they are useful.

At least it shows that there is no _GTF at all for SATA devices,
only for PATA (which my patch does not address).

> > > Jens, could you see that <gtf_address> your system is
> > > getting that is invalid?
> > 
> > Sure, will reboot it after posting this message.
> 
> It's just 0 (because I fill it as such). do_drive_get_GTF() looks
> suspicious, at least with noacpi != 0 it will return success without
> filling gtf_address. Perhaps you want to treat that as an error, or
> check for it earlier?
> 
> Anyways, I'm pretty sure do_drive_get_GTF() needs some fixing. I'll
> leave that to you, let me know if you want me to test anything.

Yes, basic error on my part.  I've updated the patch series
and rediffed it against 2.6.15.  If one of you could test it,
that would be great (Jae-hyeon or Jens).

New patch series is at
  http://www.xenotime.net/linux/SATA/2.6.15/
with a combined patch at
  http://www.xenotime.net/linux/SATA/2.6.15/libata-combine-2615.patch

If you don't want to revert the old patchset and apply the new
one, you can just do this:

	*gtf_length = 0;
	*gtf_address = 0UL;
at the top of do_drive_get_GTF().


Thanks for your help.
---
~Randy
