From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] libata: add enclosure management support
Date: Fri, 18 Jan 2008 16:55:25 -0800
Message-ID: <20080118165525.57749ac8@appleyard>
References: <20080115164417.4a5e2789@appleyard>
	<1200610243.3255.47.camel@localhost.localdomain>
	<20080118085227.4b7a379f@appleyard>
	<1200676281.3111.20.camel@localhost.localdomain>
	<20080118094116.7ac94f2e@appleyard>
	<1200701795.3111.89.camel@localhost.localdomain>
	<20080118163512.65d93c53@appleyard>
	<1200703638.3111.95.camel@localhost.localdomain>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50266 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757481AbYASBAY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jan 2008 20:00:24 -0500
In-Reply-To: <1200703638.3111.95.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, 18 Jan 2008 18:47:18 -0600
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> On Fri, 2008-01-18 at 16:35 -0800, Kristen Carlson Accardi wrote:
> > > Unfortunately, all the dual SAS/SATA enclosures seem to be coming
> > > with either SGPIO devices or full fledged SES-2 devices.  I've
> > > actually got both (a backplane with SGPIO and an internal
> > > SAS/SATA enclosure with SES-2).  Unfortunately, I don't have the
> > > necessary information to drive the SGPIO one ... it's connected
> > > directly to an aix94xx using the mini4i SGPIO signals ... I think
> > > aic94xx can drive them, we just don't have the programming
> > > information.  The other is a standard SES-2 device, which I think
> > > I might be able to get working.
> > > 
> > 
> > Having documentation would be pretty helpful :).  I know for ICH8,
> > if you read the docs it says that it supports SGPIO as well.  But
> > then you realize it supports SGPIO via the LED protocol, wired up
> > to translate LED to SGPIO via hardware.  But, even if it did
> > support straight SGPIO, this design can accommodate that.  Can we
> > see the documentation for the SES-2 device?
> 
> Yes, sure; SES-2 is here (usual place, since it's a SCSI standard):
> 
> http://www.t10.org/ftp/t10/drafts/ses2/ses2r19a.pdf
> 
> SGPIO is more convoluted.  The canonical link is
> http://www.sffcommittee.com/ but that just seems to send you back to
> seagate.  The actual standard is this one:
> 
> ftp://ftp.seagate.com/sff/SFF-8485.PDF
> 
> James
> 
> 

No, I meant for the actual device.  The specs don't help all that much
in the area of actually transmitting the messages at the driver level -
at least they don't for AHCI.
