From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Subject: Re: [PATCH v2] ata: sata_rcar: Add r8a7793 device support
Date: Thu, 16 Oct 2014 14:43:05 +0900
Message-ID: <543F5AE9.7030603@renesas.com>
References: <1413363577-25969-1-git-send-email-ykaneko0929@gmail.com> <20141016052054.GF1265@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:25601 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750765AbaJPFnI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2014 01:43:08 -0400
In-Reply-To: <20141016052054.GF1265@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: khiem.nguyen.xt@renesas.com, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hi,

On 10/16/2014 2:20 PM, Simon Horman wrote:
> On Wed, Oct 15, 2014 at 05:59:37PM +0900, Yoshihiro Kaneko wrote:
>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Tejun, could you consider picking up this change?

Uhmm, R8A7793 SoC hadn't been supported in upstream Linux kernel yet.
So, is it still OK to take this patch now ?

>> ---
>>
>> This patch is against for-next branch of Tejun's libata repo.
>>
>> v2 [Yoshihiro Kaneko]
>> * Update the binding documentation
>>
>>  Documentation/devicetree/bindings/ata/sata_rcar.txt | 3 ++-
>>  drivers/ata/sata_rcar.c                             | 5 +++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
>> index 1e61113..74b1130 100644
>> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
>> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
>> @@ -4,7 +4,8 @@ Required properties:
>>  - compatible		: should contain one of the following:
>>  			  - "renesas,sata-r8a7779" for R-Car H1
>>  			  - "renesas,sata-r8a7790" for R-Car H2
>> -			  - "renesas,sata-r8a7791" for R-Car M2
>> +			  - "renesas,sata-r8a7791" for R-Car M2-W
>> +			  - "renesas,sata-r8a7793" for R-Car M2-N
>>  - reg			: address and length of the SATA registers;
>>  - interrupts		: must consist of one interrupt specifier.
>>  
>> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
>> index 61eb6d7..6f8ed8e 100644
>> --- a/drivers/ata/sata_rcar.c
>> +++ b/drivers/ata/sata_rcar.c
>> @@ -841,6 +841,10 @@ static struct of_device_id sata_rcar_match[] = {
>>  		.compatible = "renesas,sata-r8a7791",
>>  		.data = (void *)RCAR_GEN2_SATA
>>  	},
>> +	{
>> +		.compatible = "renesas,sata-r8a7793",
>> +		.data = (void *)RCAR_GEN2_SATA
>> +	},
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(of, sata_rcar_match);
>> @@ -850,6 +854,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
>>  	{ "sata-r8a7779", RCAR_GEN1_SATA },
>>  	{ "sata-r8a7790", RCAR_GEN2_SATA },
>>  	{ "sata-r8a7791", RCAR_GEN2_SATA },
>> +	{ "sata-r8a7793", RCAR_GEN2_SATA },
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
>> -- 
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Best regards,
KHIEM Nguyen
