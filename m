From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Wed, 2 Mar 2016 10:27:51 +0100
Message-ID: <56D6B217.2000701@xilinx.com>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <3802E9A6666DF54886E2B9CBF743BA9825E025F6@XAP-PVEXMBX01.xlnx.xilinx.com>
 <56D69EDD.40400@xilinx.com> <3012728.7zDNPtQ7kR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3012728.7zDNPtQ7kR@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: Anurag Kumar Vulisha <anuragku@xilinx.com>, Rob Herring <robh@kernel.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>
List-Id: linux-ide@vger.kernel.org

On 2.3.2016 10:11, Arnd Bergmann wrote:
> On Wednesday 02 March 2016 09:05:49 Michal Simek wrote:
>> On 2.3.2016 06:53, Anurag Kumar Vulisha wrote:
>>>>>>>
>>>>>>> I would probably make this dependent on the compatible string
>>>>>>> instead, and have a table in the device driver that uses a
>>>>>>> specific value for each variant of the device, but either way should be
>>>> fine.
>>>>>>>
>>>>>>> Having a separate property is most appropriate if for each
>>>>>>> hardware revision there is exactly one ideal value, while a table
>>>>>>> in the driver makes more sense if this takes a bit of tuning and
>>>>>>> the driver might choose to optimize it differently based on other
>>>>>>> constraints, such as its own interrupt handler implementation.
>>
>> that 0x40 is value choose based on testing that it is not causing any
>> visible problem and this is used as default value in the driver
>> (PTC_RX_WM_VAL - ahci_ceva.c)
>>
>> Values which you can setup are in range 0x0 - 0x7f (7bits). It means
>> hardware fifo size is probably 0x80.
>>
>> And this dt/module parameter is IMHO just sw setting setup by user.
>> It means I am not quite sure that this is DT parameter because it is
>> just SW setting.
>> I expect this range will be valid for all silicon revisions.
>> If happen that any silicon revision can't setup certain level because of
>> HW bug we can handle it via DT parameter or specific compatible string.
>> But setting up watermark SW level via DT doesn't look correct to me.
>>
>> Please let me know what you think.
> 
> Ok, thanks for the background. I think we should just leave it to be
> set by the driver then. Please make sure that each SoC specific .dtsi
> file has a unique "compatible" string for the device though, so that
> the driver can later override it based on the specific variant if
> that ends up being necessary for performance or bug-avoidance.

No problem with default value in driver. Something has to be setup.
Reset value based on reg spec I was checking is 0x20. Based on our
testing we saw some issues that's why 0x40 was setup as default value.
There is a need to be able to configure this value for example for
testing different values that's why I think module parameter should be
the right way to go.

If this should be DT parameters there should be different ceva IP which
allows different fifo size and different watermark level to be setup by
user.

What do you think? Does it sound reasonable.

Thanks,
Michal
