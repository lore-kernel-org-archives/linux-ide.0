From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: sata_rcar: Add RCAR Gen2 SATA PHY support
Date: Fri, 11 Oct 2013 22:24:15 +0200
Message-ID: <52585E6F.40903@cogentembedded.com>
References: <1381432083-3684-1-git-send-email-valentine.barshak@cogentembedded.com> <20131011010032.GA13809@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:54239 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3JKTZa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Oct 2013 15:25:30 -0400
Received: by mail-we0-f176.google.com with SMTP id w62so4620926wes.21
        for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2013 12:25:29 -0700 (PDT)
In-Reply-To: <20131011010032.GA13809@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, devicetree@vger.kernel.org

Hello.

On 11-10-2013 3:00, Simon Horman wrote:

> [ CCed devicetree@vger.kernel.org as this involves DT compatibility strings ]

    Note that I did CC then-existing devicetree-discuss list when posting the 
original driver but we got no feedback from there. That's why the binding 
documentation is missing.

>> RCAR Gen2 SoC has a different phy which is not compatible with

    Hm, the SoCs family is called R-Car, is it so hard to remember? :-)

>> the older H1/M1 versions. This adds OF/platform device table
>> and PHY initialization callbacks for H2/M2 (Gen2) SoC.

[...]

>> PHY initialization method is chosen based on the device id.
>> Default PHY settings are applied for Gen2 SoC, which should
>> suit the available Gen2 boards.

>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
[skip overquoating, grr :-]
>> @@ -770,8 +823,34 @@ static void sata_rcar_init_controller(struct ata_host *host)
>>   	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
>>   }
>>
>> +static struct of_device_id sata_rcar_match[] = {
>> +	{
>> +		.compatible = "renesas,rcar-sata",
>> +		.data = (void *)RCAR_SATA
>> +	},
>> +	{
>> +		.compatible = "renesas,sata-r8a7790",
>> +		.data = (void *)RCAR_GEN2_SATA
>> +	},
>> +	{
>> +		.compatible = "renesas,sata-r8a7791",
>> +		.data = (void *)RCAR_GEN2_SATA
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, sata_rcar_match);
>> +
>> +static const struct platform_device_id sata_rcar_id_table[] = {
>> +	{ "sata_rcar",		RCAR_SATA },
>> +	{ "sata-r8a7790",	RCAR_GEN2_SATA },
>> +	{ "sata-r8a7791",	RCAR_GEN2_SATA },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(platform, sata_rcat_id_table);
>> +

> I think it would be better to add sata-r8a7779 and
> sata-r8a7778 to handle the GEN1 hardware and deprecate rcar-sata.

    R8A7778 doesn't have the SATA controller AFAIR.

> Less importantly I think it would be better to name RCAR_SATA
> as RCAR_GEN1_SATA.

    Now that we have Gen2, yes.

WBR, Sergei

