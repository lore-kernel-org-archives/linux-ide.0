From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Wed, 30 Jun 2010 08:49:34 +0200
Message-ID: <4C2AE8FE.3020409@kernel.org>
References: <1277879827-18233-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35018 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab0F3GuT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jun 2010 02:50:19 -0400
In-Reply-To: <1277879827-18233-1-git-send-email-justinmattock@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello,

On 06/30/2010 08:37 AM, Justin P. Mattock wrote:
> The below patch fixes a warning message during compiling of the kernel
>   CC      drivers/ata/ahci.o
> drivers/ata/ahci.c: In function 'ahci_init_one':
> drivers/ata/ahci.c:1045:2: warning: comparison between 'enum <anonymous>' and 'enum <anonymous>'
> 
>  Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Hmm, is this something we wanna go around the kernel and updating
sources?  Or should we just flick a gcc option?

> @@ -1038,11 +1038,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	struct device *dev = &pdev->dev;
>  	struct ahci_host_priv *hpriv;
>  	struct ata_host *host;
> -	int n_ports, i, rc;
> +	int n_ports, i, rc, sum = AHCI_MAX_CMDS;
>  
>  	VPRINTK("ENTER\n");
>  
> -	WARN_ON(ATA_MAX_QUEUE > AHCI_MAX_CMDS);
> +	WARN_ON(ATA_MAX_QUEUE > sum);

And, just do WARN_ON((int)ATA_MAX_QUEUE > (int)AHCI_MAX_CMDS)

Thanks.

-- 
tejun
