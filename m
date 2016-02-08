From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7] SATA: OCTEON: support SATA on OCTEON platform
Date: Mon, 8 Feb 2016 11:42:37 -0600
Message-ID: <20160208174237.GA6479@rob-hp-laptop>
References: <1454520915-27948-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51333 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbcBHRmo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Feb 2016 12:42:44 -0500
Content-Disposition: inline
In-Reply-To: <1454520915-27948-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Feb 03, 2016 at 05:35:15PM +0000, Zubair Lutfullah Kakakhel wrote:
> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
> 
> The OCTEON SATA controller is currently found on cn71XX devices.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> Changes in v7
> - Rebase to v4.5-rc2
> - Use #defines instead of __BITFIELD
> - Add sign off from Zubair
> 
> Changes in v6
> - Rebase to v4.5-rc1
> - Tested on utm8 by rhino labs. CN7130
> 
> Changes in v5:
> - Sparse warnings are fixed
> - Device tree docs are improved
> 
> Changes in v4:
> - The call to dma_coerce_mask_and_coherent() was removed as suggested
>   by Arnd Bergmann dma_mask and coherent_dma_mask are actually set
>   in the ahci_platform_init_host() (libahci_platform.c)
> 
> Changes in v3:
> - Rebased to v4.0-rc2
> - Cosmetic changes
> 
> Changes in v2:
> - The driver was rewritten as a driver for the UCTL SATA controller glue.
>   It allowed to get rid of the most changes in ahci_platform.c
> - Documentation for the device tree bindings was fixed.
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>  .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 +++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/ata/Kconfig                                |   9 ++
>  drivers/ata/Makefile                               |   1 +
>  drivers/ata/ahci_platform.c                        |   1 +
>  drivers/ata/sata_octeon.c                          | 105 +++++++++++++++++++++
>  6 files changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>  create mode 100644 drivers/ata/sata_octeon.c
