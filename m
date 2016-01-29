From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Fri, 29 Jan 2016 22:22:39 +0100
Message-ID: <3904852.c3HykPsQQ2@wuerfel>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com> <5730117.gx9ezcyLp7@wuerfel> <56A7A534.6040208@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A7A534.6040208@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tuesday 26 January 2016 10:56:20 Brijesh Singh wrote:
> 
> On 01/26/2016 06:17 AM, Arnd Bergmann wrote:
> > 
> > I think it needs more work: The changelog describes it as a normal
> > driver, but based on the previous discussion, this is just a hack
> > to work around broken BIOS versions that can no longer be fixed in
> > the field, and there has not been a decision what the proper
> > representation should be in ACPI.
> > 
> I am not sure if we should label this driver as a hack to workaround the
> broken BIOS. Unfortunately SoC did not implemented the enclosure management
> per spec. Its not BIOS issue.

The BIOS issue is how the hardware workaround is represented. The
idea of ACPI is to hide this kind of glitch from the operating system
instead of forcing it to have a driver for each hardware variant.

> > The patch also fails to address the devicetree based case, even though
> > we did come to a conclusion that the current behavior is a regression
> > (compared to what we had in drivers/ide/) and that there is a relatively
> > simple fix to do it right.
> > 
> I did looked at your recommendation for extending libahci to use ledtrig_ide_activity()
> but as I pointed out in previous discussion this function is missing several key features
> from EM (enclosure management) pov. e.g missing the slot number, missing the locate and fault led.
> In case of EM, each port will have at least three leds (activity, locate and fault). 
> Since these LED's are part of EM hence we need to ensure that tools like ledmon and ledctl (which uses libahci sysfs) works well.

I'd assume this can be easily extended, we just need to come up with
a naming scheme for the LEDs so we can identify them in DT.

> The main question is, what is recommended approach to override libachi enclosure managements
> transfer led messages function? A platform driver or something else.
> 
> Tejun and/or Hans do you have any recommendation ?

I think for the DT case, a platform driver that registers itself to the LED
subsystem is the best way. You probably still want to put the hardware
register into a "syscon" device that contains the entire set of registers
around it (presumably more hacks for other hardware features), and then
just reference the register using a regmap from the LED driver. The generic
AHCI driver can then get extended with supports for the LED subsystem, to
look for specific LEDs by name based on lot number and type of LED.

Those can be present on any machine with a generic AHCI implementation,
and can be easily implemented using the GPIO-LED driver on machines that
don't have a special purpose register for them.

For the ACPI case, I still think that an AML call from the AHCI driver
is the most logical solution. You mentioned that you believe that calling
into the AML interpreter up to 100 times per second is a noticeable
overhead, but I doubt that and would like to see actual number backing
that up. Note that most of the time, the status of the LEDs won't even
change, so the driver does not have to call into the AML while I/O
is in progress, or while it is stopped, only for the transition or in
case of locate and fault events that should be extremely rare.

	Arnd
