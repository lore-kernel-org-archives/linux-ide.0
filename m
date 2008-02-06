From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6 patch] ata_piix.c:piix_init_one() must be __devinit
Date: Wed, 06 Feb 2008 07:04:39 -0500
Message-ID: <47A9A257.5000902@pobox.com>
References: <20080130200202.GH29368@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763348AbYBFMFD@vger.kernel.org>
In-Reply-To: <20080130200202.GH29368@does.not.exist>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> This patch fixes the following section mismatches:
> 
> <--  snip  -->
> 
> ...
> WARNING: drivers/ata/built-in.o(.text+0x15072): Section mismatch in reference from the function piix_init_one() to the function .devinit.text:piix_init_sata_map()
> WARNING: drivers/ata/built-in.o(.text+0x150dd): Section mismatch in reference from the function piix_init_one() to the function .devinit.text:piix_init_pcs()
> WARNING: drivers/ata/built-in.o(.text+0x150e5): Section mismatch in reference from the function piix_init_one() to the function .devinit.text:piix_init_sidpr()
> WARNING: drivers/ata/built-in.o(.text+0x15107): Section mismatch in reference from the function piix_init_one() to the function .devinit.text:piix_check_450nx_errata()
> ...
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 222e97f95d38ce7cb41980671cc4383df28b5f7a 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index a65c8ae..7a3b9ef 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1595,7 +1595,8 @@ static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
>   *	Zero on success, or -ERRNO value.
>   */
>  
> -static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +static int __devinit piix_init_one(struct pci_dev *pdev,
> +				   const struct pci_device_id *ent)
>  {
>  	static int printed_version;
>  	struct device *dev = &pdev->dev;
> 

applied
