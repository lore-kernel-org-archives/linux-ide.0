From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] sata: sata_rcar: Reset SATA PHY when Salvator-X board
 resumes
Date: Tue, 16 Jan 2018 19:34:04 +0300
Message-ID: <a061bdc2-df88-0a05-d81c-ceb175b235c6@cogentembedded.com>
References: <1516113552-27701-1-git-send-email-ykaneko0929@gmail.com>
 <b9cbfc3d-c1d3-e6c0-8f7d-1291ba04365c@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38574 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAPQeJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2018 11:34:09 -0500
Received: by mail-lf0-f67.google.com with SMTP id g72so12715054lfg.5
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2018 08:34:08 -0800 (PST)
In-Reply-To: <b9cbfc3d-c1d3-e6c0-8f7d-1291ba04365c@cogentembedded.com>
Content-Language: en-MW
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org

On 01/16/2018 07:25 PM, Sergei Shtylyov wrote:

>> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
>>
>> Because power of Salvator-X board is cut off in suspend,
>> it needs to reset SATA PHY state in resume.
>> Otherwise, SATA partition could not be accessed anymore.
>>
>> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
>> Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
>> [reinit phy in sata_rcar_resume() function on R-Car Gen3 only]
>> [fixed the prefix for the subject]
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is based on the for-next branch of libata tree.
>>
>> v2 [Yoshihiro Kaneko]
>> * reinit phy on R-Car Gen3 only as suggested by Geert Uytterhoeven
>> * use "sata_rcar" prefix for the subject as suggested by Sergei Shtylyov
>>   drivers/ata/sata_rcar.c | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
>> index 80ee2f2..4adc0d6 100644
>> --- a/drivers/ata/sata_rcar.c
>> +++ b/drivers/ata/sata_rcar.c
> [...]
>> @@ -977,11 +979,43 @@ static int sata_rcar_resume(struct device *dev)
>>       struct sata_rcar_priv *priv = host->private_data;
>>       void __iomem *base = priv->base;
>>       int ret;
>> +    u32 val;
>>       ret = clk_prepare_enable(priv->clk);
>>       if (ret)
>>           return ret;
>> +    /* reinit phy on R-Car Gen3 only */
>> +    switch (priv->type) {
>> +    case RCAR_GEN1_SATA:
>> +    case RCAR_GEN2_SATA:
>> +    case RCAR_R8A7790_ES1_SATA:
>> +        break;
>> +    case RCAR_GEN3_SATA:
>> +        sata_rcar_gen2_phy_init(priv);
>> +        break;
>> +    default:
>> +        dev_warn(host->dev, "SATA phy is not initialized\n");
>> +        break;
>> +    }
>> +
>> +    /* SATA-IP reset state */
>> +    val = ioread32(base + ATAPI_CONTROL1_REG);
>> +    val |= ATAPI_CONTROL1_RESET;
>> +    iowrite32(val, base + ATAPI_CONTROL1_REG);
>> +
>> +    /* ISM mode, PRD mode, DTEND flag at bit 0 */
>> +    val = ioread32(base + ATAPI_CONTROL1_REG);
>> +    val |= ATAPI_CONTROL1_ISM;
>> +    val |= ATAPI_CONTROL1_DESE;
>> +    val |= ATAPI_CONTROL1_DTA32M;
>> +    iowrite32(val, base + ATAPI_CONTROL1_REG);
>> +
>> +    /* Release the SATA-IP from the reset state */
>> +    val = ioread32(base + ATAPI_CONTROL1_REG);
>> +    val &= ~ATAPI_CONTROL1_RESET;
>> +    iowrite32(val, base + ATAPI_CONTROL1_REG);
>> +
> 
>     As it stands, we could surely do the same with a much shorter code:
> 
>      if (priv->type == RCAR_GEN3_SATA) {
>            sata_rcar_init_controller(host);
>      } else {
>           /* ack and mask */
>             iowrite32(0, base + SATAINTSTAT_REG);
>            iowrite32(0x7ff, base + SATAINTMASK_REG);
>      }
> 
>     But do we really need this reset/init sequence on gen1/2 chips?

     Oops, the above suggestion is what I think is a correct approach, it 
can't just replace your code...

MBR, Sergei
