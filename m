From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA: Blacklist systems that spin off disks during ACPI
 power off
Date: Mon, 08 Sep 2008 13:38:12 +0200
Message-ID: <48C50EA4.2020700@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <200808291241.04183.rjw@sisk.pl> <48B7D286.7050104@gmail.com> <200809061923.29020.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200809061923.29020.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> SATA: Blacklist systems that spin off disks during ACPI power off
> 
> Some notebooks from HP have the problem that their BIOSes attempt to
> spin down hard drives before entering ACPI system states S4 and S5.
> This leads to a yo-yo effect during system power-off shutdown and the
> last phase of hibernation when the disk is first spun down by the
> kernel and then almost immediately turned on and off by the BIOS.
> This, in turn, may result in shortening the disk's life times.
> 
> To prevent this from happening we can blacklist the affected systems
> using DMI information.  However, only the on-board controlles should
> be blacklisted and their PCI slot numbers can be used for this
> purpose.  Unfortunately the existing interface for checking DMI
> information of the system is not very convenient for this purpose,
> because to use it, we would have to define special callback functions
> or create a separate struct dmi_system_id table for each blacklisted
> system.
> 
> To overcome this difficulty introduce a new function
> dmi_first_match() returning a pointer to the first entry in an array
> of struct dmi_system_id elements that matches the system DMI
> information.  Then, we can use this pointer to access the entry's
> .driver_data field containing the additional information, such as
> the PCI slot number, allowing us to do the desired blacklisting.
> 
> Introduce a new libata flag ATA_FLAG_NO_POWEROFF_SPINDOWN that, if
> set, will prevent disks from being spun off during system power off
> and hibernation (to handle the hibernation case we need a new system
> state SYSTEM_HIBERNATE_ENTER that can be checked against by libata,
> in analogy with SYSTEM_POWER_OFF).  Use dmi_first_match() to set this
> flag for some systems affected by the problem described above (HP nx6325,
> HP nx6310, HP 2510p).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

libata part looks good to me but I think it would be better to
separate out DMI changes into a separate patch.

Thanks.

-- 
tejun
