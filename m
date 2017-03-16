From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] drivers: ata: Add [save|restore]_initial_config
 override functions
Date: Thu, 16 Mar 2017 17:30:32 -0400
Message-ID: <20170316213032.GE1480@htj.duckdns.org>
References: <1489492761-815-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489492761-815-1-git-send-email-anuragku@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc: Hans de Goede <hdegoede@redhat.com>, anirudh@xilinx.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Anurag Kumar Vulisha <anuragku@xilinx.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 14, 2017 at 05:29:21PM +0530, Anurag Kumar Vulisha wrote:
> @@ -613,7 +613,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  			  "Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.\n");
>  	}
>  
> -	ahci_save_initial_config(&pdev->dev, hpriv);
> +	if (hpriv->save_initial_config == NULL)
> +		ahci_save_initial_config(dev, hpriv);
> +	else
> +		hpriv->save_initial_config(dev, hpriv);

Can you just initialize hpriv->save_initial_config to
ahci_save_initial_config and let the init function override it as
necessary?

Thanks.

-- 
tejun
