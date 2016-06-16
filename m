From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: ahci_platform: Add ACPI support for APM X-Gene AHCI controller v3 hardware.
Date: Thu, 16 Jun 2016 08:54:09 +0200
Message-ID: <6691907.FIx2xYmxSs@wuerfel>
References: <stripathi@apm.com> <1466034240-22694-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:49571 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbcFPGxF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jun 2016 02:53:05 -0400
In-Reply-To: <1466034240-22694-1-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: suman-tripathi <stripathi@apm.com>
Cc: olof@lixom.net, tj@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com

On Wednesday, June 15, 2016 5:44:00 PM CEST suman-tripathi wrote:
> This patch adds ACPI support for APM X-Gene AHCI controller in
> ahci_platform driver for v3 hardware. APM X-Gene AHCI controller
> v3 hardware is fully compliant with ahci_platform driver and requires
> no workaround quirk.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/ata/ahci_platform.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 62a04c8..3395baf 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -86,6 +86,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
> 
>  static const struct acpi_device_id ahci_acpi_match[] = {
>         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
> +       { "APMC0D33", 0},
>         {},
>  };
>  MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
> 

Doesn't the ACPI_DEVICE_CLASS entry take care of this? I thought it had been
added specifically for this purpose. It doesn't seem right to add vendor
specific entries for generic hardware in each generic driver.

	Arnd
