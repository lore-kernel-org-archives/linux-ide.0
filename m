From: Valentine <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH V2 2/2] dt: Document sata_rcar bindings
Date: Fri, 08 Nov 2013 15:26:46 +0400
Message-ID: <527CCA76.5060706@cogentembedded.com>
References: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com> <1383854642-21660-3-git-send-email-valentine.barshak@cogentembedded.com> <7820946.JfD46VSKC7@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <7820946.JfD46VSKC7@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

On 11/08/2013 05:02 AM, Laurent Pinchart wrote:
> Hi Valentine,
>

Hi Laurent,

> Thank you for the patch. Two small comments below.
>
> On Friday 08 November 2013 00:04:02 Valentine Barshak wrote:
>> These bindings can be used to register SATA devices found on R-Car SoC.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> Acked-by: Kumar Gala <galak@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/ata/sata_rcar.txt | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt
>> b/Documentation/devicetree/bindings/ata/sata_rcar.txt new file mode 100644
>> index 0000000..d6b20a6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
>> @@ -0,0 +1,18 @@
>> +* Renesas R-Car SATA
>> +
>> +Required properties:
>> +- compatible		: should contain one of the following:
>> +			  - "renesas,sata-r8a7779" for R-Car H1
>> +			  - "renesas,sata-r8a7790" for R-Car H2
>> +			  - "renesas,sata-r8a7791" for R-Car M2
>> +- reg			: offset and length of the SATA registers;
>
> Maybe address instead of offset ?

OK.

>
>> +- interrupts		: must consist of one interrupt specifier.
>> +
>> +Example:
>> +
>> +sata: sata@fc600000 {
>> +	compatible = "renesas,sata-r8a7779";
>> +	reg = <0xfc600000 0x2000>;
>> +	interrupt-parent = <&gic>;
>> +	interrupts = <0 100 0x4>;
>
> Please use IRQ_TYPE_LEVEL_HIGH instead of 0x4.

OK, I'll do that.

Please, note that all the Renesas dts[i] files do not include <dt-bindings/interrupt-controller/irq.h>
Thus, blindly following this bindings documentation when adding new SATA nodes to the existing
r8a7790.dtsi, for example, will cause DT compilation error.

>
>> +};

Thanks,
Val.

