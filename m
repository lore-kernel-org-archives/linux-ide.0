From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH -mm] sata_nv: add suspend/resume support
Date: Mon, 11 Dec 2006 11:27:28 -0500
Message-ID: <457D86F0.4020408@garzik.org>
References: <456E3ED5.3090201@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47331 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937052AbWLKQ1a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Dec 2006 11:27:30 -0500
In-Reply-To: <456E3ED5.3090201@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> +static void nv_remove_one (struct pci_dev *pdev)
> +{
> +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	struct nv_host_priv *hpriv = host->private_data;
> +	
> +	kfree(hpriv);
> +	ata_pci_remove_one(pdev);
> +}	


It is unwise to free the struct before the ports are even detached.

Otherwise, seems ok, but I would like to see some more positive user 
reports (both ADMA and not) before pushing upstream.

	Jeff


