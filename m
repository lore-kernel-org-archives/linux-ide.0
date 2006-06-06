From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Tue, 06 Jun 2006 08:50:48 -0700
Message-ID: <1149609048.13089.8.camel@whizzy>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy>
	 <4484D244.3010905@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29742 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751313AbWFFPnI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jun 2006 11:43:08 -0400
In-Reply-To: <4484D244.3010905@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Mon, 2006-06-05 at 17:54 -0700, Jeremy Fitzhardinge wrote:
> Kristen Accardi wrote:
> > I was able to reproduce this issue on an x40 - I found a bug in the
> > code, however, when I fixed that bug I seem to have uncovered another
> > one.  I'll send you a patch hopefully in the next day or so.
> >   
> Great, looking forward to it.  Do you know if this will properly 
> disconnect the optical drive, or does that need some more ata/ide support?
> 
> Thanks,
>     J

I don't know - this is something I am trying to look into, but don't
really have the equipment to test right now.  ASAIK, minimally you will
need to have the very latest libata stuff that includes some kind of
hotplug capability (I've copied the linux-ide list in case they can
answer this question).  I don't know if this is actually in -mm or in
some separate tree.  I'd like to work with you on making this work if
you are willing - hopefully it will "Just Work", but if not perhaps we
can figure out what needs to be done.

Thanks,
Kristen
