From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/7] pata_ninja32: update ID table
Date: Sat, 06 Dec 2008 16:34:23 +0300
Message-ID: <493A7F5F.2070301@ru.mvista.com>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3372 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751997AbYLFNe3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 08:34:29 -0500
In-Reply-To: <20081205194231.17133.42760.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

Hello.

Alan Cox wrote:

> Signed-off-by: Alan Cox <alan@redhat.com>
> diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
> index 4e466ea..4dd9a3b 100644
> --- a/drivers/ata/pata_ninja32.c
> +++ b/drivers/ata/pata_ninja32.c
>   
[...]
> @@ -130,7 +130,8 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
>  		return rc;
>  	pci_set_master(dev);
>  
> -	/* Set up the register mappings */
> +	/* Set up the register mappings. We use the I/O mapping as only the
> +	   older chips also have MMIO on BAR 1 */
>   

   CodingStyle, chapter 8. It's only an examplet preferrable comment 
style there though...

MBR, Sergei


