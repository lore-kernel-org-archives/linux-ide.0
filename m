From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from
 device-tree
Date: Wed, 2 Mar 2016 09:05:49 +0100
Message-ID: <56D69EDD.40400@xilinx.com>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
 <18251200.Xfr10N5eWq@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E01009@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8540232.vQE3WQTD95@wuerfel>
 <3802E9A6666DF54886E2B9CBF743BA9825E0117F@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160223192942.GA6235@rob-hp-laptop>
 <3802E9A6666DF54886E2B9CBF743BA9825E025F6@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3802E9A6666DF54886E2B9CBF743BA9825E025F6@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anurag Kumar Vulisha <anuragku@xilinx.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>
List-Id: linux-ide@vger.kernel.org

Hi Rob and Arnd,

On 2.3.2016 06:53, Anurag Kumar Vulisha wrote:
> + Michal
> 
>> -----Original Message-----
>> From: Anurag Kumar Vulisha
>> Sent: Friday, February 26, 2016 7:18 PM
>> To: 'Rob Herring'
>> Cc: Arnd Bergmann; pawel.moll@arm.com; mark.rutland@arm.com;
>> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; tj@kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah Choudary
>> Kalluri
>> Subject: RE: [RFC PATCH] drivers: ata: Read Rx water mark value from device-
>> tree
>>
>> Hi Rob,
>>
>>> -----Original Message-----
>>> From: Rob Herring [mailto:robh@kernel.org]
>>> Sent: Wednesday, February 24, 2016 1:00 AM
>>> To: Anurag Kumar Vulisha
>>> Cc: Arnd Bergmann; pawel.moll@arm.com; mark.rutland@arm.com;
>>> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; tj@kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>>> ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah
>>> Choudary Kalluri
>>> Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from
>>> device- tree
>>>
>>> On Tue, Feb 23, 2016 at 03:29:55PM +0000, Anurag Kumar Vulisha wrote:
>>>> Hi Arnd,
>>>>
>>>>> -----Original Message-----
>>>>> From: Arnd Bergmann [mailto:arnd@arndb.de]
>>>>> Sent: Tuesday, February 23, 2016 3:51 PM
>>>>> To: Anurag Kumar Vulisha
>>>>> Cc: robh+dt@kernel.org; pawel.moll@arm.com;
>> mark.rutland@arm.com;
>>>>> ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
>>>>> ijc+tj@kernel.org;
>>>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>>>>> ide@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Punnaiah
>>>>> Choudary Kalluri
>>>>> Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value
>>>>> from
>>>>> device- tree
>>>>>
>>>>> On Tuesday 23 February 2016 05:58:32 Anurag Kumar Vulisha wrote:
>>>>>>>
>>>>>>> I don't know what is appropriate because I have no idea what
>>>>>>> Rxwatermark is good for. Can you try describing why we can't
>>>>>>> just set it to the correct value for everyone automatically?
>>>>>>>
>>>>>>
>>>>>> This RX watermark level sets the minimum number of free
>>>>>> locations within the RX FIFO .When the rx fifo level crosses the
>>>>>> programmed watermark level ,sata controller  will transmit HOLDS
>>>>>> to the device asking it
>>>>> to wait. This happens when dma reads the rx fifo data slower than
>>>>> the device is sending the data. Note that it can take some time
>>>>> for the HOLDs to get to the other end and in the time there must
>>>>> be enough room in the FIFO to absorb all data that could arrive
>>>>> from the
>>> device.
>>>>>> Currently we are using 0x40 for this value, which works fine
>>>>>> with all hardware designs  we are currently having. But hoping
>>>>>> that this value may vary for future silicon versions, I wanted
>>>>>> to make this as a configurable
>>>>> value. So for this reason I thought of moving it either to
>>>>> device-tree or making it as a module_param() property.
>>>>>>
>>>>>
>>>>> Ok, so if this depends on the silicon version, your initial
>>>>> approach would be better than the module_param.
>>>>>
>>>>> I would probably make this dependent on the compatible string
>>>>> instead, and have a table in the device driver that uses a
>>>>> specific value for each variant of the device, but either way should be
>> fine.
>>>>>
>>>>> Having a separate property is most appropriate if for each
>>>>> hardware revision there is exactly one ideal value, while a table
>>>>> in the driver makes more sense if this takes a bit of tuning and
>>>>> the driver might choose to optimize it differently based on other
>>>>> constraints, such as its own interrupt handler implementation.

that 0x40 is value choose based on testing that it is not causing any
visible problem and this is used as default value in the driver
(PTC_RX_WM_VAL - ahci_ceva.c)

Values which you can setup are in range 0x0 - 0x7f (7bits). It means
hardware fifo size is probably 0x80.

And this dt/module parameter is IMHO just sw setting setup by user.
It means I am not quite sure that this is DT parameter because it is
just SW setting.
I expect this range will be valid for all silicon revisions.
If happen that any silicon revision can't setup certain level because of
HW bug we can handle it via DT parameter or specific compatible string.
But setting up watermark SW level via DT doesn't look correct to me.

Please let me know what you think.

Thanks,
Michal
