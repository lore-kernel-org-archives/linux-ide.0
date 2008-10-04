From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] Hibernation: Introduce system_entering_hibernation
Date: Sat, 4 Oct 2008 12:14:08 +0200
Message-ID: <200810041214.09680.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200810032351.46869.rjw@sisk.pl> <48E71514.90505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <48E71514.90505@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Saturday, 4 of October 2008, Tejun Heo wrote:
> Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Hibernation: Introduce system_entering_hibernation
> > 
> > Introduce boolean function system_entering_hibernation() returning
> > 'true' during the last phase of hibernation, in which devices are
> > being put into low power states and the sleep state (for example,
> > ACPI S4) is finally entered.
> > 
> > Some device drivers need such a function to check if the system is
> > in the final phase of hibernation.  In particular, some SATA drivers
> > are going to use it for blacklisting systems in which the disks
> > should not be spun down during the last phase of hibernation (the
> > BIOS will do that anyway).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> applied 1-6 to tj-upstream
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git tj-upstream
>   http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=tj-upstream

Thanks a lot,
Rafael
