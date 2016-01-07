From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Thu, 7 Jan 2016 16:24:22 -0600
Message-ID: <568EE596.3060005@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4652600.rUhSEOUPkl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4652600.rUhSEOUPkl@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brijesh.singh@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,


>> +
>> +Examples:
>> +        sata0@e0300000 {
>> +		compatible = "amd,seattle-ahci";
>> +		reg = <0x0 0xe0300000 0x0 0xf0000>, <0x0 0xe0000078 0x0 0x1>;
> 
> Looking at the register values, I doubt that the SGPIO is actually part of the
> sata device. More likely, you are pointing in the middle of an actual
> GPIO controller.
> 

That address is SGPIO control register for SATA. The current hardware implementation to control activity LED is not ideal.

A57 does not have access to GPIO's connected to backplane controller instead SoC has exposed two SGPIO 
control registers (LSIOC_SGPIO_CONTROL0: 0xE000_0078 and LSIOC_SGPIO_CONTROL1: 0xE000_007C) to A57. All we 
need to do is to program these registers based on the disk activity. The firmware running on A5 reads the values
and generate proper SGPIO timing and toggles the LEDs etc.

These registers are defined in SATA0/1 DSDT resource template and also documented in SoC BKDG. I just noticed that BKDG has wrong register definition so will ask documentation folks to fix that.

This driver is using SGPIO LED control similar to sata_highbank [1] except bit bang GPIO (which is done by firmware).

[1] http://lxr.free-electrons.com/source/drivers/ata/sata_highbank.c#L140


> If so, please implement a GPIO driver for that device, and use the gpio-leds
> driver to drive the LEDs. IIRC there is already a generic way to communicate
> with the LEDs interface from libata, if not you can implement that in order
> to keep the special case out of the platform driver.
> 
>> +		interrupts = <0x0 0x163 0x4>;
>> +		clocks = <0x2>
> 
> This is not a valid property.
> 
>> +/* SGPIO Control Register definition
>> + *
>> + * Bit		Type		Description
>> + * 31		RW		OD7.2 (activity)
>> + * 30		RW		OD7.1 (locate)
>> + * 29		RW		OD7.0 (fault)
>> + * 28...8	RW		OD6.2...OD0.0 (3bits per port, 1 bit per LED)
>> + * 7		RO		SGPIO feature flag
>> + * 6:4		RO		Reserved
>> + * 3:0		RO		Number of ports (0 means no port supported)
>> + */
> 
> The 'reg' property in your example is only 8 bits wide, the above lists
> 32 bits.
> 
> 	Arnd
> 
