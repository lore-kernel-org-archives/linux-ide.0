From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: acpi: remove redundent code for power resource
 handling
Date: Wed, 03 Apr 2013 19:56:53 -0400
Message-ID: <515CC1C5.7030902@pobox.com>
References: <1362456724-21257-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:39656 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762907Ab3DCX44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:56:56 -0400
In-Reply-To: <1362456724-21257-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On 03/04/2013 11:12 PM, Aaron Lu wrote:
> With commit:
> bc9b6407bd6df3ab7189e5622816bbc11ae9d2d8
> ACPI / PM: Rework the handling of devices depending on power resources
>
> The ACPI core now takes care of the power resources an acpi device
> depends on in that when the power resources are turned on, any devices
> that are bound to or in the dependent list of this acpi device will be
> runtime resumed. So there is no need for ata acpi code to duplicate this
> effort, and thus, the ata_acpi_(un)register_power_resource functions are
> no longer needed.
>
> The above commit thinks the scsi device is not bound to the acpi device,
> so needs to be added to the dependent list. But actually, it is. So
> there is no need to add it to the dependent list, or it will be runtime
> resumed twice(though this wouldn't cause any problem).
>
> This patch fixes it, and as a result, the
> ata_acpi_(un)register_power_resource and ata_acpi_(un)bind functions
> are removed.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>   drivers/ata/libata-acpi.c | 33 ---------------------------------
>   drivers/ata/libata-scsi.c |  6 ++++--
>   2 files changed, 4 insertions(+), 35 deletions(-)

applied



