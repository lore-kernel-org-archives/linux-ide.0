From: Tomer Barletz <barletz@gmail.com>
Subject: Re: [PATCH] sata_sx4: Check return code from pdc20621_i2c_read()
Date: Mon, 3 Aug 2015 12:04:20 -0700
Message-ID: <CAO-S75BnJJvNsEN3xFrtO9xO=4=UnwJeL6UHLeMbOaSyjk4Htw@mail.gmail.com>
References: <55BF8E29.6000200@cogentembedded.com>
	<1438627595-17126-1-git-send-email-barletz@gmail.com>
	<55BFB87C.1010405@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BFB87C.1010405@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I see how it makes sense to add a tab to align with the previous line
of code, as it will always look similar in all editors, no matter how
their tab character is set up to be.
However, adding more tabs will just mess up editors that are not set
up with 8-space width tabs.

Is this a bug in checkpatch.pl, or are we saying everyone should have
their editor set to 8-spaces width tabs?

--Tomer


On Mon, Aug 3, 2015 at 11:52 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 08/03/2015 09:46 PM, Tomer Barletz wrote:
>
>> The variable spd0 might be used uninitialized when pdc20621_i2c_read()
>> fails.
>> This also generates a compilation warning with gcc 5.1.
>
>
>> Signed-off-by: Tomer Barletz <barletz@gmail.com>
>> ---
>>   drivers/ata/sata_sx4.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
>> index 3a18a8a..e1c1423 100644
>> --- a/drivers/ata/sata_sx4.c
>> +++ b/drivers/ata/sata_sx4.c
>> @@ -1238,8 +1238,12 @@ static unsigned int
>> pdc20621_prog_dimm_global(struct ata_host *host)
>>         readl(mmio + PDC_SDRAM_CONTROL);
>>
>>         /* Turn on for ECC */
>> -       pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>> -                         PDC_DIMM_SPD_TYPE, &spd0);
>> +       if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>> +                              PDC_DIMM_SPD_TYPE, &spd0)) {
>
>
>    That won't do, you didn't fix the indentation here.
>
>> +               printk(KERN_ERR "Failed in i2c read: device=%#x,
>> subaddr=%#x\n",
>> +                      PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
>> +               return 1;
>> +       }
>>         if (spd0 == 0x02) {
>>                 data |= (0x01 << 16);
>>                 writel(data, mmio + PDC_SDRAM_CONTROL);
>> @@ -1380,8 +1384,12 @@ static unsigned int pdc20621_dimm_init(struct
>> ata_host *host)
>>
>>         /* ECC initiliazation. */
>>
>> -       pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>> -                         PDC_DIMM_SPD_TYPE, &spd0);
>> +       if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>> +                              PDC_DIMM_SPD_TYPE, &spd0)) {
>
>
>    And here.
>
>> +               printk(KERN_ERR "Failed in i2c read: device=%#x,
>> subaddr=%#x\n",
>> +                      PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
>> +               return 1;
>> +       }
>>         if (spd0 == 0x02) {
>>                 void *buf;
>>                 VPRINTK("Start ECC initialization\n");
>
>
> MBR, Sergei
>
