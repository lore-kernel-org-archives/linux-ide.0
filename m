From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: sunxi: Add an ahci-platform
 compatible AHCI driver for the Allwinner SUNXi series of SoCs
Date: Wed, 04 Dec 2013 13:49:59 +0100
Message-ID: <529F24F7.40309@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl> <1386159055-10264-3-git-send-email-oliver@schinagl.nl> <20131204122602.GN16025@e106331-lin.cambridge.arm.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBT6K7SKAKGQEVX7EDTY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131204122602.GN16025-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org" <dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org" <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org


On 04-12-13 13:26, Mark Rutland wrote:
> On Wed, Dec 04, 2013 at 12:10:54PM +0000, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org wrote:
>> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>>
>> This patch adds support for the sunxi series of SoC's by allwinner. It
>> plugs into the ahci-platform framework.
>>
>> Note: Currently it uses a somewhat hackish approach that probably needs
>> a lot more work, but does the same as the IMX SoC's.
>>
>> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>> ---
>>   .../devicetree/bindings/ata/ahci-sunxi.txt         |  24 ++
>>   drivers/ata/Kconfig                                |   9 +
>>   drivers/ata/Makefile                               |   1 +
>>   drivers/ata/ahci_platform.c                        |  12 +
>>   drivers/ata/ahci_sunxi.c                           | 305 +++++++++++++++++++++
>>   5 files changed, 351 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ata/ahci-sunxi.txt
>>   create mode 100644 drivers/ata/ahci_sunxi.c
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-sunxi.txt b/Documentation/devicetree/bindings/ata/ahci-sunxi.txt
>> new file mode 100644
>> index 0000000..0792fa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/ahci-sunxi.txt
>> @@ -0,0 +1,24 @@
>> +Allwinner SUNXI AHCI SATA Controller
>> +
>> +SATA nodes are defined to describe on-chip Serial ATA controllers.
>> +Each SATA controller should have its own node.
>> +
>> +Required properties:
>> +- compatible   : compatible list, contains "allwinner,sun4i-a10-ahci"
> - compatible: Should contain "allwinner,sun4i-a10-ahci"
>
>> +- reg          : <registers mapping>
> - reg: The offset and length of the MMIO registers.
>
>> +- interrupts   : <interrupt mapping for AHCI IRQ>
> - interrupts: An interrupt-specifier for the ACHI interrupt
>
>> +- clocks       : clocks for ACHI
>> +- clock-names  : clock names for AHCI
> Please _define_ the set of clock-names you expect. This binding is
> meaningless without it. If you require clock-names, define the clocks
> property in terms of it.
I copied ahci_platform.txt and filled in the missing bits, I will 
improve all the above. Appologies!
>
> Thanks,
> Mark.
