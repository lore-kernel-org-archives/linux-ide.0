From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/6] phy: add a driver for the Berlin SATA PHY
Date: Thu, 15 May 2014 11:17:35 +0200
Message-ID: <5374862F.2020205@gmail.com>
References: <1400060942-10588-1-git-send-email-antoine.tenart@free-electrons.com> <20140514165722.GA18495@kwain> <5373AE9A.3050008@gmail.com> <5764751.ffUj9rhnMd@wuerfel> <5373B908.5090904@gmail.com> <537462A2.5020607@ti.com> <5374668F.4060109@gmail.com> <53747F03.5030206@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53747F03.5030206-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 05/15/2014 10:46 AM, Kishon Vijay Abraham I wrote:
> On Thursday 15 May 2014 12:32 PM, Sebastian Hesselbarth wrote:
>> On 05/15/2014 08:45 AM, Kishon Vijay Abraham I wrote:
>>> On Thursday 15 May 2014 12:12 AM, Sebastian Hesselbarth wrote:
>>>> On 05/14/2014 08:12 PM, Arnd Bergmann wrote:
>>>>> On Wednesday 14 May 2014 19:57:46 Sebastian Hesselbarth wrote:
>>>>>> Let's assume we have one dual-port SATA controller and one PCIe
>>>>>> controller with either x1 or x2 support. The only sane DT binding,
>>>>>> I can think of then would be:
>>>>>>
>>>>>> berlin2q.dtsi:
>>>>>>
>>>>>> genphy: lvds@ea00ff {
>>>>>> 	compatible = "marvell,berlin-lvds-phy";
>>>>>> 	reg = <0xea00ff 0x100>;
>>>>>> 	#phy-cells = <2>;
>>>>>> };
[...]
>>
>> Depends on what you call PHY. In the example above the PHY is what
>> allows you to control both lanes.
>>
>> So you want sub-nodes for each individual lane given the nomenclature
>> of the example?
>>
>> Or like it is used in the example above, a single PHY node with an index
>> in the phy-specifier to pick an individual lane.
>>
>> IMHO, having both phy-specifier index _and_ PHY sub-node per lane
>> has no benefit at all. You cannot even use the PHY sub-nodes for any
>> setup properties, as they depend on the consumer claiming the lane.
>
> IMO the dt data should completely describe the HW. So just by looking at the
> PHY node, we won't be able to tell the no of PHYs implemented in the IP if we
> have a single PHY node (In this case the lanes in the IP).
>
> However if you think it's an overkill for having sub-nodes for each lane then
> single PHY node is fine too.

Yeah, I see your point. I just wonder how many Marvell PHYs we may hit
that require the _same_ magic setup inside but have _different_ number
of lanes. And even if, we can deal with it using a different compatible
string.

Currently, I feel a single PHY provider node and a set of compatibles
will be most likely, i.e. no per-lane sub-nodes. OTOH, the per-lane
sub-nodes is more generic as it allows us to deal PHYs that may
suddenly skip one lane in the numbering scheme. The difference for the
driver is marginal, i.e. some SoC-specific struct with a field for the
number of lanes vs. of_count_child_nodes() and a reg = <n> property for
the per-lane sub-nodes.

I used to agree to "DT should descibe HW", but with no datasheet
available, it quickly becomes fuzzy what it really looks like.

Anyway, I'll have some discussion with Antoine and Alexandre to sort out
the differences and the things in common for the PHY and SoCs in
question.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
