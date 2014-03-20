From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v6 04/18] ahci-platform: Add support for devices with
 more then 1 clock
Date: Thu, 20 Mar 2014 13:28:19 +0100
Message-ID: <532ADEE3.6070901@codethink.co.uk>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com> <1392811320-3132-5-git-send-email-hdegoede@redhat.com> <20140219145203.GC10134@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:58332 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751701AbaCTM2X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2014 08:28:23 -0400
In-Reply-To: <20140219145203.GC10134@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

On 19/02/14 15:52, Tejun Heo wrote:
> On Wed, Feb 19, 2014 at 01:01:46PM +0100, Hans de Goede wrote:
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 434ab89..aaa0c08 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -87,6 +87,44 @@ static struct scsi_host_template ahci_platform_sht = {
>>   	AHCI_SHT("ahci_platform"),
>>   };
>>
>> +
>> +int ahci_platform_enable_clks(struct ahci_host_priv *hpriv)
>
> Throughout the series, there are mixtures of one and two blank lines
> in front of functions, let's just do one consistently.  Also, can you
> please add proper function comments on top of the exported functions?
>
>> +{
>> +	int c, rc;
>> +
>> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++) {
>> +		rc = clk_prepare_enable(hpriv->clks[c]);
>> +		if (rc)
>> +			goto disable_unprepare_clk;
>> +	}
>> +	return 0;
>> +
>> +disable_unprepare_clk:
>> +	while (--c >= 0)
>> +		clk_disable_unprepare(hpriv->clks[c]);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(ahci_platform_enable_clks);
>> +
>> +void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
>> +{
>> +	int c;
>> +
>> +	for (c = AHCI_MAX_CLKS - 1; c >= 0; c--)
>> +		if (hpriv->clks[c])
>> +			clk_disable_unprepare(hpriv->clks[c]);
>> +}
>> +EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
>> +
>> +
>> +static void ahci_put_clks(struct ahci_host_priv *hpriv)
>> +{
>> +	int c;
>> +
>> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
>> +		clk_put(hpriv->clks[c]);
>> +}
>
> Urgh, clk can't do devm?  ahci_platform itself should be able to build
> devmized interface using devres_alloc() or devm_add_action().
> Eh.... maybe later.

There is devm_clk_get()


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
