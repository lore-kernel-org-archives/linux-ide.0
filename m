From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Tue, 2 Feb 2016 10:37:50 -0800
Message-ID: <56B0F77E.30602@caviumnetworks.com>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 02/02/2016 10:24 AM, Zubair Lutfullah Kakakhel wrote:
> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>
> The OCTEON SATA controller is currently found on cn71XX devices.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>

Typically, someone sending a patch would append their own Signed-off-by:

I suggest that you do the same.  I think Documentation/SubmittingPatches 
section 11 talks about how to do this.


>
> ---
> Changes in v6
> - Rebase to v4.5-rc1
> - Tested by Zubair Kakakhel on utm8 platform (CN7130 based)
>
> Changes in v5:
> - Sparse warnings are fixed
> - Device tree docs are improved
>
> Changes in v4:
> - The call to dma_coerce_mask_and_coherent() was removed as suggested
>    by Arnd Bergmann dma_mask and coherent_dma_mask are actually set
>    in the ahci_platform_init_host() (libahci_platform.c)
>
> Changes in v3:
> - Rebased to v4.0-rc2
> - Cosmetic changes
>
> Changes in v2:
> - The driver was rewritten as a driver for the UCTL SATA controller glue.
>    It allowed to get rid of the most changes in ahci_platform.c
> - Documentation for the device tree bindings was fixed.
> ---
>   .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>   .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 ++++++
>   drivers/ata/Kconfig                                |   9 ++
>   drivers/ata/Makefile                               |   1 +
>   drivers/ata/ahci_platform.c                        |   2 +
>   drivers/ata/sata_octeon.c                          | 155 +++++++++++++++++++++
>   6 files changed, 210 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>   create mode 100644 drivers/ata/sata_octeon.c
>
[...]
