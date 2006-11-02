From: Andrew Morton <akpm@osdl.org>
Subject: Re: [git patches] libata: some last minute PCI IDs
Date: Thu, 2 Nov 2006 15:33:37 -0800
Message-ID: <20061102153337.7e7c3e06.akpm@osdl.org>
References: <20061102230301.GA29659@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:29409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752805AbWKBXj0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Nov 2006 18:39:26 -0500
In-Reply-To: <20061102230301.GA29659@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

On Thu, 2 Nov 2006 18:03:01 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/ata/ahci.c     |    8 ++++++++
>  drivers/ata/pata_amd.c |    2 ++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> Peer Chen:
>       [libata] Add support for PATA controllers of MCP67 to pata_amd.c.
>       [libata] Add support for AHCI controllers of MCP67.
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 988f8bb..234197e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -334,6 +334,14 @@ static const struct pci_device_id ahci_p
>  	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci },		/* MCP65 */
>  	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci },		/* MCP65 */
>  	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci },		/* MCP65 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0554), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0555), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0556), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0557), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0558), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0559), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x055a), board_ahci },		/* MCP67 */
> +	{ PCI_VDEVICE(NVIDIA, 0x055b), board_ahci },		/* MCP67 */
>  
>  	/* SiS */
>  	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
> diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
> index 29234c8..5c47a9e 100644
> --- a/drivers/ata/pata_amd.c
> +++ b/drivers/ata/pata_amd.c
> @@ -677,6 +677,8 @@ static const struct pci_device_id amd[] 
>  	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	8 },
>  	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	8 },
>  	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_IDE),	8 },
> +	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
>  	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
>  

I think you'll find we're missing definitions for
PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE (at least).

