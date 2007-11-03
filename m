From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Bart's efforts?
Date: Sat, 3 Nov 2007 09:25:48 -0400
Message-ID: <87f94c370711030625t22c87348r65926c5e4b602c6@mail.gmail.com>
References: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com>
	 <472C7019.9000405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:13300 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbXKCNZt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 09:25:49 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1185649wxd
        for <linux-ide@vger.kernel.org>; Sat, 03 Nov 2007 06:25:48 -0700 (PDT)
In-Reply-To: <472C7019.9000405@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thanks,

I was just curious.

On 11/3/07, Jeff Garzik <jeff@garzik.org> wrote:
> Greg Freemyer wrote:
> > Jeff / Alan,
> >
> > I mostly lurk here, but I know there is a long term effort/ToDo to
> > move libata away from the SCSI infrastructure.
> >
> > I've also seen that Bart has been making a large number of
> > improvements to drivers/ide over the last little while.  From my
> > limited perspective, many changes appear to be to the core
> > infrastructure.
> >
> > My question is if the drivers/ide infrastructure is slowly moving in
> > the direction of being leverageable by libata when/if it moves out of
> > scsi.  Or does the drivers/ide code simply have the wrong kind of
> > plumbing for libata to ever use.
>
> One of my key goals with libata was to "make a driver look like a
> driver" and greatly improve upon the IDE driver API, which was a
> complete and utter piece of garbage (this is no reflection on Bart, he
> inherited it).  As a result, each driver is a fully fledged
> PCI/SCSI/ATA/platform driver, without anything getting in the way.  That
> made things like controller hotplug trivial to support from day one.
>
> Bart has definitely made many good improvements, but I don't think
> people would be surprised that I feel CONFIG_IDE is legacy...
>
>         Jeff
>
>
>
>
>
>


-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
