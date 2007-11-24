From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: "buggy cmd640" message followed by soft lockup
Date: Sat, 24 Nov 2007 21:12:56 +0100
Message-ID: <200711242112.57072.rjw@sisk.pl>
References: <200711222007.12497.elendil@planet.nl> <200711241904.13132.bzolnier@gmail.com> <200711242038.06677.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33163 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbXKXTzN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Nov 2007 14:55:13 -0500
In-Reply-To: <200711242038.06677.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, 24 of November 2007, Frans Pop wrote:
> On Saturday 24 November 2007, Bartlomiej Zolnierkiewicz wrote:
> > Unfortunately I'm unable to reproduce this with:
> >
> > * VirtualBox 1.5.2 from http://www.virtualbox.org
> >   (VirtualBox-1.5.2_25433_fedora7-1.i586.rpm)
> >
> > * Fedora 7 with kernel-2.6.22.9-91.fc7 as a host OS
> >
> > * Fedora 8 with vanilla 2.6.24-rc2 as a guest OS
> >   (using the kernel config posted by you)
> >
> > so right now I suspect either a problem somehow specific to your system
> > (narrowing it down using git-bisect to a specific kernel commit would
> > greatly help) or a weird gcc bug (please make sure that you are using
> > non-buggy/up-to-date gcc version).
> 
> Thanks for looking at the issue Bartlomiej.
> 
> I started a bisect yesterday and suddenly found I could not reproduce the 
> issue anymore. Today I tried again and _did_ manage to reproduce the issue 
> again, but only with a 24-rc3 kernel, not with 24-rc1 or 24-rc2 kernels.
> And also only in combination with ata_piix and not with piix (one or the 
> other blacklisted). Also, after I changed the setup of the VM (changed 
> default boot medium from CD-ROM to hard disk), the kernel that failed 
> suddenly booted correctly.
> Both of these (module used and boot order) could explain why I could not 
> reproduce the issue yesterday.
> 
> After I changed the boot order back I could reproduce the BUG again, but 
> seemingly completely random for 24-rc1, 24-rc2 and 24-rc3: sometimes a 
> kernel boots fine, other times it fails. It may be related to way the 
> system is shut down, but I'm not sure of that.
> 
> My conclusion is that the base cause is probably an issue somewhere in 
> VirtualBox, but I suspect there is also something not 100% clean in the 
> kernel code (if only a missing sanity check). Especially since I've never 
> yet been able to reproduce it with a kernel before 2.6.24-rcX.
> 
> However, as it seems there are various variables involved and I cannot be 
> confident that I can reliably reproduce the issue with different kernels, I 
> do not really see any point in trying to bisect this.
> 
> I suggest closing #9442 in bugzilla as it does not seem worth tracking this 
> as a regression.

Closed.

Thanks,
Rafael
