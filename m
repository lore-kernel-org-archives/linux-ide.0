From: Andre Tomt <lkml@tomt.net>
Subject: Re: Serial ATA (SATA) for Linux status report
Date: Thu, 04 Dec 2003 02:02:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1070499770.15415.158.camel@slurv.pasop.tomt.net>
References: <20031203204445.GA26987@gtf.org>
	 <1070494030.15415.111.camel@slurv.pasop.tomt.net>
	 <3FCE737C.1080105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3FCE737C.1080105@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 2003-12-04 at 00:36, Jeff Garzik wrote:
> Andre Tomt wrote:
> > One question - with "including hotplug", does that mean some set hotplug
> > standard? Reason I'm asking is, we have a few servers from SuperMicro,
> > with a ICH5R S-ATA controller that claims it's supporting hotplug, but
> > hotplug is not in your ICH5-summary.
> 
> Alas, there is no hotplug support in the ICH5 or ICH5-R SATA hardware.
> 
> One could argue there is "coldplug" support in that hardware -- disable 
> the entire interface, including any active devices, then re-enable and 
> re-scan -- but it's a bit of a hack.  If there's enough demand, I could 
> write some code for that.  It would involve something like
> 
> 	# /sbin/sata off
> 	{ plug in or remove a device }
> 	# /sbin/sata on
> 
> You really, really, really don't want to actually unplug a SATA drive 
> while it's active, on ICH5 hardware.

Hmm. There is a backplane involved, that might change things a little.

Quoting the manual:
"A Serial ATA controller is incorporated into the 875P chipset to
provide a two-port Serial ATA subsystem, which is RAID 0 and RAID 1
supported. The Serial ATA drives are hot-swappable units. Note: The
operating system you use must have RAID support to enable the hot-swap
capability and RAID function of the Serial ATA drives."

"The Serial ATA drives plug into a backplane that provides power, drive
ID and bus termination. A RAID controller can be used with the backplane
to provide data security. The operating system you use must have RAID
support to enable the hot-swap capability of the Serial ATA drives."

The wording here is a little confusing, but hot-swap seems to work quite
well with intels windows fakeraid-drivers, at least. One just pushes the
"i'm going to pull you out now"-button on the tray, and pull the drive
tray out. Maybe it triggers an event to the fakeraid-driver, wich then
powers down the bus? black backplane-magic?

Anyways, REAL S-ATA hardware RAID controllers are pretty cheap over here
nowadays..

[trimmed off linux-scsi]
