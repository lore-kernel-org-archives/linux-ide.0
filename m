From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/10] drivers/ata: Fix continuation line formats
Date: Wed, 03 Feb 2010 12:25:22 -0500
Message-ID: <4B69B182.9040400@pobox.com>
References: <cover.1265095093.git.joe@perches.com> <12d39ac4f14bfe82a02b4ee246d183b48988fe12.1265095094.git.joe@perches.com> <4B69B0A0.2040701@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B69B0A0.2040701@teksavvy.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 02/03/2010 12:21 PM, Mark Lord wrote:
> Joe Perches wrote:
>> String constants that are continued on subsequent lines with \
>> are not good.
>>
>> Signed-off-by: Joe Perches <joe@perches.com>
>> ---
>> drivers/ata/pata_at91.c | 4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
>> index 41c94b1..d222c0d 100644
>> --- a/drivers/ata/pata_at91.c
>> +++ b/drivers/ata/pata_at91.c
>> @@ -153,8 +153,8 @@ static void pata_at91_set_piomode(struct ata_port
>> *ap, struct ata_device *adev)
>> /* Compute ATA timing and set it to SMC */
>> ret = ata_timing_compute(adev, adev->pio_mode, &timing, 1000, 0);
>> if (ret) {
>> - dev_warn(ap->dev, "Failed to compute ATA timing %d, \
>> - set PIO_0 timing\n", ret);
>> + dev_warn(ap->dev, "Failed to compute ATA timing %d, set PIO_0
>> timing\n",
>> + ret);
> ..
>
> NAK. Just stick the ret); part onto the same line and be done with it.

Agreed...
