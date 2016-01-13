From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Wed, 13 Jan 2016 10:55:04 -0600
Message-ID: <56968168.4010606@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <9923043.nz8DJ6lRiJ@wuerfel> <5693FAC2.4070003@amd.com>
 <4689728.Nn3Rl2cUeP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4689728.Nn3Rl2cUeP@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brijesh.singh@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/12/2016 08:24 AM, Arnd Bergmann wrote:
>>>
>>> Isn't this the thing that ACPI based firmware would handle using AML anyway?
>>> I don't think the server people would be too happy to add a new driver
>>> each time a SATA controller does the LEDs slightly differently, and this
>>> is really the kind of platform specific hack that AML is meant for.
>>>
>> Sorry I am not able understand your comment, Could you please explain me what you mean by AML is meant for this kind of platform specific hack ?
>>
> 
> I meant the sgpio register should not be exposed through a resource on
> an ACPI based system but the access be hidden behind a call into an AML
> method.
> 
> You basically extend the generic AHCI driver to understand three ways of
> blinking the LEDS:
> 
> a) standard AHCI enclosure management
> b) the Linux LED subsystem using whatever LED implementation the platform provides

Yes I could look into exploring LED implementation for DT case.

> c) calling into the ACPI interpreter to do platform specific hacks

Thanks for explaining. Now I understood your comment on AML however we need to consider the following:

a) activity LED blinking routines are called very frequent (10 to 100ms based on emp->state) and executing AML method that often would introduces its own overhead.

b) all BIOS vendors need to implement a new methods in their DSDT and release a new BIOS.

c) other OS'es (mainly Windows) driver need to be updated.


We don't know how many other SoC's have similar hacky implementation which can take advantage of extending generic
AHCI driver to call into AML methods for LED blink. Given some of these causes I think having a platform driver is much cleaner. I can drop DT binding part from this driver and keep just ACPI binding.

Thoughts ?

-Brijesh

> 
> 	Arnd
> 
