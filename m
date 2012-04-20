From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 5/5] ata/ahci_platform: Add clock framework support
Date: Fri, 20 Apr 2012 22:09:58 +0400
Message-ID: <4F91A676.9030609@mvista.com>
References: <cover.1334932338.git.viresh.kumar@st.com> <8308fd88100d4af942d920d51bf24184fcb33b72.1334932338.git.viresh.kumar@st.com> <4F91799F.1010002@mvista.com> <CAOh2x=noTa93F_ks3tR0CT5uRfS8=8v=eiY6tStNLV9qzCTB=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34095 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754830Ab2DTSLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 14:11:05 -0400
Received: by lahj13 with SMTP id j13so7663215lah.19
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 11:11:03 -0700 (PDT)
In-Reply-To: <CAOh2x=noTa93F_ks3tR0CT5uRfS8=8v=eiY6tStNLV9qzCTB=Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: "mturquette@ti.com" <mturquette@ti.com>, mturquette <mturquette@linaro.org>, jgarzik@redhat.com, spear-devel@list.st.com, linux-ide@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello.

On 04/20/2012 09:41 PM, viresh kumar wrote:

>>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>>> @@ -117,6 +118,20 @@ static int __init ahci_probe(struct platform_device
>>> *pdev)
>>>    		return -ENOMEM;
>>>    	}
>>>
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	hpriv->clk = clk_get(dev, NULL);
>>> +	if (IS_ERR(hpriv->clk)) {
>>> +		dev_err(dev, "Clock not found\n");
>>> +		return PTR_ERR(hpriv->clk);
>>> +	}
>>> +
>>> +	rc = clk_prepare_enable(hpriv->clk);
>>> +	if (rc) {
>>> +		dev_err(dev, "clock prepare enable failed");
>>> +		goto free_clk;
>>> +	}
>>> +#endif
>>> +
>>>    	/*
>>>    	 * Some platforms might need to prepare for mmio region access,
>>>    	 * which could be done in the following init call. So, the mmio
>> [...]
>>> @@ -190,12 +205,18 @@ static int __init ahci_probe(struct platform_device
>>> *pdev)
>>>    	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
>>>    			&ahci_platform_sht);
>>>    	if (rc)
>>> -		goto err0;
>>> +		goto pdata_exit;
>>>
>>>    	return 0;
>>> -err0:
>>> +pdata_exit:
>>>    	if (pdata&&   pdata->exit)
>>>    		pdata->exit(dev);
>>> +disable_unprepare_clk:
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	clk_disable_unprepare(hpriv->clk);
>>> +free_clk:
>>> +	clk_put(hpriv->clk);
>>> +#endif
>>>    	return rc;
>>>    }
>>>
>>> @@ -204,12 +225,19 @@ static int __devexit ahci_remove(struct
>>> platform_device *pdev)
>>>    	struct device *dev =&pdev->dev;
>>>    	struct ahci_platform_data *pdata = dev_get_platdata(dev);
>>>    	struct ata_host *host = dev_get_drvdata(dev);
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	struct ahci_host_priv *hpriv = host->private_data;
>>> +#endif
>>>
>>>    	ata_host_detach(host);
>>>
>>>    	if (pdata&&   pdata->exit)
>>>    		pdata->exit(dev);
>>>
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	clk_disable_unprepare(hpriv->clk);
>>> +	clk_put(hpriv->clk);
>>> +#endif
>>>    	return 0;
>>>    }
>>>
>>> @@ -244,6 +272,11 @@ static int ahci_suspend(struct device *dev)
>>>
>>>    	if (pdata&&   pdata->suspend)
>>>    		return pdata->suspend(dev);
>>> +
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	clk_disable_unprepare(hpriv->clk);
>>> +#endif
>>> +
>>>    	return 0;
>>>    }
>>>
>>> @@ -253,16 +286,26 @@ static int ahci_resume(struct device *dev)
>>>    	struct ata_host *host = dev_get_drvdata(dev);
>>>    	int rc;
>>>
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	struct ahci_host_priv *hpriv = host->private_data;
>>> +
>>> +	rc = clk_prepare_enable(hpriv->clk);
>>> +	if (rc) {
>>> +		dev_err(dev, "clock prepare enable failed");
>>> +		return rc;
>>> +	}
>>> +#endif
>>> +
>> [...]
>>> @@ -270,6 +313,12 @@ static int ahci_resume(struct device *dev)
>>>    	ata_host_resume(host);
>>>
>>>    	return 0;
>>> +
>>> +disable_unprepare_clk:
>>> +#ifdef CONFIG_HAVE_CLK
>>> +	clk_disable_unprepare(hpriv->clk);
>>> +#endif

>>      Can't we have empty inlines for !defined(CONFIG_HAVE_CLK) case in
>> <linux/clk.h>. Otherwise there's too much uglye #ifdef'ery.

> Isn't that simple. Lot of platforms defining these routines clk_get(),
> clk_put(), etc.
> So, if we create dummy routines, they will get errors for multiple declarations.

    But those platforms should have CONFIG_HAVE_CLK defined...

WBR, Sergei

