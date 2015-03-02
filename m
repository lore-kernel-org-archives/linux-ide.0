From: Tejun Heo <tj@kernel.org>
Subject: Re: [V4 PATCH 2/2] ata: ahci_platform: Add ACPI _CLS matching
Date: Mon, 2 Mar 2015 11:41:03 -0500
Message-ID: <20150302164103.GH17694@htj.duckdns.org>
References: <1425284840-9233-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1425284840-9233-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45060 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbCBQlH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2015 11:41:07 -0500
Content-Disposition: inline
In-Reply-To: <1425284840-9233-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, lv.zheng@intel.com, hpa@linux.intel.com, lenb@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Mon, Mar 02, 2015 at 02:27:20AM -0600, Suravee Suthikulpanit wrote:
> This patch adds ACPI supports for AHCI platform driver, which uses _CLS
> method to match the device.
> 
> The following is an example of ASL structure in DSDT for a SATA controller,
> which contains _CLS package to be matched by the ahci_platform driver:
> 
>   Device (AHC0) // AHCI Controller
>   {
>     Name(_HID, "AMDI0600")
>     Name (_CCA, 1)
>     Name (_CLS, Package (3)
>     {
>       0x01, // Base Class: Mass Storage
>       0x06, // Sub-Class: serial ATA
>       0x01, // Interface: AHCI
>     })
>     Name (_CRS, ResourceTemplate ()
>     {
>       Memory32Fixed (ReadWrite, 0xE0300000, 0x00010000)
>       Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive,,,) { 387 }
>     })
>   }
> 
> Also, since ATA driver should not require PCI support for ATA_ACPI,
> this patch removes dependency in the driver/ata/Kconfig.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Looks good to me from the libata side.

 Acked-by: Tejun Heo <tj@kernel.org>

Please let me now if this needs to go through libata.

Thanks.

-- 
tejun
