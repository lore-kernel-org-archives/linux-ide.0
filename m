From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] pata_arasan_cf: remove bogus to_platform_device() calls
Date: Thu, 13 Oct 2011 09:03:50 +0530
Message-ID: <4E965C1E.2080606@st.com>
References: <201110121909.09664.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:46202 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686Ab1JMDe3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 23:34:29 -0400
In-Reply-To: <201110121909.09664.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, Shiraz HASHIM <shiraz.hashim@st.com>

On 10/12/2011 8:39 PM, Sergei Shtylyov wrote:
> The suspend()/resume() methods already get the right 'struct device' to get the
> driver data from -- there's no need to get to the 'struct platform_device' that
> contains that 'struct device' just to call dev_get_drvdata()...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch is against the recent Linus' tree.
> 
>  drivers/ata/pata_arasan_cf.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/ata/pata_arasan_cf.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_arasan_cf.c
> +++ linux-2.6/drivers/ata/pata_arasan_cf.c
> @@ -922,8 +922,7 @@ static int __devexit arasan_cf_remove(st
>  #ifdef CONFIG_PM
>  static int arasan_cf_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	struct ata_host *host = dev_get_drvdata(dev);
>  	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
>  
>  	if (acdev->dma_chan) {
> @@ -937,8 +936,7 @@ static int arasan_cf_suspend(struct devi
>  
>  static int arasan_cf_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> +	struct ata_host *host = dev_get_drvdata(dev);
>  	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
>  
>  	cf_init(acdev);
> .
> 

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
