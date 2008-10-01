From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/6] Hibernation: Introduce new system state for the last
 phase of hibernation
Date: Wed, 01 Oct 2008 12:32:49 +0900
Message-ID: <48E2EF61.8000104@gmail.com>
References: <200808290002.55026.rjw@sisk.pl> <48D17BBE.5020807@garzik.org> <200809300006.24919.rjw@sisk.pl> <200809300010.39000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200809300010.39000.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Hibernation: Introduce new system state for the last phase of hibernation
> 
> Replace unused SYSTEM_SUSPEND_DISK with a new system_state value
> SYSTEM_HIBERNATE_ENTER that can be used by device drivers to check if
> the system is in the last phase of hibernation.
> 
> In particular, some SATA drivers are going to use it for blacklisting
> systems in which the disks should not be spun down during the last
> phase of hibernation (the BIOS will do that anyway).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Rafael, may I push this through libata-dev?

Thanks.

-- 
tejun
