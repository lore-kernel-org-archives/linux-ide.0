From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] ide: pdc202xx_new: Replace mdelay with usleep_range
 in detect_pll_input_clock
Date: Wed, 11 Apr 2018 16:35:55 +0800
Message-ID: <00b11f19-0a4b-df83-923b-001bc5393229@gmail.com>
References: <1523433162-3910-1-git-send-email-baijiaju1990@gmail.com>
 <7558e956-62bd-39b9-6ff1-4d5f7ee2c9a3@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7558e956-62bd-39b9-6ff1-4d5f7ee2c9a3@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, davem@davemloft.net, frankt@promise.com, andre@linux-ide.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On 2018/4/11 16:33, Sergei Shtylyov wrote:
> Hello!
>
> On 4/11/2018 10:52 AM, Jia-Ju Bai wrote:
>
>> detect_pll_input_clock() is never called in atomic context.
>>
>> detect_pll_input_clock() is only called by init_chipset_pdcnew(), which
>> is set as ".init_chipset" in struct ide_port_info.
>> This function is not called in atomic context.
>>
>> Despite never getting called from atomic context, 
>> detect_pll_input_clock()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/ide/pdc202xx_new.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
>> index b33646b..6afa66d 100644
>> --- a/drivers/ide/pdc202xx_new.c
>> +++ b/drivers/ide/pdc202xx_new.c
>> @@ -258,7 +258,7 @@ static long detect_pll_input_clock(unsigned long 
>> dma_base)
>>       outb(scr1 | 0x40, dma_base + 0x03);
>>         /* Let the counter run for 10 ms. */
>> -    mdelay(10);
>> +    usleep_range(10);
>
>    This function takes 2 arguments.
>
> [...]
>
> MBR, Sergei

Oops, sorry for my fault.
Thanks for telling me this :)
I will modify it and send V2.


Best wishes,
Jia-Ju Bai
