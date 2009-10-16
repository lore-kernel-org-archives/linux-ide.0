From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: Add the AHCI controller Linux Device ID for NVIDIA
 	chipsets.
Date: Fri, 16 Oct 2009 06:26:53 -0400
Message-ID: <4AD84A6D.5070600@garzik.org>
References: <cfaab6210910150134q6cc2d5ffna39cf31bf89a8e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757844AbZJPK1f@vger.kernel.org>
In-Reply-To: <cfaab6210910150134q6cc2d5ffna39cf31bf89a8e2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peer chen <peerchen@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, pchen@nvidia.com
List-Id: linux-ide@vger.kernel.org

On 10/15/2009 04:34 AM, peer chen wrote:
> Add the generic device ID for NVIDIA AHCI controller.
>
> Signed-off-by: Peer Chen<peerchen@gmail.com>
> ---
> --- linux-2.6.32-rc4/drivers/ata/ahci.c.orig
> +++ linux-2.6.32-rc4/drivers/ata/ahci.c
> @@ -605,6 +605,7 @@ static const struct pci_device_id ahci_p
>   	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci_yesncq },	/* MCP67 */
>   	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci_yesncq },	/* MCP67 */
>   	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci_yesncq },	/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0580), board_ahci_yesncq },	/* Linux ID */
>   	{ PCI_VDEVICE(NVIDIA, 0x07f0), board_ahci_yesncq },	/* MCP73 */
>   	{ PCI_VDEVICE(NVIDIA, 0x07f1), board_ahci_yesncq },	/* MCP73 */
>   	{ PCI_VDEVICE(NVIDIA, 0x07f2), board_ahci_yesncq },	/* MCP73 */

applied
