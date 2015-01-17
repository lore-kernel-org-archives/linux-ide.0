From: "jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [systemd-devel] Making udev emit a signal when it is done loading modules
Date: Sat, 17 Jan 2015 10:23:21 -0500
Message-ID: <CAKON4Ox-7YBqEkvor5wt6erSR1sFyz1N1t-0XUXO5cvN3pGtsA@mail.gmail.com>
References: <54BA20D0.7060402@redhat.com>
	<20150117135630.GA25585@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150117135630.GA25585-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Sat, Jan 17, 2015 at 8:56 AM, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:
>> Dear udev developers,
>>
>> We (me and some kernel devs mostly) would like to add support to
>> the kernel for userspace telling the kernel that it is done with
>> the *initial* loading of modules, with the purpose of cleaning up
>> (disabling) unused harware resources like e.g. regulators and
>> clocks.
>
> But you don't "know" when that happens.  Especially with discoverable
> busses (PCI, USB, etc.), you know this :)

Consider the ARM multi-arch kernels where everything is a loadable
device driver.

1) BIOS does basic system setup
2) Core kernel boots with very few drivers.
3) Late-init calls runs - does power/clock clean up and turns everything off
--everything in system blinks---
4) Now the modules start loading and devices all get turned back on.
These are loadable modules for hardware that is known to be present
since it is listed in the device tree.
-- better place to be doing power/clock clean up
5) Doesn't matter now if you load a module an hour later, you wanted
the clock/power turned off for that hour.

I know of two ways to fix this interval where the system blinks....
1) An enumerated protection scheme. Device tree lists out all of the
clock/regulators/etc... that it doesn't want the power cleanup turning
off. Then it hopes that a driver gets loaded that uses these devices.
If not those clock/regulators stay on forever. This is fragile and
requires coordination with the BIOS.
2) in my opinion power clean is happening too early. In needs to moved
after the initial phase of loading modules for device tree enumerated
devices.

Power/clock clean up does not need to be at an exact point in system
boot. It is just a clean up to reduce power consumption from things
the BIOS turned on that kernel does not use. It is usually not fatal
if it runs at the wrong point, but it makes everything blink when it
runs too early.

For example the automatic clean up could be removed from late_init
calls and turned into something that could be triggered from a script.
Then runs that script action late in the boot. Or if udev is smart
enough it could trigger cleanup after it has loaded modules for all
devices it is aware of. But any way you look at it, cleaning up in
late-init call for a multi-arch kernel is the too early.

>
>> Currently the kernel does this cleanup just before it starts init
>> (which may very well be init from a ramdisk). In some cases this
>> is too early really, because later on a module may get loaded
>> which needs this resources, these resources will then get turned
>> on again by the loaded driver, and most of the time this is not
>> an issue, but sometimes it is.
>>
>> I realize very well that there is no magic moment where udev is
>> really ever done loading modules, but the case which we want to
>> support only involves devices which are *already enumerated*, but
>> may not yet have a driver loaded, when udev starts. We would like
>> udev to emit a signal (ABI to be discussed) when it is done
>> trying to load modules for everything which was already enumerated
>> when it starts, iow when there are no new device events pending
>> anymore when udev does its initial hotplug replay.
>
> The kernel doesn't even "know" when this type of thing is, how can udev
> know this?
>
>> So the question to you is would you be willing to include such
>> functionality in udev ?  Note this signal would need to be emitted
>> when udev from the real rootfs is done with the initial module
>> loading, as the real rootfs may very well have more modules
>> available then the initrd.
>>
>> ###
>>
>> With the generic story above told let me also give the concrete
>> example / problem which has let to me asking this (note this has
>> been brought up before on various kernel lists, it is a
>> re-occuring theme, this is just an example really) :
>>
>> The problem at hand is a sata connector which also has a sata-power
>> connector on an embedded (ish) board where the sata-power is
>> controlled through a gpio. The sata-power connector is modeled
>> in devicetree as a power-supply and this supply gets controlled
>> by the ahci_platform driver.
>>
>> The disk power may very well have already been turned on by the
>> bootloader, so we add a regulator-boot-on property to the regulator
>> node in devicetree to make sure that it is left untouched when the
>> regulator driver loads. If the ahci_platform driver is build into
>> the kernel, it will then take control of the regulator and
>> everything works well.
>>
>> If however the ahci_platform driver is a module, then as soon as
>> the kernel is ready to start init, unused regulators are turned off
>> and the disk looses its power while spinning and ends up doing an
>> emergency heads park.
>
> What turns off the power in this situation?  The kernel?  Or userspace?
> Don't you have control of this?
>
> Have you tried to even create a patch that could do this type of thing
> to udev to see if it is even possible?
>
> thanks,
>
> greg k-h
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
