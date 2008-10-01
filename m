From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] SATA: Blacklisting of systems that spin off disks during ACPI power off
Date: Wed, 1 Oct 2008 13:36:44 +0200
Message-ID: <200810011336.45863.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200809300014.28983.rjw@sisk.pl> <48E2EFB3.1060202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57078 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbYJALcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 07:32:16 -0400
In-Reply-To: <48E2EFB3.1060202@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

On Wednesday, 1 of October 2008, Tejun Heo wrote:
> Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > SATA: Blacklisting of systems that spin off disks during ACPI power off
> > 
> > Introduce new libata flags ATA_FLAG_NO_POWEROFF_SPINDOWN and
> > ATA_FLAG_NO_HIBERNATE_SPINDOWN that, if set, will prevent disks from
> > being spun off during system power off and hibernation, respectively
> > (to handle the hibernation case we need the new system state
> > SYSTEM_HIBERNATE_ENTER that can be checked against by libata, in
> > analogy with SYSTEM_POWER_OFF).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK 3-6.  I'll push these through libata-dev after the first two
> prerequsite patches are cleared.

OK, thanks.

Best,
Rafael
