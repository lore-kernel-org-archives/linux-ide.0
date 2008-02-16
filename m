From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE cdrom problem
Date: Sat, 16 Feb 2008 17:49:12 +0100
Message-ID: <20080216164912.GQ13446@gollum.tnic>
References: <200802161624.47003.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:9753 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbYBPQuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:50:13 -0500
Received: by py-out-1112.google.com with SMTP id u52so1290143pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:50:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802161624.47003.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: WaVeR <debian@hispeed.ch>, linux-ide@vger.kernel.org

On Sat, Feb 16, 2008 at 04:24:46PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> [ added Borislav (ide-cd maintainer) to cc: ]
>=20
> Hi,
>=20
> Unless there are some very important reasons to keep the discussion p=
rivate
> please always cc: linux-ide@ and/or linux-kernel@ ML when reporting p=
roblems.
>=20
> Othewise your mail misses many knowledgeable people and is left on me=
rcy
> of clueless IDE maintainer... ;-)
>=20
> ----------  Forwarded Message  ----------
>=20
> Subject: IDE cdrom problem
> Date: Saturday 16 February 2008
> From: WaVeR <debian@hispeed.ch>
> To: bzolnier@gmail.com
>=20
> Hello Bart,
>=20
> Sorry to distrub you, but I have a similar problem like this post
> http://lkml.org/lkml/2008/2/12/97
>=20
> I'm not subscribed to linux ML, so I decide to write you directly.
>=20
>=20
> >From my dmesg, I get this error:
>=20
> Feb 16 08:01:58 Jupiter kernel: hdc: cdrom_pc_intr: The drive appears
> confused (ireason =3D 0x01). Trying to recover by ending request.
> Feb 16 08:06:16 Jupiter kernel: hdc: cdrom_pc_intr: The drive appears
> confused (ireason =3D 0x01). Trying to recover by ending request.
> Feb 16 08:10:45 Jupiter kernel: hdd: cdrom_pc_intr: The drive appears
> confused (ireason =3D 0x01). Trying to recover by ending request.
> Feb 16 08:37:41 Jupiter kernel: hdd: cdrom_pc_intr: The drive appears
> confused (ireason =3D 0x01). Trying to recover by ending request.
> Feb 16 08:42:10 Jupiter kernel: hdc: cdrom_pc_intr: The drive appears
> confused (ireason =3D 0x01). Trying to recover by ending request.
> Feb 16 09:00:07 Jupiter kernel: hdd: cdrom_pc_intr: The drive appears
> confused (ireason =3D 0x01). Trying to recover by ending request.

Yeah, this is kinda funny, i think i've seen that somewhere :) But seri=
ously,
can you try 2.6.25-rc2 - this one should be stable enough and it has th=
e ide-cd
rewrite in there and it would be interesting to see whether the new int=
errupt
handler shows the same behaviour.

Bart, since this starts to occur often, i'm thinking of adding a debugg=
ing macro
similar to the ones we rewrote in ide-floppy and ide-tape besides the
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS facility in ide-cd. What are your t=
houghts
on the matter?

>=20
>=20
> As you can see on the atached file. It's a simple IDE dvdrom and a cd
> burner.
>=20
> I dont have this problem with the kernel 2.6.21.3
>=20
> My actual kernel is:
> 9:28 waver@Jupiter ~% uname -a
> Linux Jupiter 2.6.24.2-waver.1 #1 Wed Feb 13 23:53:31 CET 2008 i686
> GNU/Linux
>=20
>=20
> Thanks.
>=20
>=20
> Regards,
>=20
>=20
> -------------------------------------------------------

>=20
> Dumping 121 device(s) from the Global Device List:
> -------------------------------------------------
> udi =3D '/org/freedesktop/Hal/devices/computer'
>   info.addons =3D {'hald-addon-cpufreq', 'hald-addon-acpi'} (string l=
ist)
>   info.bus =3D 'unknown'  (string)
>   info.callouts.add =3D {'hal-storage-cleanup-all-mountpoints'} (stri=
ng list)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.SystemPowerManagem=
ent'} (string list)
>   info.product =3D 'Computer'  (string)
>   info.subsystem =3D 'unknown'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   org.freedesktop.Hal.Device.SystemPowerManagement.method_argnames =3D=
 {'num_seconds_to_sleep', 'num_seconds_to_sleep', '', '', '', 'enable_p=
ower_save'} (string list)
>   org.freedesktop.Hal.Device.SystemPowerManagement.method_execpaths =3D=
 {'hal-system-power-suspend', 'hal-system-power-suspend-hybrid', 'hal-s=
ystem-power-hibernate', 'hal-system-power-shutdown', 'hal-system-power-=
reboot', 'hal-system-power-set-power-save'} (string list)
>   org.freedesktop.Hal.Device.SystemPowerManagement.method_names =3D {=
'Suspend', 'SuspendHybrid', 'Hibernate', 'Shutdown', 'Reboot', 'SetPowe=
rSave'} (string list)
>   org.freedesktop.Hal.Device.SystemPowerManagement.method_signatures =
=3D {'i', 'i', '', '', '', 'b'} (string list)
>   power_management.acpi.linux.version =3D '20070126'  (string)
>   power_management.can_hibernate =3D false  (bool)
>   power_management.can_suspend =3D false  (bool)
>   power_management.can_suspend_hybrid =3D false  (bool)
>   power_management.can_suspend_to_disk =3D false  (bool)
>   power_management.can_suspend_to_ram =3D false  (bool)
>   power_management.is_powersave_set =3D false  (bool)
>   power_management.type =3D 'acpi'  (string)
>   smbios.bios.release_date =3D '06/05/2003'  (string)
>   smbios.bios.vendor =3D 'Award Software, Inc.'  (string)
>   smbios.bios.version =3D 'ASUS P4B266 ACPI BIOS Revision 1011 Beta 0=
03'  (string)
>   smbios.chassis.manufacturer =3D 'Chassis Manufacture'  (string)
>   smbios.chassis.type =3D 'Tower'  (string)
>   smbios.system.manufacturer =3D 'System Manufacturer'  (string)
>   smbios.system.product =3D 'System Name'  (string)
>   smbios.system.serial =3D 'SYS-1234567890'  (string)
>   smbios.system.uuid =3D 'Not Settable'  (string)
>   smbios.system.version =3D 'System Version'  (string)
>   system.chassis.manufacturer =3D 'Chassis Manufacture'  (string)
>   system.chassis.type =3D 'Tower'  (string)
>   system.firmware.release_date =3D '06/05/2003'  (string)
>   system.firmware.vendor =3D 'Award Software, Inc.'  (string)
>   system.firmware.version =3D 'ASUS P4B266 ACPI BIOS Revision 1011 Be=
ta 003'  (string)
>   system.formfactor =3D 'desktop'  (string)
>   system.hardware.primary_video.product =3D 385  (0x181)  (int)
>   system.hardware.primary_video.vendor =3D 4318  (0x10de)  (int)
>   system.hardware.product =3D 'System Name'  (string)
>   system.hardware.serial =3D 'SYS-1234567890'  (string)
>   system.hardware.uuid =3D 'Not Settable'  (string)
>   system.hardware.vendor =3D 'System Manufacturer'  (string)
>   system.hardware.version =3D 'System Version'  (string)
>   system.kernel.machine =3D 'i686'  (string)
>   system.kernel.name =3D 'Linux'  (string)
>   system.kernel.version =3D '2.6.24.2-waver.1'  (string)
>   system.product =3D 'System Name System Version'  (string)
>   system.vendor =3D 'System Manufacturer'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/acpi_CPU'
>   info.capabilities =3D {'processor'} (string list)
>   info.category =3D 'processor'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Intel(R) Pentium(R) 4 CPU 2.00GHz'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/acpi_CPU'  (string)
>   linux.acpi_path =3D '/proc/acpi/processor/CPU'  (string)
>   linux.acpi_type =3D 1  (0x1)  (int)
>   linux.hotplug_type =3D 4  (0x4)  (int)
>   processor.can_throttle =3D false  (bool)
>   processor.number =3D 0  (0x0)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/computer_alsa_timer'
>   alsa.device_file =3D '/dev/snd/timer'  (string)
>   alsa.type =3D 'timer'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'ALSA Timer Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer_alsa_timer'  (s=
tring)
>   linux.device_file =3D '/dev/snd/timer'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/timer'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/computer_oss_sequencer_0'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'OSS Sequencer Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer_oss_sequencer_0=
'  (string)
>   linux.device_file =3D '/dev/sequencer2'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/sequencer2'  (string)
>   oss.device_file =3D '/dev/sequencer2'  (string)
>   oss.type =3D 'sequencer'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/computer_oss_sequencer'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'OSS Sequencer Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer_oss_sequencer' =
 (string)
>   linux.device_file =3D '/dev/sequencer'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/sequencer'  (string)
>   oss.device_file =3D '/dev/sequencer'  (string)
>   oss.type =3D 'sequencer'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/computer_alsa_sequencer'
>   alsa.device_file =3D '/dev/snd/seq'  (string)
>   alsa.type =3D 'sequencer'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'ALSA Sequencer Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer_alsa_sequencer'=
  (string)
>   linux.device_file =3D '/dev/snd/seq'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/seq'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input_0'
>   button.has_state =3D false  (bool)
>   button.type =3D 'power'  (string)
>   info.addons.singleton =3D {'hald-addon-input'} (string list)
>   info.capabilities =3D {'input', 'button'} (string list)
>   info.category =3D 'input'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Power Button (CM)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_inpu=
t_0'  (string)
>   input.device =3D '/dev/input/event1'  (string)
>   input.product =3D 'Power Button (CM)'  (string)
>   linux.device_file =3D '/dev/input/event1'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'input'  (string)
>   linux.sysfs_path =3D '/sys/class/input/input1/event1'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_input'
>   button.has_state =3D false  (bool)
>   button.type =3D 'power'  (string)
>   info.addons.singleton =3D {'hald-addon-input'} (string list)
>   info.capabilities =3D {'input', 'button'} (string list)
>   info.category =3D 'input'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Power Button (FF)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/computer_logicaldev_inpu=
t'  (string)
>   input.device =3D '/dev/input/event0'  (string)
>   input.product =3D 'Power Button (FF)'  (string)
>   linux.device_file =3D '/dev/input/event0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'input'  (string)
>   linux.sysfs_path =3D '/sys/class/input/input0/event0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02_1'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'system'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'General ID for reserving resources required by Pn=
P motherboard registers. (Not device specific.)'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02_1'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:0e'  (string)
>   pnp.description =3D 'General ID for reserving resources required by=
 PnP motherboard registers. (Not device specific.)'  (string)
>   pnp.id =3D 'PNP0c02'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0f13'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'i8042 aux'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'PS/2 Port for PS/2-style Mice'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0f13'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:0d'  (string)
>   pnp.description =3D 'PS/2 Port for PS/2-style Mice'  (string)
>   pnp.id =3D 'PNP0f13'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0303'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'i8042 kbd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'IBM Enhanced (101/102-key, PS/2 mouse support)'  =
(string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0303'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:0c'  (string)
>   pnp.description =3D 'IBM Enhanced (101/102-key, PS/2 mouse support)=
'  (string)
>   pnp.id =3D 'PNP0303'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_0'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'serial'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '16550A-compatible COM port'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:0b'  (string)
>   pnp.description =3D '16550A-compatible COM port'  (string)
>   pnp.id =3D 'PNP0501'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_0_serial_platform_1=
'
>   info.capabilities =3D {'serial'} (string list)
>   info.category =3D 'serial'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_0'  (stri=
ng)
>   info.product =3D '16550A-compatible COM port'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_0_serial_pla=
tform_1'  (string)
>   linux.device_file =3D '/dev/ttyS1'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'tty'  (string)
>   linux.sysfs_path =3D '/sys/class/tty/ttyS1'  (string)
>   serial.device =3D '/dev/ttyS1'  (string)
>   serial.originating_device =3D '/org/freedesktop/Hal/devices/pnp_PNP=
0501_0'  (string)
>   serial.physical_device =3D '/org/freedesktop/Hal/devices/pnp_PNP050=
1_0'  (string)
>   serial.port =3D 1  (0x1)  (int)
>   serial.type =3D 'platform'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'serial'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '16550A-compatible COM port'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:0a'  (string)
>   pnp.description =3D '16550A-compatible COM port'  (string)
>   pnp.id =3D 'PNP0501'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_serial_platform_0'
>   info.capabilities =3D {'serial'} (string list)
>   info.category =3D 'serial'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pnp_PNP0501'  (string=
)
>   info.product =3D '16550A-compatible COM port'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0501_serial_platf=
orm_0'  (string)
>   linux.device_file =3D '/dev/ttyS0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'tty'  (string)
>   linux.sysfs_path =3D '/sys/class/tty/ttyS0'  (string)
>   serial.device =3D '/dev/ttyS0'  (string)
>   serial.originating_device =3D '/org/freedesktop/Hal/devices/pnp_PNP=
0501'  (string)
>   serial.physical_device =3D '/org/freedesktop/Hal/devices/pnp_PNP050=
1'  (string)
>   serial.port =3D 0  (0x0)  (int)
>   serial.type =3D 'platform'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0401'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'parport_pc'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'ECP printer port'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0401'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:09'  (string)
>   pnp.description =3D 'ECP printer port'  (string)
>   pnp.id =3D 'PNP0401'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0700'
>   info.bus =3D 'pnp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'PC standard floppy disk controller'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0700'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:08'  (string)
>   pnp.description =3D 'PC standard floppy disk controller'  (string)
>   pnp.id =3D 'PNP0700'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c04'
>   info.bus =3D 'pnp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Math Coprocessor'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c04'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:07'  (string)
>   pnp.description =3D 'Math Coprocessor'  (string)
>   pnp.id =3D 'PNP0c04'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0800'
>   info.bus =3D 'pnp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'AT-style speaker sound'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0800'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:06'  (string)
>   pnp.description =3D 'AT-style speaker sound'  (string)
>   pnp.id =3D 'PNP0800'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0b00'
>   info.bus =3D 'pnp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'AT Real-Time Clock'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0b00'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:05'  (string)
>   pnp.description =3D 'AT Real-Time Clock'  (string)
>   pnp.id =3D 'PNP0b00'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0200'
>   info.bus =3D 'pnp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'AT DMA Controller'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0200'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:04'  (string)
>   pnp.description =3D 'AT DMA Controller'  (string)
>   pnp.id =3D 'PNP0200'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02_0'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'system'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'General ID for reserving resources required by Pn=
P motherboard registers. (Not device specific.)'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02_0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:03'  (string)
>   pnp.description =3D 'General ID for reserving resources required by=
 PnP motherboard registers. (Not device specific.)'  (string)
>   pnp.id =3D 'PNP0c02'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'system'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'General ID for reserving resources required by Pn=
P motherboard registers. (Not device specific.)'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c02'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:02'  (string)
>   pnp.description =3D 'General ID for reserving resources required by=
 PnP motherboard registers. (Not device specific.)'  (string)
>   pnp.id =3D 'PNP0c02'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0a03'
>   info.bus =3D 'pnp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'PCI Bus'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0a03'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:01'  (string)
>   pnp.description =3D 'PCI Bus'  (string)
>   pnp.id =3D 'PNP0a03'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c01'
>   info.bus =3D 'pnp'  (string)
>   info.linux.driver =3D 'system'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'System Board'  (string)
>   info.subsystem =3D 'pnp'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pnp_PNP0c01'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pnp'  (string)
>   linux.sysfs_path =3D '/sys/devices/pnp0/00:00'  (string)
>   pnp.description =3D 'System Board'  (string)
>   pnp.id =3D 'PNP0c01'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_vesafb_0'
>   info.bus =3D 'platform'  (string)
>   info.linux.driver =3D 'vesafb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Platform Device (vesafb.0)'  (string)
>   info.subsystem =3D 'platform'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_vesafb_0'  (str=
ing)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'platform'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/vesafb.0'  (string)
>   platform.id =3D 'vesafb.0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_serial8250'
>   info.bus =3D 'platform'  (string)
>   info.linux.driver =3D 'serial8250'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Platform Device (serial8250)'  (string)
>   info.subsystem =3D 'platform'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_serial8250'  (s=
tring)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'platform'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/serial8250'  (string)
>   platform.id =3D 'serial8250'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr'
>   info.bus =3D 'platform'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Platform Device (pcspkr)'  (string)
>   info.subsystem =3D 'platform'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_pcspkr'  (strin=
g)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'platform'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/pcspkr'  (string)
>   platform.id =3D 'pcspkr'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_i8042'
>   info.bus =3D 'platform'  (string)
>   info.linux.driver =3D 'i8042'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Platform Device (i8042)'  (string)
>   info.subsystem =3D 'platform'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042'  (string=
)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'platform'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/i8042'  (string)
>   platform.id =3D 'i8042'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX_port'
>   info.bus =3D 'serio'  (string)
>   info.linux.driver =3D 'psmouse'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042'  (str=
ing)
>   info.product =3D 'i8042 AUX port'  (string)
>   info.subsystem =3D 'serio'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX=
_port'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'serio'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/i8042/serio1'  (string)
>   serio.description =3D 'i8042 AUX port'  (string)
>   serio.id =3D 'serio1'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX_port_l=
ogicaldev_input'
>   info.capabilities =3D {'input', 'input.mouse'} (string list)
>   info.category =3D 'input'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_=
AUX_port'  (string)
>   info.product =3D 'ImPS/2 Logitech Wheel Mouse'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_AUX=
_port_logicaldev_input'  (string)
>   input.device =3D '/dev/input/event3'  (string)
>   input.originating_device =3D '/org/freedesktop/Hal/devices/platform=
_i8042_i8042_AUX_port'  (string)
>   input.physical_device =3D '/org/freedesktop/Hal/devices/platform_i8=
042_i8042_AUX_port'  (string)
>   input.product =3D 'ImPS/2 Logitech Wheel Mouse'  (string)
>   linux.device_file =3D '/dev/input/event3'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'input'  (string)
>   linux.sysfs_path =3D '/sys/class/input/input3/event3'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port'
>   info.bus =3D 'serio'  (string)
>   info.linux.driver =3D 'atkbd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042'  (str=
ing)
>   info.product =3D 'i8042 KBD port'  (string)
>   info.subsystem =3D 'serio'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD=
_port'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'serio'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/i8042/serio0'  (string)
>   serio.description =3D 'i8042 KBD port'  (string)
>   serio.id =3D 'serio0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_l=
ogicaldev_input'
>   info.addons.singleton =3D {'hald-addon-input'} (string list)
>   info.capabilities =3D {'input', 'input.keyboard', 'input.keypad', '=
input.keys', 'button'} (string list)
>   info.category =3D 'input'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_=
KBD_port'  (string)
>   info.product =3D 'AT Translated Set 2 keyboard'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD=
_port_logicaldev_input'  (string)
>   input.device =3D '/dev/input/event2'  (string)
>   input.originating_device =3D '/org/freedesktop/Hal/devices/platform=
_i8042_i8042_KBD_port'  (string)
>   input.physical_device =3D '/org/freedesktop/Hal/devices/platform_i8=
042_i8042_KBD_port'  (string)
>   input.product =3D 'AT Translated Set 2 keyboard'  (string)
>   input.xkb.layout =3D 'us'  (string)
>   input.xkb.model =3D 'evdev'  (string)
>   input.xkb.rules =3D 'base'  (string)
>   input.xkb.variant =3D ''  (string)
>   linux.device_file =3D '/dev/input/event2'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'input'  (string)
>   linux.sysfs_path =3D '/sys/class/input/input2/event2'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0'
>   info.bus =3D 'platform'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D 'Platform Device (floppy.0)'  (string)
>   info.subsystem =3D 'platform'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0'  (str=
ing)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'platform'  (string)
>   linux.sysfs_path =3D '/sys/devices/platform/floppy.0'  (string)
>   platform.id =3D 'floppy.0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0_storage'
>   block.device =3D '/dev/fd0'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 2  (0x2)  (int)
>   block.minor =3D 0  (0x0)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/platform_flo=
ppy_0_storage'  (string)
>   info.capabilities =3D {'storage', 'block'} (string list)
>   info.category =3D 'storage'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/platform_floppy_0'  (=
string)
>   info.product =3D 'PC Floppy Drive'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/platform_floppy_0_storag=
e'  (string)
>   info.vendor =3D ''  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/fd0'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'platform'  (string)
>   storage.drive_type =3D 'floppy'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D false  (bool)
>   storage.model =3D ''  (string)
>   storage.no_partitions_hint =3D true  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/platfo=
rm_floppy_0'  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/platform_=
floppy_0'  (string)
>   storage.removable =3D true  (bool)
>   storage.removable.media_available =3D false  (bool)
>   storage.requires_eject =3D false  (bool)
>   storage.size =3D 0  (0x0)  (uint64)
>   storage.vendor =3D 'PC Floppy Drive'  (string)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'utf8', 'shortname=
=3D', 'codepage=3D', 'iocharset=3D', 'umask=3D', 'uid=3D'} (string list=
)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_2444'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'uhci_hcd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82801BA/BAM USB Controller #1'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_2444'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.4'  (strin=
g)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 3  (0x3)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.4'  (s=
tring)
>   pci.product =3D '82801BA/BAM USB Controller #1'  (string)
>   pci.product_id =3D 9284  (0x2444)  (int)
>   pci.subsys_product_id =3D 32808  (0x8028)  (int)
>   pci.subsys_vendor =3D 'ASUSTeK Computer Inc.'  (string)
>   pci.subsys_vendor_id =3D 4163  (0x1043)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1f_4'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_2444'  (stri=
ng)
>   info.product =3D 'UHCI Host Controller'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1=
f_4'  (string)
>   info.vendor =3D 'Linux 2.6.24.2-waver.1 uhci_hcd'  (string)
>   linux.device_file =3D '/dev/bus/usb/006/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.4/usb6'  (=
string)
>   usb_device.bus_number =3D 6  (0x6)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 9  (0x9)  (int)
>   usb_device.device_protocol =3D 0  (0x0)  (int)
>   usb_device.device_revision_bcd =3D 518  (0x206)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 1  (0x1)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f=
=2E4/usb6'  (string)
>   usb_device.max_power =3D 0  (0x0)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 2  (0x2)  (int)
>   usb_device.product =3D 'UHCI Host Controller'  (string)
>   usb_device.product_id =3D 0  (0x0)  (int)
>   usb_device.serial =3D '0000:00:1f.4'  (string)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Linux 2.6.24.2-waver.1 uhci_hcd'  (string)
>   usb_device.vendor_id =3D 0  (0x0)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1f_4_usb=
raw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
0_1f_4'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1=
f_4_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/006/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev6.1'  (string)
>   usbraw.device =3D '/dev/bus/usb/006/001'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1f_4_if0=
'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'hub'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
0_1f_4'  (string)
>   info.product =3D 'USB Hub Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1=
f_4_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.4/usb6/6-0=
:1.0'  (string)
>   usb.bus_number =3D 6  (0x6)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 9  (0x9)  (int)
>   usb.device_protocol =3D 0  (0x0)  (int)
>   usb.device_revision_bcd =3D 518  (0x206)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 9  (0x9)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 0  (0x0)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 1  (0x1)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.4/usb6=
/6-0:1.0'  (string)
>   usb.max_power =3D 0  (0x0)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 2  (0x2)  (int)
>   usb.product =3D 'USB Hub Interface'  (string)
>   usb.product_id =3D 0  (0x0)  (int)
>   usb.serial =3D '0000:00:1f.4'  (string)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Linux 2.6.24.2-waver.1 uhci_hcd'  (string)
>   usb.vendor_id =3D 0  (0x0)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_2443'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'i801_smbus'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82801BA/BAM SMBus Controller'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_2443'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.3'  (strin=
g)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 5  (0x5)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.3'  (s=
tring)
>   pci.product =3D '82801BA/BAM SMBus Controller'  (string)
>   pci.product_id =3D 9283  (0x2443)  (int)
>   pci.subsys_product_id =3D 32808  (0x8028)  (int)
>   pci.subsys_vendor =3D 'ASUSTeK Computer Inc.'  (string)
>   pci.subsys_vendor_id =3D 4163  (0x1043)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_2442'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'uhci_hcd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82801BA/BAM USB Controller #1'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_2442'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2'  (strin=
g)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 3  (0x3)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2'  (s=
tring)
>   pci.product =3D '82801BA/BAM USB Controller #1'  (string)
>   pci.product_id =3D 9282  (0x2442)  (int)
>   pci.subsys_product_id =3D 32808  (0x8028)  (int)
>   pci.subsys_vendor =3D 'ASUSTeK Computer Inc.'  (string)
>   pci.subsys_vendor_id =3D 4163  (0x1043)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1f_2'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_2442'  (stri=
ng)
>   info.product =3D 'UHCI Host Controller'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1=
f_2'  (string)
>   info.vendor =3D 'Linux 2.6.24.2-waver.1 uhci_hcd'  (string)
>   linux.device_file =3D '/dev/bus/usb/005/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2/usb5'  (=
string)
>   usb_device.bus_number =3D 5  (0x5)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 9  (0x9)  (int)
>   usb_device.device_protocol =3D 0  (0x0)  (int)
>   usb_device.device_revision_bcd =3D 518  (0x206)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 1  (0x1)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f=
=2E2/usb5'  (string)
>   usb_device.max_power =3D 0  (0x0)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 2  (0x2)  (int)
>   usb_device.product =3D 'UHCI Host Controller'  (string)
>   usb_device.product_id =3D 0  (0x0)  (int)
>   usb_device.serial =3D '0000:00:1f.2'  (string)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Linux 2.6.24.2-waver.1 uhci_hcd'  (string)
>   usb_device.vendor_id =3D 0  (0x0)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1f_2_usb=
raw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
0_1f_2'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1=
f_2_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/005/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev5.1'  (string)
>   usbraw.device =3D '/dev/bus/usb/005/001'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK1P0FFSX=
'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
0_1f_2'  (string)
>   info.product =3D 'DeskJet 845c'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK=
1P0FFSX'  (string)
>   info.vendor =3D 'Hewlett-Packard'  (string)
>   linux.device_file =3D '/dev/bus/usb/005/002'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2/usb5/5-2=
'  (string)
>   usb_device.bus_number =3D 5  (0x5)  (int)
>   usb_device.can_wake_up =3D false  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 0  (0x0)  (int)
>   usb_device.device_protocol =3D 0  (0x0)  (int)
>   usb_device.device_revision_bcd =3D 256  (0x100)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 2  (0x2)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f=
=2E2/usb5/5-2'  (string)
>   usb_device.max_power =3D 2  (0x2)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 0  (0x0)  (int)
>   usb_device.product =3D 'DeskJet 845c'  (string)
>   usb_device.product_id =3D 2308  (0x904)  (int)
>   usb_device.serial =3D 'CN1BK1P0FFSX'  (string)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Hewlett-Packard'  (string)
>   usb_device.vendor_id =3D 1008  (0x3f0)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK1P0FFSX=
_usbraw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN=
1BK1P0FFSX'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK=
1P0FFSX_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/005/002'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev5.2'  (string)
>   usbraw.device =3D '/dev/bus/usb/005/002'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK1P0FFSX=
_if0'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'usblp'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN=
1BK1P0FFSX'  (string)
>   info.product =3D 'USB Printer Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK=
1P0FFSX_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2/usb5/5-2=
/5-2:1.0'  (string)
>   usb.bus_number =3D 5  (0x5)  (int)
>   usb.can_wake_up =3D false  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 0  (0x0)  (int)
>   usb.device_protocol =3D 0  (0x0)  (int)
>   usb.device_revision_bcd =3D 256  (0x100)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 7  (0x7)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 2  (0x2)  (int)
>   usb.interface.subclass =3D 1  (0x1)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 2  (0x2)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2/usb5=
/5-2/5-2:1.0'  (string)
>   usb.max_power =3D 2  (0x2)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 0  (0x0)  (int)
>   usb.product =3D 'USB Printer Interface'  (string)
>   usb.product_id =3D 2308  (0x904)  (int)
>   usb.serial =3D 'CN1BK1P0FFSX'  (string)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Hewlett-Packard'  (string)
>   usb.vendor_id =3D 1008  (0x3f0)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK1P0FFSX=
_if0_printer_CN1BK1P0FFSX'
>   info.capabilities =3D {'printer'} (string list)
>   info.category =3D 'printer'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN=
1BK1P0FFSX_if0'  (string)
>   info.product =3D 'DESKJET 845C'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_3f0_904_CN1BK=
1P0FFSX_if0_printer_CN1BK1P0FFSX'  (string)
>   info.vendor =3D 'HEWLETT-PACKARD'  (string)
>   linux.device_file =3D '/dev/usb/lp0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/class/usb/lp0'  (string)
>   printer.commandset =3D {'MLC', 'PCL', 'PML'} (string list)
>   printer.description =3D 'Hewlett-Packard DeskJet 845C'  (string)
>   printer.device =3D '/dev/usb/lp0'  (string)
>   printer.originating_device =3D '/org/freedesktop/Hal/devices/usb_de=
vice_3f0_904_CN1BK1P0FFSX_if0'  (string)
>   printer.physical_device =3D '/org/freedesktop/Hal/devices/usb_devic=
e_3f0_904_CN1BK1P0FFSX_if0'  (string)
>   printer.product =3D 'DESKJET 845C'  (string)
>   printer.serial =3D 'CN1BK1P0FFSX'  (string)
>   printer.vendor =3D 'HEWLETT-PACKARD'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1f_2_if0=
'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'hub'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
0_1f_2'  (string)
>   info.product =3D 'USB Hub Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_00_1=
f_2_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2/usb5/5-0=
:1.0'  (string)
>   usb.bus_number =3D 5  (0x5)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 9  (0x9)  (int)
>   usb.device_protocol =3D 0  (0x0)  (int)
>   usb.device_revision_bcd =3D 518  (0x206)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 9  (0x9)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 0  (0x0)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 1  (0x1)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.2/usb5=
/5-0:1.0'  (string)
>   usb.max_power =3D 0  (0x0)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 2  (0x2)  (int)
>   usb.product =3D 'USB Hub Interface'  (string)
>   usb.product_id =3D 0  (0x0)  (int)
>   usb.serial =3D '0000:00:1f.2'  (string)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Linux 2.6.24.2-waver.1 uhci_hcd'  (string)
>   usb.vendor_id =3D 0  (0x0)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'PIIX_IDE'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82801BA IDE U100 Controller'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.1'  (strin=
g)
>   pci.device_class =3D 1  (0x1)  (int)
>   pci.device_protocol =3D 128  (0x80)  (int)
>   pci.device_subclass =3D 1  (0x1)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.1'  (s=
tring)
>   pci.product =3D '82801BA IDE U100 Controller'  (string)
>   pci.product_id =3D 9291  (0x244b)  (int)
>   pci.subsys_product_id =3D 32808  (0x8028)  (int)
>   pci.subsys_vendor =3D 'ASUSTeK Computer Inc.'  (string)
>   pci.subsys_vendor_id =3D 4163  (0x1043)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_1_1'
>   ide.channel =3D 1  (0x1)  (int)
>   ide.host =3D 1  (0x1)  (int)
>   info.bus =3D 'ide'  (string)
>   info.linux.driver =3D 'ide-cdrom'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b'  (stri=
ng)
>   info.product =3D 'IDE device (slave)'  (string)
>   info.subsystem =3D 'ide'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_1_1'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'ide'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.1/ide1/1.1=
'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/storage_model_LITE_ON_LTR_48125=
S'
>   block.device =3D '/dev/hdd'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 22  (0x16)  (int)
>   block.minor =3D 64  (0x40)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_mode=
l_LITE_ON_LTR_48125S'  (string)
>   info.addons =3D {'hald-addon-storage'} (string list)
>   info.capabilities =3D {'storage', 'block', 'storage.cdrom'} (string=
 list)
>   info.category =3D 'storage'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Storage', 'org.fre=
edesktop.Hal.Device.Storage'} (string list)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_1_1=
'  (string)
>   info.product =3D 'LITE-ON LTR-48125S'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/storage_model_LITE_ON_LT=
R_48125S'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdd'  (string)
>   org.freedesktop.Hal.Device.Storage.method_argnames =3D {'extra_opti=
ons', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Storage.method_execpaths =3D {'hal-stora=
ge-eject', 'hal-storage-closetray'} (string list)
>   org.freedesktop.Hal.Device.Storage.method_names =3D {'Eject', 'Clos=
eTray'} (string list)
>   org.freedesktop.Hal.Device.Storage.method_signatures =3D {'as', 'as=
'} (string list)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'ide'  (string)
>   storage.cdrom.bd =3D false  (bool)
>   storage.cdrom.bdr =3D false  (bool)
>   storage.cdrom.bdre =3D false  (bool)
>   storage.cdrom.cdr =3D true  (bool)
>   storage.cdrom.cdrw =3D true  (bool)
>   storage.cdrom.dvd =3D false  (bool)
>   storage.cdrom.dvdplusr =3D false  (bool)
>   storage.cdrom.dvdplusrdl =3D false  (bool)
>   storage.cdrom.dvdplusrw =3D false  (bool)
>   storage.cdrom.dvdplusrwdl =3D false  (bool)
>   storage.cdrom.dvdr =3D false  (bool)
>   storage.cdrom.dvdram =3D false  (bool)
>   storage.cdrom.dvdrw =3D false  (bool)
>   storage.cdrom.hddvd =3D false  (bool)
>   storage.cdrom.hddvdr =3D false  (bool)
>   storage.cdrom.hddvdrw =3D false  (bool)
>   storage.cdrom.mo =3D false  (bool)
>   storage.cdrom.mrw =3D true  (bool)
>   storage.cdrom.mrw_w =3D true  (bool)
>   storage.cdrom.read_speed =3D 8448  (0x2100)  (int)
>   storage.cdrom.support_media_changed =3D true  (bool)
>   storage.cdrom.support_multisession =3D true  (bool)
>   storage.cdrom.write_speed =3D 8448  (0x2100)  (int)
>   storage.cdrom.write_speeds =3D {'8448', '7040', '5632', '4224', '28=
16', '2112', '1760', '1408', '704', '352'} (string list)
>   storage.drive_type =3D 'cdrom'  (string)
>   storage.firmware_version =3D '1S07'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D true  (bool)
>   storage.model =3D 'LITE-ON LTR-48125S'  (string)
>   storage.no_partitions_hint =3D true  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/comput=
er'  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/computer'=
  (string)
>   storage.removable =3D true  (bool)
>   storage.removable.media_available =3D false  (bool)
>   storage.removable.support_async_notification =3D false  (bool)
>   storage.requires_eject =3D true  (bool)
>   storage.size =3D 0  (0x0)  (uint64)
>   storage.vendor =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_1_0'
>   ide.channel =3D 0  (0x0)  (int)
>   ide.host =3D 1  (0x1)  (int)
>   info.bus =3D 'ide'  (string)
>   info.linux.driver =3D 'ide-cdrom'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b'  (stri=
ng)
>   info.product =3D 'IDE device (master)'  (string)
>   info.subsystem =3D 'ide'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_1_0'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'ide'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.1/ide1/1.0=
'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/storage_model_HL_DT_STDVD_ROM_G=
DR8161B'
>   block.device =3D '/dev/hdc'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 22  (0x16)  (int)
>   block.minor =3D 0  (0x0)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_mode=
l_HL_DT_STDVD_ROM_GDR8161B'  (string)
>   info.addons =3D {'hald-addon-storage'} (string list)
>   info.capabilities =3D {'storage', 'block', 'storage.cdrom'} (string=
 list)
>   info.category =3D 'storage'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Storage', 'org.fre=
edesktop.Hal.Device.Storage'} (string list)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_1_0=
'  (string)
>   info.product =3D 'HL-DT-STDVD-ROM GDR8161B'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/storage_model_HL_DT_STDV=
D_ROM_GDR8161B'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdc'  (string)
>   org.freedesktop.Hal.Device.Storage.method_argnames =3D {'extra_opti=
ons', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Storage.method_execpaths =3D {'hal-stora=
ge-eject', 'hal-storage-closetray'} (string list)
>   org.freedesktop.Hal.Device.Storage.method_names =3D {'Eject', 'Clos=
eTray'} (string list)
>   org.freedesktop.Hal.Device.Storage.method_signatures =3D {'as', 'as=
'} (string list)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'ide'  (string)
>   storage.cdrom.bd =3D false  (bool)
>   storage.cdrom.bdr =3D false  (bool)
>   storage.cdrom.bdre =3D false  (bool)
>   storage.cdrom.cdr =3D false  (bool)
>   storage.cdrom.cdrw =3D false  (bool)
>   storage.cdrom.dvd =3D true  (bool)
>   storage.cdrom.dvdplusr =3D false  (bool)
>   storage.cdrom.dvdplusrdl =3D false  (bool)
>   storage.cdrom.dvdplusrw =3D false  (bool)
>   storage.cdrom.dvdplusrwdl =3D false  (bool)
>   storage.cdrom.dvdr =3D false  (bool)
>   storage.cdrom.dvdram =3D false  (bool)
>   storage.cdrom.dvdrw =3D false  (bool)
>   storage.cdrom.hddvd =3D false  (bool)
>   storage.cdrom.hddvdr =3D false  (bool)
>   storage.cdrom.hddvdrw =3D false  (bool)
>   storage.cdrom.mo =3D false  (bool)
>   storage.cdrom.mrw =3D true  (bool)
>   storage.cdrom.mrw_w =3D true  (bool)
>   storage.cdrom.read_speed =3D 8467  (0x2113)  (int)
>   storage.cdrom.support_media_changed =3D true  (bool)
>   storage.cdrom.support_multisession =3D true  (bool)
>   storage.cdrom.write_speed =3D 0  (0x0)  (int)
>   storage.cdrom.write_speeds =3D {} (string list)
>   storage.drive_type =3D 'cdrom'  (string)
>   storage.firmware_version =3D '0100'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D true  (bool)
>   storage.model =3D 'HL-DT-STDVD-ROM GDR8161B'  (string)
>   storage.no_partitions_hint =3D true  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/comput=
er'  (string)
>   storage.partitioning_scheme =3D ''  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/computer'=
  (string)
>   storage.removable =3D true  (bool)
>   storage.removable.media_available =3D true  (bool)
>   storage.removable.media_size =3D 716974080  (0x2abc2800)  (uint64)
>   storage.removable.support_async_notification =3D false  (bool)
>   storage.requires_eject =3D true  (bool)
>   storage.size =3D 0  (0x0)  (uint64)
>   storage.vendor =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_part_1_size_716974080'
>   block.device =3D '/dev/hdc'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 22  (0x16)  (int)
>   block.minor =3D 0  (0x0)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_mode=
l_HL_DT_STDVD_ROM_GDR8161B'  (string)
>   info.capabilities =3D {'volume.disc', 'volume', 'block'} (string li=
st)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume', 'org.free=
desktop.Hal.Device.Volume'} (string list)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_model_HL_DT_S=
TDVD_ROM_GDR8161B'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_part_1_size_71697=
4080'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdc/fakevolume'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'extra_optio=
ns', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-eject', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Eject', 'Eject=
'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'as', 'as'=
} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 2048  (0x800)  (int)
>   volume.disc.capacity =3D 716974080  (0x2abc2800)  (uint64)
>   volume.disc.has_audio =3D true  (bool)
>   volume.disc.has_data =3D false  (bool)
>   volume.disc.is_appendable =3D false  (bool)
>   volume.disc.is_blank =3D false  (bool)
>   volume.disc.is_rewritable =3D false  (bool)
>   volume.disc.type =3D 'cd_rom'  (string)
>   volume.fstype =3D ''  (string)
>   volume.fsusage =3D ''  (string)
>   volume.fsversion =3D ''  (string)
>   volume.is_disc =3D true  (bool)
>   volume.is_mounted =3D false  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D false  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount_point =3D ''  (string)
>   volume.num_blocks =3D 1400340  (0x155e14)  (int)
>   volume.size =3D 716974080  (0x2abc2800)  (uint64)
>   volume.uuid =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_0_1'
>   ide.channel =3D 1  (0x1)  (int)
>   ide.host =3D 0  (0x0)  (int)
>   info.bus =3D 'ide'  (string)
>   info.linux.driver =3D 'ide-disk'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b'  (stri=
ng)
>   info.product =3D 'IDE device (slave)'  (string)
>   info.subsystem =3D 'ide'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_0_1'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'ide'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.1/ide0/0.1=
'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33EC3G5HU6K'
>   block.device =3D '/dev/hdb'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 64  (0x40)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'storage', 'block'} (string list)
>   info.category =3D 'storage'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_0_1=
'  (string)
>   info.product =3D 'HDS722512VLAT80'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33EC3G=
5HU6K'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb'  (string)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'ide'  (string)
>   storage.drive_type =3D 'disk'  (string)
>   storage.firmware_version =3D 'V33OA60A'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D false  (bool)
>   storage.model =3D 'HDS722512VLAT80'  (string)
>   storage.no_partitions_hint =3D false  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/comput=
er'  (string)
>   storage.partitioning_scheme =3D 'mbr'  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/computer'=
  (string)
>   storage.removable =3D false  (bool)
>   storage.removable.media_available =3D true  (bool)
>   storage.removable.media_size =3D 123522416640  (0x1cc2828000)  (uin=
t64)
>   storage.requires_eject =3D false  (bool)
>   storage.serial =3D 'VNR33EC3G5HU6K'  (string)
>   storage.size =3D 123522416640  (0x1cc2828000)  (uint64)
>   storage.vendor =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_d8cba6fc_2072_489c_=
8b7d_364f7358e22a'
>   block.device =3D '/dev/hdb9'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 73  (0x49)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33E=
C3G5HU6K'  (string)
>   info.product =3D 'FTP'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_d8cba6fc_207=
2_489c_8b7d_364f7358e22a'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb/hdb9'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'FTP'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/scratch1'  (string)
>   volume.num_blocks =3D 62749827  (0x3bd7c83)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 9  (0x9)  (int)
>   volume.partition.start =3D 91391118336  (0x154755cc00)  (uint64)
>   volume.size =3D 32127911424  (0x77af90600)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'd8cba6fc-2072-489c-8b7d-364f7358e22a'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_bb4ca8ac_a0c2_4812_=
8895_d3de91c17a0d'
>   block.device =3D '/dev/hdb8'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 72  (0x48)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33E=
C3G5HU6K'  (string)
>   info.product =3D 'Lea'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_bb4ca8ac_a0c=
2_4812_8895_d3de91c17a0d'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb/hdb8'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'Lea'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/lea'  (string)
>   volume.num_blocks =3D 24868557  (0x17b76cd)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 8  (0x8)  (int)
>   volume.partition.start =3D 78658384896  (0x125067b400)  (uint64)
>   volume.size =3D 12732701184  (0x2f6ed9a00)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'bb4ca8ac-a0c2-4812-8895-d3de91c17a0d'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_f6969f8b_848d_4fe5_=
a46a_ddf9068e6b14'
>   block.device =3D '/dev/hdb7'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 71  (0x47)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33E=
C3G5HU6K'  (string)
>   info.product =3D 'WaVeR'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_f6969f8b_848=
d_4fe5_a46a_ddf9068e6b14'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb/hdb7'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'WaVeR'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/waver'  (string)
>   volume.num_blocks =3D 30732282  (0x1d4effa)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 7  (0x7)  (int)
>   volume.partition.start =3D 62923424256  (0xea6874200)  (uint64)
>   volume.size =3D 15734928384  (0x3a9dff400)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'f6969f8b-848d-4fe5-a46a-ddf9068e6b14'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_a4e35aa2_9384_4699_=
9dc9_65733b998240'
>   block.device =3D '/dev/hdb6'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 70  (0x46)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33E=
C3G5HU6K'  (string)
>   info.product =3D 'Music'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_a4e35aa2_938=
4_4699_9dc9_65733b998240'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb/hdb6'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'Music'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/scratch'  (string)
>   volume.num_blocks =3D 61448562  (0x3a9a172)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 6  (0x6)  (int)
>   volume.partition.start =3D 31461728256  (0x75343e000)  (uint64)
>   volume.size =3D 31461663744  (0x75342e400)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'a4e35aa2-9384-4699-9dc9-65733b998240'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_81c889f8_6fe1_40a1_=
969a_b2a1e8f158b1'
>   block.device =3D '/dev/hdb5'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 69  (0x45)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33E=
C3G5HU6K'  (string)
>   info.product =3D 'Backup'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_81c889f8_6fe=
1_40a1_969a_b2a1e8f158b1'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb/hdb5'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'Backup'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/backup'  (string)
>   volume.num_blocks =3D 61448499  (0x3a9a133)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 5  (0x5)  (int)
>   volume.partition.scheme =3D 'embr'  (string)
>   volume.partition.start =3D 64512  (0xfc00)  (uint64)
>   volume.partition.type =3D '0x83'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 31461631488  (0x753426600)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D '81c889f8-6fe1-40a1-969a-b2a1e8f158b1'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_part1_size_1024'
>   block.device =3D '/dev/hdb1'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 65  (0x41)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VNR33EC3G5HU6K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VNR33E=
C3G5HU6K'  (string)
>   info.product =3D 'Volume'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_part1_size_1024' =
 (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdb/hdb1'  (string)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D ''  (string)
>   volume.fsusage =3D 'partitiontable'  (string)
>   volume.fsversion =3D ''  (string)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D false  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount_point =3D ''  (string)
>   volume.num_blocks =3D 2  (0x2)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 1  (0x1)  (int)
>   volume.partition.scheme =3D 'mbr'  (string)
>   volume.partition.start =3D 32256  (0x7e00)  (uint64)
>   volume.partition.type =3D '0x05'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 1024  (0x400)  (uint64)
>   volume.uuid =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_0_0'
>   ide.channel =3D 0  (0x0)  (int)
>   ide.host =3D 0  (0x0)  (int)
>   info.bus =3D 'ide'  (string)
>   info.linux.driver =3D 'ide-disk'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b'  (stri=
ng)
>   info.product =3D 'IDE device (master)'  (string)
>   info.subsystem =3D 'ide'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_0_0'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'ide'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.1/ide0/0.0=
'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/storage_serial_VN343EC4G26U2K'
>   block.device =3D '/dev/hda'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 0  (0x0)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'storage', 'block'} (string list)
>   info.category =3D 'storage'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244b_ide_0_0=
'  (string)
>   info.product =3D 'HDS722512VLAT80'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/storage_serial_VN343EC4G=
26U2K'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda'  (string)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'ide'  (string)
>   storage.drive_type =3D 'disk'  (string)
>   storage.firmware_version =3D 'V33OA60A'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D false  (bool)
>   storage.model =3D 'HDS722512VLAT80'  (string)
>   storage.no_partitions_hint =3D false  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/comput=
er'  (string)
>   storage.partitioning_scheme =3D 'mbr'  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/computer'=
  (string)
>   storage.removable =3D false  (bool)
>   storage.removable.media_available =3D true  (bool)
>   storage.removable.media_size =3D 123522416640  (0x1cc2828000)  (uin=
t64)
>   storage.requires_eject =3D false  (bool)
>   storage.serial =3D 'VN343EC4G26U2K'  (string)
>   storage.size =3D 123522416640  (0x1cc2828000)  (uint64)
>   storage.vendor =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_96f42662_aae4_48ae_=
8811_f87435d7451a'
>   block.device =3D '/dev/hda8'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 8  (0x8)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'Volume (ext3)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_96f42662_aae=
4_48ae_8811_f87435d7451a'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda8'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/pegasus'  (string)
>   volume.num_blocks =3D 127588167  (0x79ad747)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 8  (0x8)  (int)
>   volume.partition.start =3D 58193888256  (0xd8ca04400)  (uint64)
>   volume.size =3D 65325141504  (0xf35ae8e00)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D '96f42662-aae4-48ae-8811-f87435d7451a'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_7f74a13f_cdd3_43e4_=
b828_b75b5e0e9395'
>   block.device =3D '/dev/hda7'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 7  (0x7)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'TMP'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_7f74a13f_cdd=
3_43e4_b828_b75b5e0e9395'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda7'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'TMP'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/tmp'  (string)
>   volume.num_blocks =3D 5960052  (0x5af174)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 7  (0x7)  (int)
>   volume.partition.start =3D 55142309376  (0xcd6bcde00)  (uint64)
>   volume.size =3D 3051546624  (0xb5e2e800)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D '7f74a13f-cdd3-43e4-b828-b75b5e0e9395'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_a7d6c0a8_bfab_45d1_=
93ca_3d9f53af4c30'
>   block.device =3D '/dev/hda6'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 6  (0x6)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'VAR'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_a7d6c0a8_bfa=
b_45d1_93ca_3d9f53af4c30'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda6'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'VAR'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/var'  (string)
>   volume.num_blocks =3D 7903917  (0x789aad)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 6  (0x6)  (int)
>   volume.partition.start =3D 51095471616  (0xbe5870600)  (uint64)
>   volume.size =3D 4046805504  (0xf1355a00)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'a7d6c0a8-bfab-45d1-93ca-3d9f53af4c30'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_part5_size_2048062464'
>   block.device =3D '/dev/hda5'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 5  (0x5)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'Volume (swap)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_part5_size_204806=
2464'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda5'  (string)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'swap'  (string)
>   volume.fsusage =3D 'other'  (string)
>   volume.fsversion =3D '2'  (string)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D false  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount_point =3D ''  (string)
>   volume.num_blocks =3D 4000122  (0x3d097a)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 5  (0x5)  (int)
>   volume.partition.start =3D 49047376896  (0xb6b739400)  (uint64)
>   volume.size =3D 2048062464  (0x7a12f400)  (uint64)
>   volume.uuid =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_part4_size_1024'
>   block.device =3D '/dev/hda4'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 4  (0x4)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'Volume'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_part4_size_1024' =
 (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda4'  (string)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D ''  (string)
>   volume.fsusage =3D ''  (string)
>   volume.fsversion =3D ''  (string)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D false  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount_point =3D ''  (string)
>   volume.num_blocks =3D 2  (0x2)  (int)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 4  (0x4)  (int)
>   volume.partition.start =3D 49047344640  (0xb6b731600)  (uint64)
>   volume.size =3D 1024  (0x400)  (uint64)
>   volume.uuid =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_0c0e7b06_a8a7_4391_=
a2c7_d3e0f15194d3'
>   block.device =3D '/dev/hda3'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 3  (0x3)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'HOME'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_0c0e7b06_a8a=
7_4391_a2c7_d3e0f15194d3'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda3'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'HOME'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/home'  (string)
>   volume.num_blocks =3D 58589055  (0x37dff7f)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 3  (0x3)  (int)
>   volume.partition.scheme =3D 'mbr'  (string)
>   volume.partition.start =3D 19049748480  (0x46f741800)  (uint64)
>   volume.partition.type =3D '0x83'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 29997596160  (0x6fbfefe00)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D '0c0e7b06-a8a7-4391-a2c7-d3e0f15194d3'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_06bbd646_3133_4659_=
9091_79343e2a1f25'
>   block.device =3D '/dev/hda2'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 2  (0x2)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'USR'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_06bbd646_313=
3_4659_9091_79343e2a1f25'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda2'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D 'USR'  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/usr'  (string)
>   volume.num_blocks =3D 33206355  (0x1fab053)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 2  (0x2)  (int)
>   volume.partition.scheme =3D 'mbr'  (string)
>   volume.partition.start =3D 2048094720  (0x7a137200)  (uint64)
>   volume.partition.type =3D '0x83'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 17001653760  (0x3f560a600)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D '06bbd646-3133-4659-9091-79343e2a1f25'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_f6ecb3ed_6556_446e_=
bb4b_c76969a1507f'
>   block.device =3D '/dev/hda1'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 3  (0x3)  (int)
>   block.minor =3D 1  (0x1)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_VN343EC4G26U2K'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_VN343E=
C4G26U2K'  (string)
>   info.product =3D 'Volume (ext3)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_f6ecb3ed_655=
6_446e_bb4b_c76969a1507f'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hda/hda1'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/'  (string)
>   volume.num_blocks =3D 4000122  (0x3d097a)  (int)
>   volume.partition.flags =3D {'boot'} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 123522416640  (0x1cc2828000)  (uint=
64)
>   volume.partition.number =3D 1  (0x1)  (int)
>   volume.partition.scheme =3D 'mbr'  (string)
>   volume.partition.start =3D 32256  (0x7e00)  (uint64)
>   volume.partition.type =3D '0x83'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 2048062464  (0x7a12f400)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'f6ecb3ed-6556-446e-bb4b-c76969a1507f'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_2440'
>   info.bus =3D 'pci'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82801BA ISA Bridge (LPC)'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_2440'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.0'  (strin=
g)
>   pci.device_class =3D 6  (0x6)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 1  (0x1)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1f.0'  (s=
tring)
>   pci.product =3D '82801BA ISA Bridge (LPC)'  (string)
>   pci.product_id =3D 9280  (0x2440)  (int)
>   pci.subsys_product_id =3D 0  (0x0)  (int)
>   pci.subsys_vendor_id =3D 0  (0x0)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_244e'
>   info.bus =3D 'pci'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82801 PCI Bridge'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0'  (strin=
g)
>   pci.device_class =3D 6  (0x6)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 4  (0x4)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0'  (s=
tring)
>   pci.product =3D '82801 PCI Bridge'  (string)
>   pci.product_id =3D 9294  (0x244e)  (int)
>   pci.subsys_product_id =3D 0  (0x0)  (int)
>   pci.subsys_vendor_id =3D 0  (0x0)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_105a_4d69'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'Promise_IDE'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D '20269'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_105a_4d69'  (string)
>   info.vendor =3D 'Promise Technology, Inc.'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0e.0'  (string)
>   pci.device_class =3D 1  (0x1)  (int)
>   pci.device_protocol =3D 133  (0x85)  (int)
>   pci.device_subclass =3D 128  (0x80)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0e.0'  (string)
>   pci.product =3D '20269'  (string)
>   pci.product_id =3D 19817  (0x4d69)  (int)
>   pci.subsys_product =3D 'Ultra133TX2'  (string)
>   pci.subsys_product_id =3D 19816  (0x4d68)  (int)
>   pci.subsys_vendor =3D 'Promise Technology, Inc.'  (string)
>   pci.subsys_vendor_id =3D 4186  (0x105a)  (int)
>   pci.vendor =3D 'Promise Technology, Inc.'  (string)
>   pci.vendor_id =3D 4186  (0x105a)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_105a_4d69_ide_2_1'
>   ide.channel =3D 1  (0x1)  (int)
>   ide.host =3D 2  (0x2)  (int)
>   info.bus =3D 'ide'  (string)
>   info.linux.driver =3D 'ide-disk'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_105a_4d69'  (stri=
ng)
>   info.product =3D 'IDE device (slave)'  (string)
>   info.subsystem =3D 'ide'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_105a_4d69_ide_2_1'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'ide'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0e.0/ide2/2.1'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/storage_serial_S08BJ1CL606177'
>   block.device =3D '/dev/hdf'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 64  (0x40)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_S08BJ1CL606177'  (string)
>   info.capabilities =3D {'storage', 'block'} (string list)
>   info.category =3D 'storage'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_105a_4d69_ide_2_1=
'  (string)
>   info.product =3D 'SAMSUNG SP2514N'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/storage_serial_S08BJ1CL6=
06177'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdf'  (string)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'ide'  (string)
>   storage.drive_type =3D 'disk'  (string)
>   storage.firmware_version =3D 'VF100-41'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D false  (bool)
>   storage.model =3D 'SAMSUNG SP2514N'  (string)
>   storage.no_partitions_hint =3D false  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/comput=
er'  (string)
>   storage.partitioning_scheme =3D 'mbr'  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/computer'=
  (string)
>   storage.removable =3D false  (bool)
>   storage.removable.media_available =3D true  (bool)
>   storage.removable.media_size =3D 250059350016  (0x3a38b2e000)  (uin=
t64)
>   storage.requires_eject =3D false  (bool)
>   storage.serial =3D 'S08BJ1CL606177'  (string)
>   storage.size =3D 250059350016  (0x3a38b2e000)  (uint64)
>   storage.vendor =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_a5b077e6_2fd8_4501_=
8891_e8bc7dd436f0'
>   block.device =3D '/dev/hdf6'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 70  (0x46)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_S08BJ1CL606177'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_S08BJ1=
CL606177'  (string)
>   info.product =3D 'Volume (ext3)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_a5b077e6_2fd=
8_4501_8891_e8bc7dd436f0'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdf/hdf6'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/ftp'  (string)
>   volume.num_blocks =3D 244187937  (0xe8e0321)  (int)
>   volume.partition.media_size =3D 250059350016  (0x3a38b2e000)  (uint=
64)
>   volume.partition.number =3D 6  (0x6)  (int)
>   volume.partition.start =3D 125032513536  (0x1d1c84c000)  (uint64)
>   volume.size =3D 125024223744  (0x1d1c064200)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'a5b077e6-2fd8-4501-8891-e8bc7dd436f0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_d5bff4d9_8016_4517_=
bd33_2c60c5e31e1f'
>   block.device =3D '/dev/hdf5'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 69  (0x45)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_S08BJ1CL606177'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_S08BJ1=
CL606177'  (string)
>   info.product =3D 'Volume (ext3)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_d5bff4d9_801=
6_4517_bd33_2c60c5e31e1f'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdf/hdf5'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/music'  (string)
>   volume.num_blocks =3D 244203939  (0xe8e41a3)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 250059350016  (0x3a38b2e000)  (uint=
64)
>   volume.partition.number =3D 5  (0x5)  (int)
>   volume.partition.scheme =3D 'embr'  (string)
>   volume.partition.start =3D 64512  (0xfc00)  (uint64)
>   volume.partition.type =3D '0x83'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 125032416768  (0x1d1c834600)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D 'd5bff4d9-8016-4517-bd33-2c60c5e31e1f'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_part1_size_1024_1'
>   block.device =3D '/dev/hdf1'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 65  (0x41)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_S08BJ1CL606177'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_S08BJ1=
CL606177'  (string)
>   info.product =3D 'Volume'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_part1_size_1024_1=
'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hdf/hdf1'  (string)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D ''  (string)
>   volume.fsusage =3D 'partitiontable'  (string)
>   volume.fsversion =3D ''  (string)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D false  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount_point =3D ''  (string)
>   volume.num_blocks =3D 2  (0x2)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 250059350016  (0x3a38b2e000)  (uint=
64)
>   volume.partition.number =3D 1  (0x1)  (int)
>   volume.partition.scheme =3D 'mbr'  (string)
>   volume.partition.start =3D 32256  (0x7e00)  (uint64)
>   volume.partition.type =3D '0x05'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 1024  (0x400)  (uint64)
>   volume.uuid =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_105a_4d69_ide_2_0'
>   ide.channel =3D 0  (0x0)  (int)
>   ide.host =3D 2  (0x2)  (int)
>   info.bus =3D 'ide'  (string)
>   info.linux.driver =3D 'ide-disk'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_105a_4d69'  (stri=
ng)
>   info.product =3D 'IDE device (master)'  (string)
>   info.subsystem =3D 'ide'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_105a_4d69_ide_2_0'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'ide'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0e.0/ide2/2.0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/storage_serial_T4HRDFYC'
>   block.device =3D '/dev/hde'  (string)
>   block.is_volume =3D false  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 0  (0x0)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_T4HRDFYC'  (string)
>   info.capabilities =3D {'storage', 'block'} (string list)
>   info.category =3D 'storage'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_105a_4d69_ide_2_0=
'  (string)
>   info.product =3D 'Maxtor 5T040H4'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/storage_serial_T4HRDFYC'=
  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hde'  (string)
>   storage.automount_enabled_hint =3D true  (bool)
>   storage.bus =3D 'ide'  (string)
>   storage.drive_type =3D 'disk'  (string)
>   storage.firmware_version =3D 'TAH71DP0'  (string)
>   storage.hotpluggable =3D false  (bool)
>   storage.media_check_enabled =3D false  (bool)
>   storage.model =3D 'Maxtor 5T040H4'  (string)
>   storage.no_partitions_hint =3D false  (bool)
>   storage.originating_device =3D '/org/freedesktop/Hal/devices/comput=
er'  (string)
>   storage.partitioning_scheme =3D 'mbr'  (string)
>   storage.physical_device =3D '/org/freedesktop/Hal/devices/computer'=
  (string)
>   storage.removable =3D false  (bool)
>   storage.removable.media_available =3D true  (bool)
>   storage.removable.media_size =3D 40982151168  (0x98aba0000)  (uint6=
4)
>   storage.requires_eject =3D false  (bool)
>   storage.serial =3D 'T4HRDFYC'  (string)
>   storage.size =3D 40982151168  (0x98aba0000)  (uint64)
>   storage.vendor =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_uuid_342b5c16_d163_42a7_=
8703_c38f3159da10'
>   block.device =3D '/dev/hde5'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 5  (0x5)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_T4HRDFYC'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.interfaces =3D {'org.freedesktop.Hal.Device.Volume'} (string l=
ist)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_T4HRDF=
YC'  (string)
>   info.product =3D 'Volume (ext3)'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_uuid_342b5c16_d16=
3_42a7_8703_c38f3159da10'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hde/hde5'  (string)
>   org.freedesktop.Hal.Device.Volume.method_argnames =3D {'mount_point=
 fstype extra_options', 'extra_options', 'extra_options'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_execpaths =3D {'hal-storag=
e-mount', 'hal-storage-unmount', 'hal-storage-eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_names =3D {'Mount', 'Unmou=
nt', 'Eject'} (string list)
>   org.freedesktop.Hal.Device.Volume.method_signatures =3D {'ssas', 'a=
s', 'as'} (string list)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D 'ext3'  (string)
>   volume.fsusage =3D 'filesystem'  (string)
>   volume.fsversion =3D '1.0'  (string)
>   volume.ignore =3D false  (bool)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D true  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount.valid_options =3D {'ro', 'sync', 'dirsync', 'noatime',=
 'nodiratime', 'noexec', 'quiet', 'remount', 'exec', 'acl', 'user_xattr=
', 'data=3D'} (string list)
>   volume.mount_point =3D '/mnt/data'  (string)
>   volume.num_blocks =3D 80035704  (0x4c53f78)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 40982151168  (0x98aba0000)  (uint64=
)
>   volume.partition.number =3D 5  (0x5)  (int)
>   volume.partition.scheme =3D 'embr'  (string)
>   volume.partition.start =3D 64512  (0xfc00)  (uint64)
>   volume.partition.type =3D '0x83'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 40978280448  (0x98a7ef000)  (uint64)
>   volume.unmount.valid_options =3D {'lazy'} (string list)
>   volume.uuid =3D '342b5c16-d163-42a7-8703-c38f3159da10'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/volume_part1_size_1024_0'
>   block.device =3D '/dev/hde1'  (string)
>   block.is_volume =3D true  (bool)
>   block.major =3D 33  (0x21)  (int)
>   block.minor =3D 1  (0x1)  (int)
>   block.storage_device =3D '/org/freedesktop/Hal/devices/storage_seri=
al_T4HRDFYC'  (string)
>   info.capabilities =3D {'volume', 'block'} (string list)
>   info.category =3D 'volume'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/storage_serial_T4HRDF=
YC'  (string)
>   info.product =3D 'Volume'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/volume_part1_size_1024_0=
'  (string)
>   linux.hotplug_type =3D 3  (0x3)  (int)
>   linux.sysfs_path =3D '/sys/block/hde/hde1'  (string)
>   storage.model =3D ''  (string)
>   volume.block_size =3D 512  (0x200)  (int)
>   volume.fstype =3D ''  (string)
>   volume.fsusage =3D 'partitiontable'  (string)
>   volume.fsversion =3D ''  (string)
>   volume.is_disc =3D false  (bool)
>   volume.is_mounted =3D false  (bool)
>   volume.is_mounted_read_only =3D false  (bool)
>   volume.is_partition =3D true  (bool)
>   volume.label =3D ''  (string)
>   volume.linux.is_device_mapper =3D false  (bool)
>   volume.mount_point =3D ''  (string)
>   volume.num_blocks =3D 2  (0x2)  (int)
>   volume.partition.flags =3D {} (string list)
>   volume.partition.label =3D ''  (string)
>   volume.partition.media_size =3D 40982151168  (0x98aba0000)  (uint64=
)
>   volume.partition.number =3D 1  (0x1)  (int)
>   volume.partition.scheme =3D 'mbr'  (string)
>   volume.partition.start =3D 32256  (0x7e00)  (uint64)
>   volume.partition.type =3D '0x05'  (string)
>   volume.partition.uuid =3D ''  (string)
>   volume.size =3D 1024  (0x400)  (uint64)
>   volume.uuid =3D ''  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1106_3106'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'via-rhine'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D 'VT6105 [Rhine-III]'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1106_3106'  (string)
>   info.vendor =3D 'VIA Technologies, Inc.'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0d.0'  (string)
>   pci.device_class =3D 2  (0x2)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 0  (0x0)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0d.0'  (string)
>   pci.product =3D 'VT6105 [Rhine-III]'  (string)
>   pci.product_id =3D 12550  (0x3106)  (int)
>   pci.subsys_product =3D 'DFE-530TX rev C'  (string)
>   pci.subsys_product_id =3D 5123  (0x1403)  (int)
>   pci.subsys_vendor =3D 'D-Link System Inc'  (string)
>   pci.subsys_vendor_id =3D 4486  (0x1186)  (int)
>   pci.vendor =3D 'VIA Technologies, Inc.'  (string)
>   pci.vendor_id =3D 4358  (0x1106)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/net_00_11_95_81_e7_8b'
>   info.capabilities =3D {'net', 'net.80203'} (string list)
>   info.category =3D 'net.80203'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1106_3106'  (stri=
ng)
>   info.product =3D 'Networking Interface'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/net_00_11_95_81_e7_8b'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'net'  (string)
>   linux.sysfs_path =3D '/sys/class/net/eth0'  (string)
>   net.80203.mac_address =3D 75522762635  (0x119581e78b)  (uint64)
>   net.address =3D '00:11:95:81:e7:8b'  (string)
>   net.arp_proto_hw_id =3D 1  (0x1)  (int)
>   net.interface =3D 'eth0'  (string)
>   net.linux.ifindex =3D 2  (0x2)  (int)
>   net.originating_device =3D '/org/freedesktop/Hal/devices/pci_1106_3=
106'  (string)
>   net.physical_device =3D '/org/freedesktop/Hal/devices/pci_1106_3106=
'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5239'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'ehci_hcd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D 'USB 2.0 Controller'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5239'  (string)
>   info.vendor =3D 'ALi Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.3'  (string)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 32  (0x20)  (int)
>   pci.device_subclass =3D 3  (0x3)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.3'  (string)
>   pci.product =3D 'USB 2.0 Controller'  (string)
>   pci.product_id =3D 21049  (0x5239)  (int)
>   pci.subsys_product_id =3D 21106  (0x5272)  (int)
>   pci.subsys_vendor =3D 'ALi Corporation'  (string)
>   pci.subsys_vendor_id =3D 4281  (0x10b9)  (int)
>   pci.vendor =3D 'ALi Corporation'  (string)
>   pci.vendor_id =3D 4281  (0x10b9)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_3'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_10b9_5239'  (stri=
ng)
>   info.product =3D 'EHCI Host Controller'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_3'  (string)
>   info.vendor =3D 'Linux 2.6.24.2-waver.1 ehci_hcd'  (string)
>   linux.device_file =3D '/dev/bus/usb/004/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.3/usb4'  (string)
>   usb_device.bus_number =3D 4  (0x4)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 9  (0x9)  (int)
>   usb_device.device_protocol =3D 1  (0x1)  (int)
>   usb_device.device_revision_bcd =3D 518  (0x206)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 1  (0x1)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e=
=2E0/0000:02:0c.3/usb4'  (string)
>   usb_device.max_power =3D 0  (0x0)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 6  (0x6)  (int)
>   usb_device.product =3D 'EHCI Host Controller'  (string)
>   usb_device.product_id =3D 0  (0x0)  (int)
>   usb_device.serial =3D '0000:02:0c.3'  (string)
>   usb_device.speed =3D 480.0 (480) (double)
>   usb_device.speed_bcd =3D 294912  (0x48000)  (int)
>   usb_device.vendor =3D 'Linux 2.6.24.2-waver.1 ehci_hcd'  (string)
>   usb_device.vendor_id =3D 0  (0x0)  (int)
>   usb_device.version =3D 2.0 (2) (double)
>   usb_device.version_bcd =3D 512  (0x200)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_3_usb=
raw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_3'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_3_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/004/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev4.1'  (string)
>   usbraw.device =3D '/dev/bus/usb/004/001'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_3_if0=
'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'hub'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_3'  (string)
>   info.product =3D 'USB Hub Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_3_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.3/usb4/4-0:1.0'  (string)
>   usb.bus_number =3D 4  (0x4)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 9  (0x9)  (int)
>   usb.device_protocol =3D 1  (0x1)  (int)
>   usb.device_revision_bcd =3D 518  (0x206)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 9  (0x9)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 0  (0x0)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 1  (0x1)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.3/usb4/4-0:1.0'  (string)
>   usb.max_power =3D 0  (0x0)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 6  (0x6)  (int)
>   usb.product =3D 'USB Hub Interface'  (string)
>   usb.product_id =3D 0  (0x0)  (int)
>   usb.serial =3D '0000:02:0c.3'  (string)
>   usb.speed =3D 480.0 (480) (double)
>   usb.speed_bcd =3D 294912  (0x48000)  (int)
>   usb.vendor =3D 'Linux 2.6.24.2-waver.1 ehci_hcd'  (string)
>   usb.vendor_id =3D 0  (0x0)  (int)
>   usb.version =3D 2.0 (2) (double)
>   usb.version_bcd =3D 512  (0x200)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5237_1'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'ohci_hcd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D 'USB 1.1 Controller'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5237_1'  (strin=
g)
>   info.vendor =3D 'ALi Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.2'  (string)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 16  (0x10)  (int)
>   pci.device_subclass =3D 3  (0x3)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.2'  (string)
>   pci.product =3D 'USB 1.1 Controller'  (string)
>   pci.product_id =3D 21047  (0x5237)  (int)
>   pci.subsys_product =3D 'ASRock 939Dual-SATA2 Motherboard'  (string)
>   pci.subsys_product_id =3D 21047  (0x5237)  (int)
>   pci.subsys_vendor =3D 'ALi Corporation'  (string)
>   pci.subsys_vendor_id =3D 4281  (0x10b9)  (int)
>   pci.vendor =3D 'ALi Corporation'  (string)
>   pci.vendor_id =3D 4281  (0x10b9)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_2'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_10b9_5237_1'  (st=
ring)
>   info.product =3D 'OHCI Host Controller'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_2'  (string)
>   info.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   linux.device_file =3D '/dev/bus/usb/003/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.2/usb3'  (string)
>   usb_device.bus_number =3D 3  (0x3)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 9  (0x9)  (int)
>   usb_device.device_protocol =3D 0  (0x0)  (int)
>   usb_device.device_revision_bcd =3D 518  (0x206)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 1  (0x1)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e=
=2E0/0000:02:0c.2/usb3'  (string)
>   usb_device.max_power =3D 0  (0x0)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 2  (0x2)  (int)
>   usb_device.product =3D 'OHCI Host Controller'  (string)
>   usb_device.product_id =3D 0  (0x0)  (int)
>   usb_device.serial =3D '0000:02:0c.2'  (string)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   usb_device.vendor_id =3D 0  (0x0)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_2_usb=
raw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_2'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_2_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/003/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev3.1'  (string)
>   usbraw.device =3D '/dev/bus/usb/003/001'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_noserial'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_2'  (string)
>   info.product =3D 'CanoScan N670U/N676U/LiDE 20'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_nose=
rial'  (string)
>   info.vendor =3D 'Canon, Inc.'  (string)
>   linux.device_file =3D '/dev/bus/usb/003/002'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.2/usb3/3-1'  (string)
>   usb_device.bus_number =3D 3  (0x3)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 255  (0xff)  (int)
>   usb_device.device_protocol =3D 255  (0xff)  (int)
>   usb_device.device_revision_bcd =3D 256  (0x100)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D false  (bool)
>   usb_device.linux.device_number =3D 2  (0x2)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e=
=2E0/0000:02:0c.2/usb3/3-1'  (string)
>   usb_device.max_power =3D 500  (0x1f4)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 0  (0x0)  (int)
>   usb_device.product =3D 'CanoScan N670U/N676U/LiDE 20'  (string)
>   usb_device.product_id =3D 8717  (0x220d)  (int)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Canon, Inc.'  (string)
>   usb_device.vendor_id =3D 1193  (0x4a9)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_noserial_us=
braw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_n=
oserial'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_nose=
rial_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/003/002'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev3.2'  (string)
>   usbraw.device =3D '/dev/bus/usb/003/002'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_noserial_if=
0'
>   info.bus =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_n=
oserial'  (string)
>   info.product =3D 'USB Vendor Specific Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_4a9_220d_nose=
rial_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.2/usb3/3-1/3-1:1.0'  (string)
>   usb.bus_number =3D 3  (0x3)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 255  (0xff)  (int)
>   usb.device_protocol =3D 255  (0xff)  (int)
>   usb.device_revision_bcd =3D 256  (0x100)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 255  (0xff)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 255  (0xff)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D false  (bool)
>   usb.linux.device_number =3D 2  (0x2)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.2/usb3/3-1/3-1:1.0'  (string)
>   usb.max_power =3D 500  (0x1f4)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 0  (0x0)  (int)
>   usb.product =3D 'USB Vendor Specific Interface'  (string)
>   usb.product_id =3D 8717  (0x220d)  (int)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Canon, Inc.'  (string)
>   usb.vendor_id =3D 1193  (0x4a9)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_2_if0=
'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'hub'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_2'  (string)
>   info.product =3D 'USB Hub Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_2_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.2/usb3/3-0:1.0'  (string)
>   usb.bus_number =3D 3  (0x3)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 9  (0x9)  (int)
>   usb.device_protocol =3D 0  (0x0)  (int)
>   usb.device_revision_bcd =3D 518  (0x206)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 9  (0x9)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 0  (0x0)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 1  (0x1)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.2/usb3/3-0:1.0'  (string)
>   usb.max_power =3D 0  (0x0)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 2  (0x2)  (int)
>   usb.product =3D 'USB Hub Interface'  (string)
>   usb.product_id =3D 0  (0x0)  (int)
>   usb.serial =3D '0000:02:0c.2'  (string)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   usb.vendor_id =3D 0  (0x0)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5237_0'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'ohci_hcd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D 'USB 1.1 Controller'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5237_0'  (strin=
g)
>   info.vendor =3D 'ALi Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.1'  (string)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 16  (0x10)  (int)
>   pci.device_subclass =3D 3  (0x3)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.1'  (string)
>   pci.product =3D 'USB 1.1 Controller'  (string)
>   pci.product_id =3D 21047  (0x5237)  (int)
>   pci.subsys_product =3D 'ASRock 939Dual-SATA2 Motherboard'  (string)
>   pci.subsys_product_id =3D 21047  (0x5237)  (int)
>   pci.subsys_vendor =3D 'ALi Corporation'  (string)
>   pci.subsys_vendor_id =3D 4281  (0x10b9)  (int)
>   pci.vendor =3D 'ALi Corporation'  (string)
>   pci.vendor_id =3D 4281  (0x10b9)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_1'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_10b9_5237_0'  (st=
ring)
>   info.product =3D 'OHCI Host Controller'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_1'  (string)
>   info.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   linux.device_file =3D '/dev/bus/usb/002/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.1/usb2'  (string)
>   usb_device.bus_number =3D 2  (0x2)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 9  (0x9)  (int)
>   usb_device.device_protocol =3D 0  (0x0)  (int)
>   usb_device.device_revision_bcd =3D 518  (0x206)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 1  (0x1)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e=
=2E0/0000:02:0c.1/usb2'  (string)
>   usb_device.max_power =3D 0  (0x0)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 2  (0x2)  (int)
>   usb_device.product =3D 'OHCI Host Controller'  (string)
>   usb_device.product_id =3D 0  (0x0)  (int)
>   usb_device.serial =3D '0000:02:0c.1'  (string)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   usb_device.vendor_id =3D 0  (0x0)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_1_usb=
raw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_1'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_1_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/002/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev2.1'  (string)
>   usbraw.device =3D '/dev/bus/usb/002/001'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_1_if0=
'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'hub'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_1'  (string)
>   info.product =3D 'USB Hub Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_1_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.1/usb2/2-0:1.0'  (string)
>   usb.bus_number =3D 2  (0x2)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 9  (0x9)  (int)
>   usb.device_protocol =3D 0  (0x0)  (int)
>   usb.device_revision_bcd =3D 518  (0x206)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 9  (0x9)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 0  (0x0)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 1  (0x1)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.1/usb2/2-0:1.0'  (string)
>   usb.max_power =3D 0  (0x0)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 2  (0x2)  (int)
>   usb.product =3D 'USB Hub Interface'  (string)
>   usb.product_id =3D 0  (0x0)  (int)
>   usb.serial =3D '0000:02:0c.1'  (string)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   usb.vendor_id =3D 0  (0x0)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5237'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'ohci_hcd'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D 'USB 1.1 Controller'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_10b9_5237'  (string)
>   info.vendor =3D 'ALi Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.0'  (string)
>   pci.device_class =3D 12  (0xc)  (int)
>   pci.device_protocol =3D 16  (0x10)  (int)
>   pci.device_subclass =3D 3  (0x3)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.0'  (string)
>   pci.product =3D 'USB 1.1 Controller'  (string)
>   pci.product_id =3D 21047  (0x5237)  (int)
>   pci.subsys_product =3D 'ASRock 939Dual-SATA2 Motherboard'  (string)
>   pci.subsys_product_id =3D 21047  (0x5237)  (int)
>   pci.subsys_vendor =3D 'ALi Corporation'  (string)
>   pci.subsys_vendor_id =3D 4281  (0x10b9)  (int)
>   pci.vendor =3D 'ALi Corporation'  (string)
>   pci.vendor_id =3D 4281  (0x10b9)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_0'
>   info.bus =3D 'usb_device'  (string)
>   info.linux.driver =3D 'usb'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_10b9_5237'  (stri=
ng)
>   info.product =3D 'OHCI Host Controller'  (string)
>   info.subsystem =3D 'usb_device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_0'  (string)
>   info.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   linux.device_file =3D '/dev/bus/usb/001/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.0/usb1'  (string)
>   usb_device.bus_number =3D 1  (0x1)  (int)
>   usb_device.can_wake_up =3D true  (bool)
>   usb_device.configuration_value =3D 1  (0x1)  (int)
>   usb_device.device_class =3D 9  (0x9)  (int)
>   usb_device.device_protocol =3D 0  (0x0)  (int)
>   usb_device.device_revision_bcd =3D 518  (0x206)  (int)
>   usb_device.device_subclass =3D 0  (0x0)  (int)
>   usb_device.is_self_powered =3D true  (bool)
>   usb_device.linux.device_number =3D 1  (0x1)  (int)
>   usb_device.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e=
=2E0/0000:02:0c.0/usb1'  (string)
>   usb_device.max_power =3D 0  (0x0)  (int)
>   usb_device.num_configurations =3D 1  (0x1)  (int)
>   usb_device.num_interfaces =3D 1  (0x1)  (int)
>   usb_device.num_ports =3D 2  (0x2)  (int)
>   usb_device.product =3D 'OHCI Host Controller'  (string)
>   usb_device.product_id =3D 0  (0x0)  (int)
>   usb_device.serial =3D '0000:02:0c.0'  (string)
>   usb_device.speed =3D 12.0 (12) (double)
>   usb_device.speed_bcd =3D 4608  (0x1200)  (int)
>   usb_device.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   usb_device.vendor_id =3D 0  (0x0)  (int)
>   usb_device.version =3D 1.1 (1.1) (double)
>   usb_device.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_0_usb=
raw'
>   info.capabilities =3D {'usbraw'} (string list)
>   info.category =3D 'usbraw'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_0'  (string)
>   info.product =3D 'USB Raw Device Access'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_0_usbraw'  (string)
>   linux.device_file =3D '/dev/bus/usb/001/001'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb_device'  (string)
>   linux.sysfs_path =3D '/sys/class/usb_device/usbdev1.1'  (string)
>   usbraw.device =3D '/dev/bus/usb/001/001'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0c_0_if0=
'
>   info.bus =3D 'usb'  (string)
>   info.linux.driver =3D 'hub'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_0=
2_0c_0'  (string)
>   info.product =3D 'USB Hub Interface'  (string)
>   info.subsystem =3D 'usb'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/usb_device_0_0_0000_02_0=
c_0_if0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'usb'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0c.0/usb1/1-0:1.0'  (string)
>   usb.bus_number =3D 1  (0x1)  (int)
>   usb.can_wake_up =3D true  (bool)
>   usb.configuration_value =3D 1  (0x1)  (int)
>   usb.device_class =3D 9  (0x9)  (int)
>   usb.device_protocol =3D 0  (0x0)  (int)
>   usb.device_revision_bcd =3D 518  (0x206)  (int)
>   usb.device_subclass =3D 0  (0x0)  (int)
>   usb.interface.class =3D 9  (0x9)  (int)
>   usb.interface.number =3D 0  (0x0)  (int)
>   usb.interface.protocol =3D 0  (0x0)  (int)
>   usb.interface.subclass =3D 0  (0x0)  (int)
>   usb.is_self_powered =3D true  (bool)
>   usb.linux.device_number =3D 1  (0x1)  (int)
>   usb.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0c.0/usb1/1-0:1.0'  (string)
>   usb.max_power =3D 0  (0x0)  (int)
>   usb.num_configurations =3D 1  (0x1)  (int)
>   usb.num_interfaces =3D 1  (0x1)  (int)
>   usb.num_ports =3D 2  (0x2)  (int)
>   usb.product =3D 'USB Hub Interface'  (string)
>   usb.product_id =3D 0  (0x0)  (int)
>   usb.serial =3D '0000:02:0c.0'  (string)
>   usb.speed =3D 12.0 (12) (double)
>   usb.speed_bcd =3D 4608  (0x1200)  (int)
>   usb.vendor =3D 'Linux 2.6.24.2-waver.1 ohci_hcd'  (string)
>   usb.vendor_id =3D 0  (0x0)  (int)
>   usb.version =3D 1.1 (1.1) (double)
>   usb.version_bcd =3D 272  (0x110)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_10ec_8139'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D '8139too'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D 'RTL-8139/8139C/8139C+'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_10ec_8139'  (string)
>   info.vendor =3D 'Realtek Semiconductor Co., Ltd.'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0b.0'  (string)
>   pci.device_class =3D 2  (0x2)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 0  (0x0)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0b.0'  (string)
>   pci.product =3D 'RTL-8139/8139C/8139C+'  (string)
>   pci.product_id =3D 33081  (0x8139)  (int)
>   pci.subsys_product =3D 'RT8139'  (string)
>   pci.subsys_product_id =3D 33081  (0x8139)  (int)
>   pci.subsys_vendor =3D 'Realtek Semiconductor Co., Ltd.'  (string)
>   pci.subsys_vendor_id =3D 4332  (0x10ec)  (int)
>   pci.vendor =3D 'Realtek Semiconductor Co., Ltd.'  (string)
>   pci.vendor_id =3D 4332  (0x10ec)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/net_00_40_f4_55_91_dc'
>   info.capabilities =3D {'net', 'net.80203'} (string list)
>   info.category =3D 'net.80203'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_10ec_8139'  (stri=
ng)
>   info.product =3D 'Networking Interface'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/net_00_40_f4_55_91_dc'  =
(string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'net'  (string)
>   linux.sysfs_path =3D '/sys/class/net/eth1'  (string)
>   net.80203.mac_address =3D 278977155548  (0x40f45591dc)  (uint64)
>   net.address =3D '00:40:f4:55:91:dc'  (string)
>   net.arp_proto_hw_id =3D 1  (0x1)  (int)
>   net.interface =3D 'eth1'  (string)
>   net.linux.ifindex =3D 3  (0x3)  (int)
>   net.originating_device =3D '/org/freedesktop/Hal/devices/pci_10ec_8=
139'  (string)
>   net.physical_device =3D '/org/freedesktop/Hal/devices/pci_10ec_8139=
'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'ENS1371'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_244e'  (stri=
ng)
>   info.product =3D '5880 AudioPCI'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (string)
>   info.vendor =3D 'Ensoniq'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000:02:=
0a.0'  (string)
>   pci.device_class =3D 4  (0x4)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 1  (0x1)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:1e.0/0000=
:02:0a.0'  (string)
>   pci.product =3D '5880 AudioPCI'  (string)
>   pci.product_id =3D 22656  (0x5880)  (int)
>   pci.subsys_product =3D 'Sound Blaster 16PCI 4.1ch'  (string)
>   pci.subsys_product_id =3D 32769  (0x8001)  (int)
>   pci.subsys_vendor =3D 'Ensoniq'  (string)
>   pci.subsys_vendor_id =3D 4724  (0x1274)  (int)
>   pci.vendor =3D 'Ensoniq'  (string)
>   pci.vendor_id =3D 4724  (0x1274)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_playback_1'
>   alsa.card =3D 0  (0x0)  (int)
>   alsa.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   alsa.device =3D 1  (0x1)  (int)
>   alsa.device_file =3D '/dev/snd/pcmC0D1p'  (string)
>   alsa.device_id =3D 'ES1371 DAC1'  (string)
>   alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_=
5880'  (string)
>   alsa.pcm_class =3D 'generic'  (string)
>   alsa.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_588=
0'  (string)
>   alsa.type =3D 'playback'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC1 ALSA Playback Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_playb=
ack_1'  (string)
>   linux.device_file =3D '/dev/snd/pcmC0D1p'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/pcmC0D1p'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_playback_0'
>   alsa.card =3D 0  (0x0)  (int)
>   alsa.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   alsa.device =3D 0  (0x0)  (int)
>   alsa.device_file =3D '/dev/snd/pcmC0D0p'  (string)
>   alsa.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_=
5880'  (string)
>   alsa.pcm_class =3D 'generic'  (string)
>   alsa.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_588=
0'  (string)
>   alsa.type =3D 'playback'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC ALSA Playback Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_playb=
ack_0'  (string)
>   linux.device_file =3D '/dev/snd/pcmC0D0p'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/pcmC0D0p'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_capture_0'
>   alsa.card =3D 0  (0x0)  (int)
>   alsa.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   alsa.device =3D 0  (0x0)  (int)
>   alsa.device_file =3D '/dev/snd/pcmC0D0c'  (string)
>   alsa.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_=
5880'  (string)
>   alsa.pcm_class =3D 'generic'  (string)
>   alsa.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_588=
0'  (string)
>   alsa.type =3D 'capture'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC ALSA Capture Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_captu=
re_0'  (string)
>   linux.device_file =3D '/dev/snd/pcmC0D0c'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/pcmC0D0c'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_mixer__1'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC OSS Control Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_mixer_=
_1'  (string)
>   linux.device_file =3D '/dev/mixer'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/mixer'  (string)
>   oss.card =3D 0  (0x0)  (int)
>   oss.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   oss.device_file =3D '/dev/mixer'  (string)
>   oss.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   oss.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_5=
880'  (string)
>   oss.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_5880=
'  (string)
>   oss.type =3D 'mixer'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_midi_0'
>   alsa.card =3D 0  (0x0)  (int)
>   alsa.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   alsa.device =3D 0  (0x0)  (int)
>   alsa.device_file =3D '/dev/snd/midiC0D0'  (string)
>   alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_=
5880'  (string)
>   alsa.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_588=
0'  (string)
>   alsa.type =3D 'midi'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'Ensoniq AudioPCI ENS1371 ALSA MIDI Device'  (stri=
ng)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_midi_=
0'  (string)
>   linux.device_file =3D '/dev/snd/midiC0D0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/midiC0D0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_midi_0'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC OSS MIDI Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_midi_0=
'  (string)
>   linux.device_file =3D '/dev/midi'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/midi'  (string)
>   oss.card =3D 0  (0x0)  (int)
>   oss.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   oss.device =3D 0  (0x0)  (int)
>   oss.device_file =3D '/dev/midi'  (string)
>   oss.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   oss.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_5=
880'  (string)
>   oss.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_5880=
'  (string)
>   oss.type =3D 'midi'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_pcm_0_0'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC OSS PCM Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_pcm_0_=
0'  (string)
>   linux.device_file =3D '/dev/dsp'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/dsp'  (string)
>   oss.card =3D 0  (0x0)  (int)
>   oss.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   oss.device =3D 0  (0x0)  (int)
>   oss.device_file =3D '/dev/dsp'  (string)
>   oss.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   oss.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_5=
880'  (string)
>   oss.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_5880=
'  (string)
>   oss.type =3D 'pcm'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_control__1'
>   alsa.card =3D 0  (0x0)  (int)
>   alsa.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   alsa.device_file =3D '/dev/snd/controlC0'  (string)
>   alsa.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_=
5880'  (string)
>   alsa.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_588=
0'  (string)
>   alsa.type =3D 'control'  (string)
>   info.capabilities =3D {'alsa'} (string list)
>   info.category =3D 'alsa'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'Ensoniq AudioPCI ENS1371 ALSA Control Device'  (s=
tring)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_alsa_contr=
ol__1'  (string)
>   linux.device_file =3D '/dev/snd/controlC0'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/controlC0'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_pcm_0'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC OSS PCM Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_pcm_0'=
  (string)
>   linux.device_file =3D '/dev/audio'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/audio'  (string)
>   oss.card =3D 0  (0x0)  (int)
>   oss.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   oss.device =3D 0  (0x0)  (int)
>   oss.device_file =3D '/dev/audio'  (string)
>   oss.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   oss.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_5=
880'  (string)
>   oss.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_5880=
'  (string)
>   oss.type =3D 'pcm'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_pcm_1'
>   info.capabilities =3D {'oss'} (string list)
>   info.category =3D 'oss'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_1274_5880'  (stri=
ng)
>   info.product =3D 'ES1371 DAC2/ADC OSS PCM Device'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_1274_5880_oss_pcm_1'=
  (string)
>   linux.device_file =3D '/dev/adsp'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'sound'  (string)
>   linux.sysfs_path =3D '/sys/class/sound/adsp'  (string)
>   oss.card =3D 0  (0x0)  (int)
>   oss.card_id =3D 'Ensoniq AudioPCI ENS1371'  (string)
>   oss.device =3D 1  (0x1)  (int)
>   oss.device_file =3D '/dev/adsp'  (string)
>   oss.device_id =3D 'ES1371 DAC2/ADC'  (string)
>   oss.originating_device =3D '/org/freedesktop/Hal/devices/pci_1274_5=
880'  (string)
>   oss.physical_device =3D '/org/freedesktop/Hal/devices/pci_1274_5880=
'  (string)
>   oss.type =3D 'pcm'  (string)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_1a31'
>   info.bus =3D 'pci'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82845 845 [Brookdale] Chipset AGP Bridge'  (strin=
g)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_1a31'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0'  (strin=
g)
>   pci.device_class =3D 6  (0x6)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 4  (0x4)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0'  (s=
tring)
>   pci.product =3D '82845 845 [Brookdale] Chipset AGP Bridge'  (string=
)
>   pci.product_id =3D 6705  (0x1a31)  (int)
>   pci.subsys_product_id =3D 0  (0x0)  (int)
>   pci.subsys_vendor_id =3D 0  (0x0)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_10de_181'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'nvidia'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/pci_8086_1a31'  (stri=
ng)
>   info.product =3D 'NV18 [GeForce4 MX 440 AGP 8x]'  (string)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_10de_181'  (string)
>   info.vendor =3D 'nVidia Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000:01:=
00.0'  (string)
>   pci.device_class =3D 3  (0x3)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 0  (0x0)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:01.0/0000=
:01:00.0'  (string)
>   pci.product =3D 'NV18 [GeForce4 MX 440 AGP 8x]'  (string)
>   pci.product_id =3D 385  (0x181)  (int)
>   pci.subsys_product =3D 'GeForce4 MX 440 AGP 8X'  (string)
>   pci.subsys_product_id =3D 32867  (0x8063)  (int)
>   pci.subsys_vendor =3D 'ASUSTeK Computer Inc.'  (string)
>   pci.subsys_vendor_id =3D 4163  (0x1043)  (int)
>   pci.vendor =3D 'nVidia Corporation'  (string)
>   pci.vendor_id =3D 4318  (0x10de)  (int)
>=20
> udi =3D '/org/freedesktop/Hal/devices/pci_8086_1a30'
>   info.bus =3D 'pci'  (string)
>   info.linux.driver =3D 'agpgart-intel'  (string)
>   info.parent =3D '/org/freedesktop/Hal/devices/computer'  (string)
>   info.product =3D '82845 845 [Brookdale] Chipset Host Bridge'  (stri=
ng)
>   info.subsystem =3D 'pci'  (string)
>   info.udi =3D '/org/freedesktop/Hal/devices/pci_8086_1a30'  (string)
>   info.vendor =3D 'Intel Corporation'  (string)
>   linux.hotplug_type =3D 2  (0x2)  (int)
>   linux.subsystem =3D 'pci'  (string)
>   linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:00.0'  (strin=
g)
>   pci.device_class =3D 6  (0x6)  (int)
>   pci.device_protocol =3D 0  (0x0)  (int)
>   pci.device_subclass =3D 0  (0x0)  (int)
>   pci.linux.sysfs_path =3D '/sys/devices/pci0000:00/0000:00:00.0'  (s=
tring)
>   pci.product =3D '82845 845 [Brookdale] Chipset Host Bridge'  (strin=
g)
>   pci.product_id =3D 6704  (0x1a30)  (int)
>   pci.subsys_product_id =3D 32880  (0x8070)  (int)
>   pci.subsys_vendor =3D 'ASUSTeK Computer Inc.'  (string)
>   pci.subsys_vendor_id =3D 4163  (0x1043)  (int)
>   pci.vendor =3D 'Intel Corporation'  (string)
>   pci.vendor_id =3D 32902  (0x8086)  (int)
>=20
>=20
> Dumped 121 device(s) from the Global Device List.
> ------------------------------------------------
>=20


--=20
Regards/Gru=DF,
    Boris.
