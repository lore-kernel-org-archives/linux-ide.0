From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0/2] Hyper-V disk support V3
Date: Mon, 16 Apr 2012 18:41:04 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF92CE0B5@CH1PRD0310MB381.namprd03.prod.outlook.com>
References: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
 <1334575229-7493-1-git-send-email-apw@canonical.com>
 <20120416122634.7d1357e1@ultron> <20120416182927.GB3346@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:14261 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823Ab2DPSmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Apr 2012 14:42:17 -0400
In-Reply-To: <20120416182927.GB3346@shadowen.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Sterling <mike.sterling@microsoft.com>



> -----Original Message-----
> From: Andy Whitcroft [mailto:apw@canonical.com]
> Sent: Monday, April 16, 2012 2:29 PM
> To: Alan Cox
> Cc: Jeff Garzik; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org; KY
> Srinivasan; Mike Sterling
> Subject: Re: [PATCH 0/2] Hyper-V disk support V3
> 
> On Mon, Apr 16, 2012 at 12:26:34PM +0100, Alan Cox wrote:
> > On Mon, 16 Apr 2012 12:20:27 +0100
> > Andy Whitcroft <apw@canonical.com> wrote:
> >
> > > Add support for ignoring disks devices on specific host controllers to
> > > libata.  Use this support to trigger us to ignore Hyper-V disk devices
> > > on the emulated SATA device based on the system DMI information.
> > >
> > > Jeff, I believe the first patch is what you had in mind in your comments.
> > > Alan, the piix sadly has no subvendor/subdevice identifiers at all
> >
> > So its 0x0000,0x0000 ?
> >
> > > though we are able to detect the platform from the DMI information,
> > > this any better?
> >
> > What happens if you have a PIIX device which is being passed through from
> > the underlying hardware or will hyper-v never support pass through ?

The notion of "pass through" in Hyper-V  is a little different. IDE devices can be configured
under either one of the supported controllers and these devices can either be virtual disks
(VHDs) or physical disks. In either case these will be presented to the guest as IDE devices.

Regards,

K. Y



