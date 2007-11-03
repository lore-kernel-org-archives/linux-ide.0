From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Bart's efforts?
Date: Sat, 03 Nov 2007 08:56:57 -0400
Message-ID: <472C7019.9000405@garzik.org>
References: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44857 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbXKCM47 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:56:59 -0400
In-Reply-To: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> Jeff / Alan,
> 
> I mostly lurk here, but I know there is a long term effort/ToDo to
> move libata away from the SCSI infrastructure.
> 
> I've also seen that Bart has been making a large number of
> improvements to drivers/ide over the last little while.  From my
> limited perspective, many changes appear to be to the core
> infrastructure.
> 
> My question is if the drivers/ide infrastructure is slowly moving in
> the direction of being leverageable by libata when/if it moves out of
> scsi.  Or does the drivers/ide code simply have the wrong kind of
> plumbing for libata to ever use.

One of my key goals with libata was to "make a driver look like a 
driver" and greatly improve upon the IDE driver API, which was a 
complete and utter piece of garbage (this is no reflection on Bart, he 
inherited it).  As a result, each driver is a fully fledged 
PCI/SCSI/ATA/platform driver, without anything getting in the way.  That 
made things like controller hotplug trivial to support from day one.

Bart has definitely made many good improvements, but I don't think 
people would be surprised that I feel CONFIG_IDE is legacy...

	Jeff





