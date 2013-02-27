From: Jan Sembera <fis@bofh.cz>
Subject: Re: Regression between v3.5 and v3.6 in libata
Date: Wed, 27 Feb 2013 15:25:08 +0100
Message-ID: <20130227142508.GB8208@abydos.bofh.cz>
References: <20130226200348.GA25087@abydos.bofh.cz>
 <20130226220702.GC25087@abydos.bofh.cz>
 <512DA957.1090600@gmail.com>
 <20130227093842.GA8208@abydos.bofh.cz>
 <512DFF1C.5010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anise.cz ([81.0.246.76]:42589 "EHLO anise.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab3B0OZK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Feb 2013 09:25:10 -0500
Content-Disposition: inline
In-Reply-To: <512DFF1C.5010707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lwe@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, mjg@redhat.com, holger@homac.de

On Wed, Feb 27, 2013 at 08:42:04PM +0800, Aaron Lu wrote:
> On 02/27/2013 05:38 PM, Jan Sembera wrote:
> > On Wed, Feb 27, 2013 at 12:36:07AM -0600, Robert Hancock wrote:
> >> On 02/26/2013 04:07 PM, Jan Sembera wrote:
> >>> So I apparently missed two most important differences between good and bad
> >>> boots.
> >>>
> >>> On Tue, Feb 26, 2013 at 09:03:48PM +0100, Jan Sembera wrote:
> >>>> [    2.877438] scsi6 : pata_atiixp
> >>>> [    2.881369] scsi7 : pata_atiixp
> >>>>
> >>>> [    2.391535] scsi6 : pata_acpi
> >>>> [    2.391994] scsi7 : pata_acpi
> >>>
> >>> pata-acpi doesn't play very well with this controller. Disabling it in
> >>> kernel and rebooting (even with 3.8) provided completely working kernel.
> >>> So either this driver shouldn't bind pata-acpi and leave it on pata-atiixp
> >>> as before (some kind of blacklisting needed?), or it needs some fixing to
> >>> work nicely with this controller.
> >>>
> >>> As a workaround for now, I'll just not compile PATA_ACPI into the kernel.
> >>
> >> What are your kernel config settings for these modules? The idea is that
> >> pata_acpi is only supposed to get loaded if no other driver is able to
> >> bind to the device.
> >
> > This is based on a config that Ubuntu uses for building vanilla kernels and
> > has PATA_ACPI=y, PATA_ATIIXP=m. Which probably means that pata_acpi will
> > grab the controller before pata_atiixp has any chance to do so. Which is
> > probably bad and should be set to PATA_ACPI=m instead.
> >
> > Should this also be treated as a bug in pata_acpi, or is it expected that
> > it's going to fail on some subset of motherboards/controllers and it's not
> > worth bothering with fixing it, especially if there is some other driver
> > that handles the controller fine?
> 
> The order here is important: vendor driver should always be used before
> pata_acpi.
> 
> And regarding the bisected commit, it actually fixed a bug in pata_acpi
> and made it successfully probed the controller device, so that no other
> pata driver is able to probe it; and due to pata_acpi can not always
> successfully drive that controller(this depends on ACPI table, it may
> not be a bug in pata_acpi), the disks attached will not function
> properly. Here is an explanation on this:
> https://bugzilla.kernel.org/show_bug.cgi?id=49151#c41
> 
> And a previously submitted bug report on this:
> https://bugzilla.kernel.org/show_bug.cgi?id=48631

Ok, thanks for the detailed explanation. I'll switch to PATA_ACPI=m for now,
but if there is some debugging you'd like me to do with pata_acpi, I'm
willing to help out with that as well.

Cheers,
Jan
