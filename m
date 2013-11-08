From: Valentine <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH V3 2/2] dt: Document sata_rcar bindings
Date: Sat, 09 Nov 2013 00:30:45 +0400
Message-ID: <527D49F5.9030704@cogentembedded.com>
References: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com> <1383912570-8393-3-git-send-email-valentine.barshak@cogentembedded.com> <E0BF568D-6856-4DDE-AEBA-7C21CB1CE1F3@codeaurora.org> <3353398.KxY2PdxubL@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:60481 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977Ab3KHUat (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Nov 2013 15:30:49 -0500
Received: by mail-la0-f41.google.com with SMTP id ea20so2269180lab.14
        for <linux-ide@vger.kernel.org>; Fri, 08 Nov 2013 12:30:47 -0800 (PST)
In-Reply-To: <3353398.KxY2PdxubL@avalon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

On 11/08/2013 06:30 PM, Laurent Pinchart wrote:
> Hi Kumar,
>
> On Friday 08 November 2013 08:26:47 Kumar Gala wrote:
>> On Nov 8, 2013, at 6:09 AM, Valentine Barshak wrote:
>>> These bindings can be used to register SATA devices found on R-Car SoC.
>>>
>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>> ---
>>> Documentation/devicetree/bindings/ata/sata_rcar.txt | 18 +++++++++++++++++
>>> 1 file changed, 18 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt
>>> b/Documentation/devicetree/bindings/ata/sata_rcar.txt new file mode
>>> 100644
>>> index 0000000..1e61113
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
>>> @@ -0,0 +1,18 @@
>>> +* Renesas R-Car SATA
>>> +
>>> +Required properties:
>>> +- compatible		: should contain one of the following:
>>> +			  - "renesas,sata-r8a7779" for R-Car H1
>>> +			  - "renesas,sata-r8a7790" for R-Car H2
>>> +			  - "renesas,sata-r8a7791" for R-Car M2
>>> +- reg			: address and length of the SATA registers;
>>> +- interrupts		: must consist of one interrupt specifier.
>>> +
>>> +Example:
>>> +
>>> +sata: sata@fc600000 {
>>> +	compatible = "renesas,sata-r8a7779";
>>> +	reg = <0xfc600000 0x2000>;
>>> +	interrupt-parent = <&gic>;
>>> +	interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
>>
>> Sorry, I missed the discussion on this, but I think it would be better in
>> the example to leave this as 4.  There is no reference in the binding at
>> all to figure out where IRQ_TYPE_LEVEL_HIGH is defined.
>
> Then I'd rather reference the interrupts binding document, otherwise people
> will blindly write device tree sources with 4 instead of IRQ_TYPE_LEVEL_HIGH,
> which I don't want to encourage.
>
>>> +};

Is it possible to get the functional SATA phy changes from the first patch applied
and have a separate discussion regarding DT bindings?
This DT discussion is not related to the SATA PHY changes.
There were comments to keep both patches as a single series, but I don't see any reason
for that anymore.

Thanks,
Val.
