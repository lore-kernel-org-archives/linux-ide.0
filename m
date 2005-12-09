From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Thu, 8 Dec 2005 17:10:08 -0800
Message-ID: <20051208171008.47c688a9.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
	<20051202100850.11b831ea.randy_d_dunlap@linux.intel.com>
	<20051206135815.5026647c.randy_d_dunlap@linux.intel.com>
	<1133973407.43970f9fdf6dd@www.ijichi.org>
	<20051207091639.00a7a232.randy_d_dunlap@linux.intel.com>
	<1133976270.43971ace1c015@www.ijichi.org>
	<20051207103449.2922faf3.randy_d_dunlap@linux.intel.com>
	<1134035010.4398004299a80@www.ijichi.org>
	<20051208161601.14a07dca.randy_d_dunlap@linux.intel.com>
	<1134087622.4398cdc67c72b@www.ijichi.org>
	<20051208170302.4acc426d.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:34177 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750727AbVLIBGu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Dec 2005 20:06:50 -0500
In-Reply-To: <20051208170302.4acc426d.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: dom@ijichi.org, linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

On Thu, 8 Dec 2005 17:03:02 -0800
Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:

> 
> > > > > OK, well, that's a little better, but the top of the backtrace
> > > > > is where the nitty gritty info is.
> > > > > Is it possible for you to use any other method of capturing
> > > > > more fault messages, like serial console, netconsole,
> > > > > or even higher resolution video (and smaller font)
> > > > > so that I can see where the fault is actually happening?
> > > > >
> > > > > Thanks.
> > > >
> > > > ok.  eye-watering font, but here's what it says:
> > > 
> > > Thanks for doing that.
> > > Did you enable ACPI debug output?  If so, how?
> > > (in .config or by modifying a header file?
> > > if by modifying a header file, please tell us
> > > exactly.)
> > 
> > ACPI_DEBUG in .config and also applied your debug patch
> 
> Yes, easy to reproduce with CONFIG_ACPI_DEBUG=y.
> 
> My new code frees a buffer that it does not own.
> 
> Just comment out or delete line 156 in drivers/scsi/ata_acpi.c,
> which is:
> 		ACPI_MEM_FREE(dinfo);
> 
> It shouldn't be there.

That's not quite correct.  It will boot & run with that
change, but now the buffer isn't being freed at all.
I'll rethink that and post a patch.

---
~Randy
