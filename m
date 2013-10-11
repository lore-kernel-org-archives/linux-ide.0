From: Valentine <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH] ata: sata_rcar: Add RCAR Gen2 SATA PHY support
Date: Fri, 11 Oct 2013 19:14:39 +0400
Message-ID: <525815DF.4040707@cogentembedded.com>
References: <1381432083-3684-1-git-send-email-valentine.barshak@cogentembedded.com> <20131011010032.GA13809@verge.net.au> <20131011094156.GF3910@e106331-lin.cambridge.arm.com> <5257D8FC.3040405@cogentembedded.com> <20131011144741.GA16477@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131011144741.GA16477@e106331-lin.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 10/11/2013 06:47 PM, Mark Rutland wrote:
> On Fri, Oct 11, 2013 at 11:54:52AM +0100, Valentine wrote:
>> On 10/11/2013 01:41 PM, Mark Rutland wrote:
>>> On Fri, Oct 11, 2013 at 02:00:35AM +0100, Simon Horman wrote:
>>>> [ CCed devicetree@vger.kernel.org as this involves DT compatibility strings ]
>>>
>>> Cheers!
>>>
>>
>> Hi Mark,
>>
>>>>
>>>> On Thu, Oct 10, 2013 at 11:08:03PM +0400, Valentine Barshak wrote:
>>>>> RCAR Gen2 SoC has a different phy which is not compatible with
>>>>> the older H1/M1 versions. This adds OF/platform device table
>>>>> and PHY initialization callbacks for H2/M2 (Gen2) SoC.
>>>
>>> Is the PHY combined with the rest of the controller, or are they
>>> logically separate components in the SoC? I note that the Calxeda
>>> Highbank SATA controller driver treats the phy and the controller as
>>> separate entities, and describes the way the two are attached (though
>>> the driver handles both). Would a similar approach work here?
>>>
>>
>> It seems to be described in the docs as a single entity with the rest of
>> the controller. The phy registers are in the same address space block.
>> We don't need to describe how the phy is attached to the SATA
>> controller. In the future we may need some phy-specific configuration in
>> the device tree. For example, to describe how clock generator is
>> connected to the controller. I think this could be done with optional
>> properties added to the SATA node if needed.
>
> As they're tightly coupled and share the same register block, I guess
> describing them together is ok. Is that clock example hypothetical, or
> something we _will_ need in future?

According to the manual there's some configuration possible,
though it's not verbosely described:
* SSCG (on/off)
* Clock connection (AC/DC)
* Termination Resistor (on/off)

AFAIU, this describes how the external clock generator is connected.
All available Gen2 boards use the same generator type and
the same "default" phy settings (SSCG off/DC/TR on).

It is possible set spread spectrum with a switch on the board (it is 
disabled by default)

I don't know if we will need to change those settings in the future.
Probably this could be done as a separate patch if needed.

>
>>
>>> [...]
>>>
>>>>> +static struct of_device_id sata_rcar_match[] = {
>>>>> +	{
>>>>> +		.compatible = "renesas,rcar-sata",
>>>>> +		.data = (void *)RCAR_SATA
>>>>> +	},
>>>>> +	{
>>>>> +		.compatible = "renesas,sata-r8a7790",
>>>>> +		.data = (void *)RCAR_GEN2_SATA
>>>>> +	},
>>>>> +	{
>>>>> +		.compatible = "renesas,sata-r8a7791",
>>>>> +		.data = (void *)RCAR_GEN2_SATA
>>>>> +	},
>>>>> +	{},
>>>
>>> These bindings will need documentation. A grep of any of these in
>>> mainline's Documentation/devicetree shows up nothing (not even the
>>> existing "renesas,rcar-sata" string used by the driver.
>>
>> Indeed.
>> Since we need to adjust rcar-sata bindings and add documentation for it,
>> which is not really related to Gen2 phy support, looks like it will be a
>> separate patch.
>
> If you're adding strings, there should be documentation. While it may be
> a separate patch, we should _not_ add compatible strings to the kernel
> without documentation. I'd like to see the documentation patch first.

Right. I meant that there should be a separate patch that adds 
documentation for the already existing binding.
I think I'll make a couple of patches then:
* Adjust and document the existing bindings as Simon has suggested
* Add Gen2 support and document Ge2 bindings.

>
> Thanks,
> Mark.
>

Thanks,
Val.
