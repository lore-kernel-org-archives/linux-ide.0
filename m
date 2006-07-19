From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 08/12] libata: implement interface power management infrastructure
Date: Wed, 19 Jul 2006 15:45:20 -0400
Message-ID: <44BE8BD0.90907@pobox.com>
References: <11531191522798-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030248AbWGSTp2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 15:45:28 -0400
In-Reply-To: <11531191522798-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement interface power management infrastructure.  To discern link
> power management from device power management (suspend/resume), link
> power management is called 'powersave' or 'PS' while device power
> mangement is called 'power management' or 'PM'.
> 
> libata PS infrastructure is primarily designed to accomodate SATA link
> powersave (link ACTIVE/PARTIAL/SLUMBER) but is not limited to it.
> libata implements the following powersave modes.
> 
> * none		: no powersave, link is powered up all the time
> * HIPS		: host-initiated powersave
> * DIPS		: device-initiated powersave
> * static	: no powersave on occupied link, power off empty link
> * HIPS/static	: HIPS on occupied link, power off empty link
> * DIPS/static	: DIPS on occupied link, power off empty link
> 
> HIPS/DIPS are called dynamic PS while static is static PS.  LLD can
> indicate which dynamic PS modes it supports using ATA_FLAG_HIPS and
> ATA_FLAG_DIPS.  Static mode support is mandatory but LLD is free to
> implement it as noop.  In fact, if LLD doesn't implement any powersave
> feature, libata will automatically handle static PS as noop.
> 
> PS mode is disengaged during EH recovery and reenabled on recovery
> completion.  Device configuration for DIPS is done by libata EH and
> LLD only has to configure the controller when instructed via
> ->set_powersave() callback.
> 
> libata guarantees that there is a reset before changing PS mode.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

> +static int libata_powersave = 0;	/* protected by all_ports_mutex */
> +module_param_call(powersave, ata_param_set_powersave, param_get_int,
> +		  &libata_powersave, 0644);
> +MODULE_PARM_DESC(powersave, "Powersave mode (0=none, 1=HIPS, 2=DIPS, "
> +		 "3=static, 4=HIPS/static, 5=DIPS/static)");
> +

NAK.

Module parameters in libata are largely for turning off/on major 
features, during a transitional testing period.  They largely provide 
users with workaround solutions to "it won't boot" type problems.

I also think you have been seduced by the relative ease of adding this 
control to libata, as opposed to the preferred alternative:  digging 
through sysfs objects to find the right one to which attributes should 
be added.

As an aside, in addition to per-controller (or per-port) sysfs powersave 
controls, libata should [eventually] recognize the external "laptop 
mode" setting.  When laptop mode == ON, program powersave aggresively.

In general, though, we should peek to minimize power usage for the 
general case, where feasible.  People with huge server closets like 
Google need every ounce of power savings possible.

With regards to the patch content:  other than the control interface, 
the implementation looks OK.

