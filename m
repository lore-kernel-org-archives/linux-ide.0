From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] libata: add enclosure management support
Date: Fri, 18 Jan 2008 16:52:43 -0800
Message-ID: <20080118165243.412fe397@appleyard>
References: <20080115164417.4a5e2789@appleyard>
	<1200610243.3255.47.camel@localhost.localdomain>
	<20080118085227.4b7a379f@appleyard>
	<1200676281.3111.20.camel@localhost.localdomain>
	<20080118094116.7ac94f2e@appleyard>
	<1200701795.3111.89.camel@localhost.localdomain>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58155 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757856AbYASA5m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jan 2008 19:57:42 -0500
In-Reply-To: <1200701795.3111.89.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 18 Jan 2008 18:16:34 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> On Fri, 2008-01-18 at 09:41 -0800, Kristen Carlson Accardi wrote:
> > On Fri, 18 Jan 2008 11:11:21 -0600
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > > 
> > > On Fri, 2008-01-18 at 08:52 -0800, Kristen Carlson Accardi wrote:
> > > > On Thu, 17 Jan 2008 16:50:42 -0600
> > > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > > 
> > > > > On Tue, 2008-01-15 at 16:44 -0800, Kristen Carlson Accardi
> > > > > wrote:
> > > > > > Add Enclosure Management support to libata and ahci.
> > > > > > 
> > > > > > This patch adds support for the LED protocol, as defined in
> > > > > > the AHCI spec. It adds a generic em_message and em_type
> > > > > > sysfs entry per host.  It also adds a sw_activity field per
> > > > > > existing drive.
> > > > > > 
> > > > > > The em_message field can be used by the driver to take
> > > > > > enclosure management commands from userspace.  In the case
> > > > > > of the LED protocol, writes and reads from em_message
> > > > > > correspond to the LED message format as defined in the AHCI
> > > > > > spec.
> > > > > > 
> > > > > > em_message type is a read only file that displays the
> > > > > > current enclosure management protocol that is used by the
> > > > > > driver.
> > > > > > 
> > > > > > sw_activity is used by drivers which support software
> > > > > > controlled activity LEDs. It has the following valid values:
> > > > > > 
> > > > > > 0	OFF - the LED is not activated on activity
> > > > > > 1	BLINK_ON - the LED blinks on every 10ms when
> > > > > > activity is detected. 2	BLINK_OFF - the LED is on
> > > > > > when idle, and blinks off every 10ms when activity is
> > > > > > detected.
> > > > > > 
> > > > > > It's important to note that the user must turn sw_activity
> > > > > > OFF it they wish to control the activity LED via the
> > > > > > em_message file.
> > > > > 
> > > > > One of the things we really need to do is to get some type of
> > > > > generic enclosure support.  I note that ahci support three
> > > > > standard eclosure management protocols (SAF-TE, SES-2,
> > > > > SFF-8485 SGPIO) as well as the one proprietary one you've
> > > > > chosen to implement.  Is that because no-one in the field has
> > > > > actually connected AHCI up to anything supporting one of the
> > > > > standard protocols?
> > > > > 
> > > > > I'm looking at this from slightly the other way around:  the
> > > > > SAS protocol is virtually mandating SFF-8485 as the enclosure
> > > > > protocol to the point that it's actually built into the sas
> > > > > management protocol ... I was starting to wonder how we
> > > > > should be taking advantage of this.
> > > > > 
> > > > > The implementation probably should be generic (above SCSI or
> > > > > IDE or ATA) but it would obviously need to tap into the
> > > > > subsytem/transport/device specific pieces, so possibly block
> > > > > looks to be the right place to start?
> > > > > 
> > > > > James
> > > > > 
> > > > > 
> > > > 
> > > > I originally thought to try to make a generic enclosure
> > > > management framework that we could hook individual EM protocols
> > > > into.  Then I started to wonder why we needed to add knowledge
> > > > of these protocols into the kernel.  At least the AHCI hardware
> > > > which I'm familiar with, has no need to know anything about the
> > > > protocol.  It abstracts everything into just a message.  So,
> > > > the design that I did in this patch does the same thing.  You
> > > > export the type of protocol the driver is configured to accept,
> > > > then the message buffer and leave it up to user space to
> > > > understand the individual protocol.  This works for all
> > > > supported EM protocols.  As far as I can see, most of these
> > > > management protocols are better suited to being implemented in
> > > > user space anyway. 
> > > 
> > > It's one way to look at it, if we go with SFF-8485 and the AHCI
> > > specific protocol.  Basically both of them are only about flashing
> > > LEDs.  The SAF-TE and SES protocols are much more comprehensive
> > > (and include things like environmental monitors, temperature,
> > > fans, etc.).
> > 
> > Even these though can be boiled down to read a message/write a
> > message.
> 
> That's true of almost every protocol in the end.  I was thinking of
> the abstraction.  The messages lead to flashing lights in the
> enclosures. They also have interactive knobs that users twiddle on
> the other end. We really need a uniform user interface abstraction
> for enclosures.
> 

I guess I'm still not seeing why this abstraction needs to be in the
kernel.  Why can't it be a user space library with a generic buffer to
send/receive messages.

