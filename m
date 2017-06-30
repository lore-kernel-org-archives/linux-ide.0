From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] pata_imx: print error message on platform_get_irq
 failure
Date: Fri, 30 Jun 2017 16:47:37 -0500
Message-ID: <20170630164737.Horde.XkAFPlkZTYgdXBu7_MH6YNz@gator4166.hostgator.com>
References: <20170630213056.GA12695@embeddedgus>
 <d0a70345-1d28-2218-098f-bdd700530f10@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d0a70345-1d28-2218-098f-bdd700530f10@cogentembedded.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Quoting Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:

> On 07/01/2017 12:30 AM, Gustavo A. R. Silva wrote:
>
>> Print error message on platform_get_irq failure before return.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> Changes in v2:
>> Print the return value of platform_get_irq on failure.
>>
>> drivers/ata/pata_imx.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
>> index d4caa23..66fb1ab 100644
>> --- a/drivers/ata/pata_imx.c
>> +++ b/drivers/ata/pata_imx.c
>> @@ -132,9 +132,10 @@ static int pata_imx_probe(struct platform_device *pdev)
>> 	int ret;
>>
>> 	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
>> 		return irq;
>> -
>> +	}
>
>    Removing empty line here doesn't seem a good idea...
>

Oh yeah, I agree.
I'll send v3 shortly.

Thanks!
--
Gustavo A. R. Silva
