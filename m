From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] pata-rb532-cf: get rid of the irq_to_gpio() call
Date: Thu, 18 Feb 2016 11:05:35 +0100
Message-ID: <56C5976F.9030904@openwrt.org>
References: <1455710300-30920-1-git-send-email-juhosg@openwrt.org>
 <20160217134030.29e4c6d7@tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160217134030.29e4c6d7@tock>
Sender: stable-owner@vger.kernel.org
To: Alban <albeu@free.fr>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Alban,

> On Wed, 17 Feb 2016 12:58:20 +0100
> Gabor Juhos <juhosg@openwrt.org> wrote:
> 
>> The RB532 platform specific irq_to_gpio() implementation has been
>> removed with commit 832f5dacfa0b ("MIPS: Remove all the uses of
>> custom gpio.h"). Now the platform uses the generic stub which causes
>> the following error:
>>
>>   pata-rb532-cf pata-rb532-cf: no GPIO found for irq149
>>   pata-rb532-cf: probe of pata-rb532-cf failed with error -2
>>
>> Drop the irq_to_gpio() call and get the GPIO number from platform
>> data instead. After this change, the driver works again:
> 
> I think it would be preferable to move this driver to use the gpiod
> API. The changes needed should be about the same size and it would
> be a much more future proof fix.

The sole purpose of this patch is that to fix the breakage introduced in
832f5dacfa0b. Before that change, the driver was working without using the gpiod
API, and it is working again after this change.

Converting the driver to use the gpiod API needs more changes. Even if that is
preferable it should be implemented in separate patch(es) in my opinion.

-Gabor
