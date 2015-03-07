From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] SATA: OCTEON: support SATA on OCTEON platform
Date: Sat, 07 Mar 2015 13:06:48 +0100
Message-ID: <54FAE9D8.9050206@redhat.com>
References: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com> <54F97C27.508@redhat.com> <54F9D4E2.20107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbbCGMI0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Mar 2015 07:08:26 -0500
In-Reply-To: <54F9D4E2.20107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@auriga.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>, Vinita Gupta <vgupta@caviumnetworks.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org

Hi,

On 06-03-15 17:25, David Daney wrote:
> On 03/06/2015 02:06 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 05-03-15 15:58, Aleksey Makarov wrote:
>>> The OCTEON SATA controller is currently found on cn71XX devices.
>>>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>>> ---
> [...]
>>> diff --git
>>> a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>>> b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>>> new file mode 100644
>>> index 0000000..59e86a7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>>> @@ -0,0 +1,28 @@
>>> +* UCTL SATA controller glue
>>> +
>>> +Properties:
>>> +- compatible: "cavium,octeon-7130-sata-uctl"
>>> +
>>> +  Compatibility with the cn7130 SOC.
>>> +
>>> +- reg: The base address of the UCTL register bank.
>>> +
>>> +- #address-cells, #size-cells, and ranges must be present and hold
>>> +    suitable values to map all child nodes.
>>> +
>>> +Example:
>>> +
>>> +    uctl@118006c000000 {
>>> +        compatible = "cavium,octeon-7130-sata-uctl";
>>> +        reg = <0x11800 0x6c000000 0x0 0x100>;
>>> +        ranges; /* Direct mapping */
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        sata: sata@16c0000000000 {
>>> +            compatible = "cavium,octeon-7130-ahci";
>>> +            reg = <0x16c00 0x00000000 0x0 0x200>;
>>> +            interrupt-parent = <&cibsata>;
>>> +            interrupts = <2 4>; /* Bit: 2, level */
>>> +        };
>>> +    };
>>
>> Sorry for jumping into this discussion a bit late, but this nonsense
>> nesting of what clearly are 2 related but different hw blocks,
>> both living at completely different register addresses is unacceptable,
>> this is not a proper operating system dependent hw description as
>> devicetree is supposed to be. This is an ugly hack to ensure a
>> certain init ordering, and requiring manual instantiation of
>> the platform device for the nested dt-node.
>>
>> NACK.
>
> Can you point to the portion of the device tree specification that states that if a node has both "reg" *and* "ranges" properties, the parent-bus-address ranges must be a proper subset of the "reg" property ranges of the parent?   Because that seems like what you are saying here.  I would really like to read the documentation myself so that we can get a better understanding of the requirements.

This is not a written rule, it is just logic to not represent something
nested in devicetree while the real world address space it sits in is
flat. As said devicetree is about (accurately) describing hardware,
and having nesting in the devicetree where there is no nesting in the
real hardware is just wrong.

> For what it's worth, there are existing bindings that take the same form, and they don't seem to break anything.  See for example Documentation/devicetree/bindings/mips/cavium/uctl.txt

I'm not claiming that this will not work, just that it is wrong from
a conceptual pov IMHO.

> In any event, it is somewhat moot at this point.  The device tree being effectively being a frozen ABI, cannot really be changed.  We are merely documenting what is supplied by the preexisting system boot ROMs, not starting from scratch and discussing what the proper device tree binding for the device should be.

Ah I see, I did not know that this was already a shipped ABI.

Given that the devicetree ABI is fixed, and that that was my only
reason for NACK-ing this patch, I hereby withdraw my NACK.

Other then the dt bindings issue, the code looks good, so this
patch is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
