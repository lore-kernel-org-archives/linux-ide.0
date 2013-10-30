From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 2/2] sata_rcar: Add R-Car Gen2 SATA PHY support
Date: Wed, 30 Oct 2013 02:05:05 -0500
Message-ID: <C014C8E4-6305-42D0-8D12-7B2532896433@codeaurora.org>
References: <1381925161-16729-1-git-send-email-valentine.barshak@cogentembedded.com> <1381925161-16729-3-git-send-email-valentine.barshak@cogentembedded.com> <20131029045943.GE20432@verge.net.au> <B6798662-4DEC-499A-A96E-EB995A482C1B@codeaurora.org> <20131029084444.GC15731@verge.net.au> <82E941A8-D062-4E90-B661-511881F51F9B@codeaurora.org> <20131030002847.GL21262@verge.net.au>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20131030002847.GL21262@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org


On Oct 29, 2013, at 7:28 PM, Simon Horman wrote:

> On Tue, Oct 29, 2013 at 12:19:08PM -0500, Kumar Gala wrote:
>> 
>> On Oct 29, 2013, at 3:44 AM, Simon Horman wrote:
>> 
>>> On Tue, Oct 29, 2013 at 03:24:16AM -0500, Kumar Gala wrote:
>>>> 
>>>> On Oct 28, 2013, at 11:59 PM, Simon Horman wrote:
>>>> 
>>>>> On Wed, Oct 16, 2013 at 04:06:01PM +0400, Valentine Barshak wrote:
>>>>>> R-Car Gen2 SoCs have a different PHY which is not compatible
>>>>>> with the older R-Car H1 (R8A7779) version.
>>>>>> This adds OF/platform device id tables and PHY initialization
>>>>>> callbacks for the following Gen2 SoCs:
>>>>>> * R-Car H2: R8A7790;
>>>>>> * R-Car M2: R8A7791.
>>>>>> 
>>>>>> PHY initialization method is chosen based on the device id.
>>>>>> Default PHY settings are applied for Gen2 SoCs, which should
>>>>>> suit the Gen2 boards available.
>>>>>> 
>>>>>> The R8A7779 platform code is modified to use "sata-r8a7779"
>>>>>> device name.
>>>>>> 
>>>>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>>>>> ---
>>>>>> .../devicetree/bindings/ata/sata_rcar.txt          |   5 +-
>>>>>> arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
>>>>>> arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
>>>>>> drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---
>>>>> 
>>>>> Hi Mark, Hi Device-Tree Folks,
>>>>> 
>>>>> I'm wondering if you have had a chance to look over the bindings
>>>>> aspect of this and the other patch in the series. I believe that
>>>>> this series addresses all previous review in that regards.
>>>> 
>>>> What tree is this binding in?
>>> 
>>> sata_car.txt is added by the previous patch in this series
>>> "[PATCH 1/2] sata_rcar: Adjust and document device tree bindings"
>> 
>> Why not just have all the binding in one patch.  There isn't a reason this should be split.
> 
> I think that the motivation was that the first patch documents the
> existing implementation while the second documents a change to it.
> With that in mind would you still like a single patch for the binding?

Yes, I see no reason to split this up as you know both right now.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

