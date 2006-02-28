From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Date: Tue, 28 Feb 2006 11:22:02 -0800
Message-ID: <20060228112202.5355ca43.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
	<20060228114500.GA4057@elf.ucw.cz>
	<44043B4E.30907@pobox.com>
	<20060228041817.6fc444d2.akpm@osdl.org>
	<440461AA.1090907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:54690 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWB1TTw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 14:19:52 -0500
In-Reply-To: <440461AA.1090907@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: akpm@osdl.org, jgarzik@pobox.com, pavel@ucw.cz, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 28 Feb 2006 09:43:54 -0500
Mark Lord <liml@rtr.ca> wrote:

> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> >> Fine-grained 
> >>  message selection allows one to turn on only the messages needed, and 
> >>  only for the controller desired.
> > 
> > Except
> > 
> > - There's (presently) no way of making all the messages go away for a
> >   non-debug build.
> 
> Agreed.  We need a way to make them all really go away
> for embedded builds -- memory matters there.

That's a libata infrastructure issue, not an ATA-ACPI issue.
I'll go with whatever $maintainer decides.

~Randy
