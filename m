From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata: add enclosure management support
Date: Fri, 18 Jan 2008 18:16:34 -0600
Message-ID: <1200701795.3111.89.camel@localhost.localdomain>
References: <20080115164417.4a5e2789@appleyard>
	 <1200610243.3255.47.camel@localhost.localdomain>
	 <20080118085227.4b7a379f@appleyard>
	 <1200676281.3111.20.camel@localhost.localdomain>
	 <20080118094116.7ac94f2e@appleyard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:53915 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754138AbYASAQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 19:16:42 -0500
In-Reply-To: <20080118094116.7ac94f2e@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 2008-01-18 at 09:41 -0800, Kristen Carlson Accardi wrote:
> On Fri, 18 Jan 2008 11:11:21 -0600
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > 
> > On Fri, 2008-01-18 at 08:52 -0800, Kristen Carlson Accardi wrote:
> > > On Thu, 17 Jan 2008 16:50:42 -0600
> > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > 
> > > > On Tue, 2008-01-15 at 16:44 -0800, Kristen Carlson Accardi wrote:
> > > > > Add Enclosure Management support to libata and ahci.
> > > > > 
> > > > > This patch adds support for the LED protocol, as defined in the
> > > > > AHCI spec. It adds a generic em_message and em_type sysfs entry
> > > > > per host.  It also adds a sw_activity field per existing drive.
> > > > > 
> > > > > The em_message field can be used by the driver to take enclosure
> > > > > management commands from userspace.  In the case of the LED
> > > > > protocol, writes and reads from em_message correspond to the LED
> > > > > message format as defined in the AHCI spec.
> > > > > 
> > > > > em_message type is a read only file that displays the current
> > > > > enclosure management protocol that is used by the driver.
> > > > > 
> > > > > sw_activity is used by drivers which support software controlled
> > > > > activity LEDs. It has the following valid values:
> > > > > 
> > > > > 0	OFF - the LED is not activated on activity
> > > > > 1	BLINK_ON - the LED blinks on every 10ms when activity
> > > > > is detected. 2	BLINK_OFF - the LED is on when idle, and
> > > > > blinks off every 10ms when activity is detected.
> > > > > 
> > > > > It's important to note that the user must turn sw_activity OFF
> > > > > it they wish to control the activity LED via the em_message
> > > > > file.
> > > > 
> > > > One of the things we really need to do is to get some type of
> > > > generic enclosure support.  I note that ahci support three
> > > > standard eclosure management protocols (SAF-TE, SES-2, SFF-8485
> > > > SGPIO) as well as the one proprietary one you've chosen to
> > > > implement.  Is that because no-one in the field has actually
> > > > connected AHCI up to anything supporting one of the standard
> > > > protocols?
> > > > 
> > > > I'm looking at this from slightly the other way around:  the SAS
> > > > protocol is virtually mandating SFF-8485 as the enclosure
> > > > protocol to the point that it's actually built into the sas
> > > > management protocol ... I was starting to wonder how we should be
> > > > taking advantage of this.
> > > > 
> > > > The implementation probably should be generic (above SCSI or IDE
> > > > or ATA) but it would obviously need to tap into the
> > > > subsytem/transport/device specific pieces, so possibly block
> > > > looks to be the right place to start?
> > > > 
> > > > James
> > > > 
> > > > 
> > > 
> > > I originally thought to try to make a generic enclosure management
> > > framework that we could hook individual EM protocols into.  Then I
> > > started to wonder why we needed to add knowledge of these protocols
> > > into the kernel.  At least the AHCI hardware which I'm familiar
> > > with, has no need to know anything about the protocol.  It abstracts
> > > everything into just a message.  So, the design that I did in this
> > > patch does the same thing.  You export the type of protocol the
> > > driver is configured to accept, then the message buffer and leave
> > > it up to user space to understand the individual protocol.  This
> > > works for all supported EM protocols.  As far as I can see, most of
> > > these management protocols are better suited to being implemented
> > > in user space anyway. 
> > 
> > It's one way to look at it, if we go with SFF-8485 and the AHCI
> > specific protocol.  Basically both of them are only about flashing
> > LEDs.  The SAF-TE and SES protocols are much more comprehensive (and
> > include things like environmental monitors, temperature, fans, etc.).
> 
> Even these though can be boiled down to read a message/write a
> message.

That's true of almost every protocol in the end.  I was thinking of the
abstraction.  The messages lead to flashing lights in the enclosures.
They also have interactive knobs that users twiddle on the other end.
We really need a uniform user interface abstraction for enclosures.

> > 
> > I think SFF-8485 still needs the LED frequency generators for RAW
> > mode, so putting them in AHCI is a bit too low down.  There's also the
> > question of a common user space interface for both.
> 
> My reading of SFF-8485 leads me to believe that even in raw bit stream
> mode you are still just reading/writing message buffers.
> 
> > 
> > > As far as block, I'm not sure that makes sense, but maybe I'm
> > > misunderstanding what you want. The em message needs to be
> > > associated with the controller, not with individual devices.  The
> > > reason for this is that the user may wish to locate a drive bay
> > > that has no disk in it, so they need to be able to send enclosure
> > > messages regardless of whether there's a block device associated
> > > with it. 
> > 
> > It's actually worse than that: enclosures aren't tied to HBAs even.
> > They're things that appear on Busses.  Take FC as the logical extreme:
> > you can have tons of different enclosures on a single FC bus.
> 
> For SATA they are tied to the controller.  Maybe it's not feasible to
> come up with a solution that is generic to something like FC and SATA
> on the other end.

So how does this work if the enclosure includes a SATA Port Multiplier?

> > 
> > But you can see from this, that enclosures are really separate devices
> > (separate from their contents or their connected HBA).
> > 
> > The thought about block is basically that SGPIO is a frame in/frame
> > out protocol.  It would probably have a raw interface via bsg a bit
> > like SMP does.  However, I wouldn't necessarily tie it to block.  It
> > would probably be tied to generic devices which get placed in the
> > device tree at appropriate locations.  Ideally, we can place a SGPIO
> > enclosure device properly whether it's tied to SAS, FC or AHCI.
> > 
> > James
> > 
> > 
> 
> This seems like maybe something we could work on in an evolutionary
> way as the need presents itself.  Honestly, without any SATA hardware
> that supports something beyond what this patch can support, it seems a
> lot of effort for little gain to try to share code, especially since
> the SATA devices wouldn't even use it. With both the AHCI and the nvidia
> EM solutions that are out there, that seems unneccessary.

Unfortunately, all the dual SAS/SATA enclosures seem to be coming with
either SGPIO devices or full fledged SES-2 devices.  I've actually got
both (a backplane with SGPIO and an internal SAS/SATA enclosure with
SES-2).  Unfortunately, I don't have the necessary information to drive
the SGPIO one ... it's connected directly to an aix94xx using the mini4i
SGPIO signals ... I think aic94xx can drive them, we just don't have the
programming information.  The other is a standard SES-2 device, which I
think I might be able to get working.

James


