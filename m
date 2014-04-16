From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2 1/2] ata: ahci: append new hflag AHCI_HFLAG_NO_FBS
Date: Wed, 16 Apr 2014 16:49:55 -0400
Message-ID: <20140416204955.GC26632@htj.dyndns.org>
References: <1397107468-640-1-git-send-email-wangkefeng.wang@huawei.com>
 <1397107468-640-2-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:57009 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbaDPUt7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 16:49:59 -0400
Content-Disposition: inline
In-Reply-To: <1397107468-640-2-git-send-email-wangkefeng.wang@huawei.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, Kefeng Wang <kefeng.wang@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>

On Thu, Apr 10, 2014 at 01:24:27PM +0800, Kefeng Wang wrote:
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 6bd4f66..573edb3 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -452,6 +452,11 @@ void ahci_save_initial_config(struct device *dev,
>  		cap &= ~HOST_CAP_SNTF;
>  	}
>  
> +	if ((cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_NO_FBS)) {
> +		dev_info(dev, "controller can't do FBS, turning off CAP_FBS\n");
> +		cap &= ~HOST_CAP_FBS;
> +	}

Can you please put this chunk after YES_FBS?

>  	if (!(cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_YES_FBS)) {
>  		dev_info(dev, "controller can do FBS, turning on CAP_FBS\n");
>  		cap |= HOST_CAP_FBS;

Thanks.

-- 
tejun
