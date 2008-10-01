From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/6] SATA: Blacklisting of systems that spin off disks
 during ACPI power off
Date: Wed, 01 Oct 2008 12:34:11 +0900
Message-ID: <48E2EFB3.1060202@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <48D17BBE.5020807@garzik.org> <200809300006.24919.rjw@sisk.pl> <200809300014.28983.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200809300014.28983.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> SATA: Blacklisting of systems that spin off disks during ACPI power off
> 
> Introduce new libata flags ATA_FLAG_NO_POWEROFF_SPINDOWN and
> ATA_FLAG_NO_HIBERNATE_SPINDOWN that, if set, will prevent disks from
> being spun off during system power off and hibernation, respectively
> (to handle the hibernation case we need the new system state
> SYSTEM_HIBERNATE_ENTER that can be checked against by libata, in
> analogy with SYSTEM_POWER_OFF).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK 3-6.  I'll push these through libata-dev after the first two
prerequsite patches are cleared.

Thanks.

-- 
tejun
