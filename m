From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0/2] Hyper-V disk support V3
Date: Thu, 19 Apr 2012 13:17:36 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF92CEBF6@CH1PRD0310MB381.namprd03.prod.outlook.com>
References: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
 <1334575229-7493-1-git-send-email-apw@canonical.com>
 <20120416122634.7d1357e1@ultron> <20120416182927.GB3346@shadowen.org>
 <426367E2313C2449837CD2DE46E7EAF92CE0B5@CH1PRD0310MB381.namprd03.prod.outlook.com>
 <20120418211235.55b9befc@pyramind.ukuu.org.uk>
 <20120419074018.GA3342@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:34906
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839Ab2DSNVo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Apr 2012 09:21:44 -0400
In-Reply-To: <20120419074018.GA3342@shadowen.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Sterling <mike.sterling@microsoft.com>



> -----Original Message-----
> From: Andy Whitcroft [mailto:apw@canonical.com]
> Sent: Thursday, April 19, 2012 3:40 AM
> To: Alan Cox
> Cc: KY Srinivasan; Jeff Garzik; linux-ide@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mike Sterling
> Subject: Re: [PATCH 0/2] Hyper-V disk support V3
> 
> On Wed, Apr 18, 2012 at 09:12:35PM +0100, Alan Cox wrote:
> > > The notion of "pass through" in Hyper-V  is a little different. IDE devices can
> be configured
> > > under either one of the supported controllers and these devices can either
> be virtual disks
> > > (VHDs) or physical disks. In either case these will be presented to the guest as
> IDE devices.
> >
> > So what ensures that by skipping it at the ATA device level we will
> > always find it as a VHD ?
> 
> My understanding of things is that the if you have disks assigned to the
> guest that they will always appear both on the virtualised SATA contoller
> and on the paravirtualised driver channel.  So that assuming a valid
> configuration in which both drivers initialise they will be picked up by
> one or the other.
> 
> KY for clarity are we saying the only way a disk can appear in the guest
> is either on the emulated controller or paravirtualised, we will never
> expose real devices into the guest.

You are right. Depending on how the device is configured for the guest, even
in the pass through case, the device will show up as either an emulated device
(if configured under the IDE controllers) or as a device under the synthetic scsi
controller (as seen by the guest). The storvsc driver can handle both these configurations
while the native ata driver can only handle emulated devices. Since, presently we can 
only boot off of a device configured under the IDE controller, we have the issue which your
patch addresses.

K. Y 



