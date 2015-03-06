From: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] SATA: OCTEON: support SATA on OCTEON platform
Date: Fri, 06 Mar 2015 08:25:06 -0800
Message-ID: <54F9D4E2.20107@gmail.com>
References: <1425567540-31572-1-git-send-email-aleksey.makarov@auriga.com> <54F97C27.508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54F97C27.508-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Vinita Gupta <vgupta-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 03/06/2015 02:06 AM, Hans de Goede wrote:
> Hi,
>
> On 05-03-15 15:58, Aleksey Makarov wrote:
>> The OCTEON SATA controller is currently found on cn71XX devices.
>>
>> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Vinita Gupta <vgupta-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>
>> ---
[...]
>> diff --git
>> a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> new file mode 100644
>> index 0000000..59e86a7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> @@ -0,0 +1,28 @@
>> +* UCTL SATA controller glue
>> +
>> +Properties:
>> +- compatible: "cavium,octeon-7130-sata-uctl"
>> +
>> +  Compatibility with the cn7130 SOC.
>> +
>> +- reg: The base address of the UCTL register bank.
>> +
>> +- #address-cells, #size-cells, and ranges must be present and hold
>> +    suitable values to map all child nodes.
>> +
>> +Example:
>> +
>> +    uctl@118006c000000 {
>> +        compatible = "cavium,octeon-7130-sata-uctl";
>> +        reg = <0x11800 0x6c000000 0x0 0x100>;
>> +        ranges; /* Direct mapping */
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        sata: sata@16c0000000000 {
>> +            compatible = "cavium,octeon-7130-ahci";
>> +            reg = <0x16c00 0x00000000 0x0 0x200>;
>> +            interrupt-parent = <&cibsata>;
>> +            interrupts = <2 4>; /* Bit: 2, level */
>> +        };
>> +    };
>
> Sorry for jumping into this discussion a bit late, but this nonsense
> nesting of what clearly are 2 related but different hw blocks,
> both living at completely different register addresses is unacceptable,
> this is not a proper operating system dependent hw description as
> devicetree is supposed to be. This is an ugly hack to ensure a
> certain init ordering, and requiring manual instantiation of
> the platform device for the nested dt-node.
>
> NACK.

Can you point to the portion of the device tree specification that 
states that if a node has both "reg" *and* "ranges" properties, the 
parent-bus-address ranges must be a proper subset of the "reg" property 
ranges of the parent?   Because that seems like what you are saying 
here.  I would really like to read the documentation myself so that we 
can get a better understanding of the requirements.

For what it's worth, there are existing bindings that take the same 
form, and they don't seem to break anything.  See for example 
Documentation/devicetree/bindings/mips/cavium/uctl.txt

In any event, it is somewhat moot at this point.  The device tree being 
effectively being a frozen ABI, cannot really be changed.  We are merely 
documenting what is supplied by the preexisting system boot ROMs, not 
starting from scratch and discussing what the proper device tree binding 
for the device should be.

Thanks,
David Daney


[...]
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
