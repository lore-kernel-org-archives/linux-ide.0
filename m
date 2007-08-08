From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 8 Aug 2007 14:27:00 +0200
Message-ID: <200708081427.00905.rjw@sisk.pl>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no> <fa.A9df+SR4FMdI7qZmsXY0xFyurbU@ifi.uio.no> <46B90D01.6010703@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38453 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759176AbXHHMRY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 08:17:24 -0400
In-Reply-To: <46B90D01.6010703@shaw.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Tejun Heo <htejun@gmail.com>, Michael Sedkowski <sedmich@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, 8 August 2007 02:23, Robert Hancock wrote:
> Henrique de Moraes Holschuh wrote:
> > On Tue, 07 Aug 2007, Tejun Heo wrote:
> >> Henrique de Moraes Holschuh wrote:
> >>> On Tue, 07 Aug 2007, Tejun Heo wrote:
> >>>> Michael Sedkowski wrote:
> >>>>>> Hmmm... If the problem only shows up on nx6325, it might be that ACPI is
> >>>>>> pulling unnecessary stunt.  Please apply the attached patch and report
> >>>>>> when the disk spins down and up.
> >>>>> Disk spins down on "Pre-shutdown prepare" and then goes up and down on
> >>>>> "Power down".
> >>>> Oh... crap, so acpi wants to sync cache on shutdown.  I wonder whether
> >>>> it spins down the disk correctly.  Does emergency unload count increase
> >>>> after each power down?  Also, please post the result of 'dmidecode'.
> >>> You know, this actually make a lot of sense, and one can't even complain
> >>> about firmware that pulls that off.
> >> Well, I'm complaining.  I think the problem here is that it isn't clear
> >> which one is who's responsibility.  There's a Korean saying which
> > 
> > The BIOS *has* to do it when in DOS mode, the HD manuals are very very clear
> > about it.  Doing it through ACPI ATA objects is at least non-broken as far
> > as these things go, as one knows when to do it directly ("non-ACPI mode"),
> > and one doesn't talk to the disk directly.
> > 
> >> approximately translates into "if you have too many boatmen on a ship,
> >> it goes to mountain".  We also have a bunch of Toshiba laptops which
> > 
> > Yeah, that's a problem.  But we can avoid it if we start snooping what ACPI
> > is asking us to deliver to the disks, which IMO is an extremely good idea
> > anyway.
> 
> Problem is I don't think we can do this. As far as I can tell, on my 
> Compaq at least, it's not being done through ACPI AML in the DSDT, like 
> in the _PTS function (which the kernel executes and can snoop), but when 
> we actually do the power-off we write a value to a magic ACPI register. 
> That likely triggers the BIOS to take control in SMM mode and access the 
> controller directly before triggering the power off, which we have no 
> control or knowledge of.

Yes, this also is my observation.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
