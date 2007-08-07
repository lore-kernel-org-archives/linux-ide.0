From: Thomas Renninger <trenn@suse.de>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 16:45:25 +0200
Message-ID: <1186497925.8780.78.camel@queen.suse.de>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>
	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>
	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>
	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>
	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>
	 <46B8140E.3000509@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:43461 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbXHGOp2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 10:45:28 -0400
In-Reply-To: <46B8140E.3000509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Michael Sedkowski <sedmich@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 2007-08-07 at 15:41 +0900, Tejun Heo wrote:
> Robert Hancock wrote:
> > Tejun Heo wrote:
> >> Michael Sedkowski wrote:
> >>>> Hmmm... If the problem only shows up on nx6325, it might be that
> >>>> ACPI is
> >>>> pulling unnecessary stunt.  Please apply the attached patch and report
> >>>> when the disk spins down and up.
> >>> Disk spins down on "Pre-shutdown prepare" and then goes up and down on
> >>> "Power down".
> >>
> >> Oh... crap, so acpi wants to sync cache on shutdown.  I wonder whether
> >> it spins down the disk correctly.  Does emergency unload count increase
> >> after each power down?  Also, please post the result of 'dmidecode'.
> > 
> > I know that my Compaq X1000-series laptop does do some kind of ACPI
> > games with the disk on ACPI power off (I assume it is putting the disk
> > in standby before power-off at least). It also does this if you boot
> > into DOS, GRUB, etc. and then hit the power button. Could be if the disk
> > is dumb enough to spin up for sync cache and standby when there is
> > nothing to flush, and the kernel does its own standby, this could cause
> > an extra spinup/down..
> 
> Yeah, that seems to be what's going on.  I don't think we have any other
> choice than blacklisting those notebooks.  This is a mess.  How does the
> other OS cope with this?
> 
> I'm thinking about using DMI vendor/product match to detect the affected
> systems but I think it would be better to match the ACPI implementation
> directly.  Is there a way to match specific ACPI implementation?

I opened a new bug to collect dmi and acpidump outputs:
http://bugzilla.kernel.org/show_bug.cgi?id=8855
Thought this is the easiest way to get this all a bit together.

Would be great if you tell all affected people and let them attach
dmidecode and acpidump output there...

Thanks,

    Thomas

