From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 01/14] devicetree: bindings: add bindings for ahci-da850
Date: Wed, 18 Jan 2017 14:35:23 +0530
Message-ID: <792384a9-a7d3-56f5-5178-f3b0f8e7114a@ti.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-2-git-send-email-bgolaszewski@baylibre.com>
 <7e3c8946-2a19-3e11-c071-b3737554005c@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7e3c8946-2a19-3e11-c071-b3737554005c@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Lechner <david@lechnology.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 18 January 2017 12:05 AM, David Lechner wrote:
> On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
>> Add DT bindings for the TI DA850 AHCI SATA controller.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/ata/ahci-da850.txt | 18
>> ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> new file mode 100644
>> index 0000000..e7111b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> @@ -0,0 +1,18 @@
>> +Device tree binding for the TI DA850 AHCI SATA Controller
>> +---------------------------------------------------------
>> +
>> +Required properties:
>> +  - compatible: must be "ti,da850-ahci"
>> +  - reg: physical base addresses and sizes of the controller's
>> register areas
>> +  - interrupts: interrupt specifier (refer to the interrupt binding)
>> +
>> +Optional properties:
>> +  - clocks: clock specifier (refer to the common clock binding)
> 
> Won't you also need a clock-names property since there are two clocks?
> 
>> +
>> +Example:
>> +
>> +    sata: ahci@218000 {
>> +        compatible = "ti,da850-ahci";
>> +        reg = <0x218000 0x2000>, <0x22c018 0x4>;
>> +        interrupts = <67>;
>> +    };
>>
> 
> It would be nice to have clocks and clock-names in the example as well.

Well, we don't use the common clock binding today. Is it really
necessary to add them now. Thats basically going to remain completely
untested.

I would drop the mention of clocks specification as an optional property
too.

Thanks,
Sekhar
