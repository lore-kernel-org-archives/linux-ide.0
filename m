From: Declan Moriarty <declan.moriarty@iol.ie>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Tue, 30 Oct 2007 13:02:16 +0000
Message-ID: <1193749336.2360.88.camel@localhost.localdomain>
References: <949545.3641.qm@web54410.mail.yahoo.com>
	 <1193655202.2506.27.camel@localhost.localdomain>
	 <20071029112048.3b323276@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.mail.iol.ie ([193.95.141.54]:43277 "EHLO
	mail2.mail.iol.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbXJ3NCT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 09:02:19 -0400
In-Reply-To: <20071029112048.3b323276@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vlad Codrea <vladc6@yahoo.com>, linux-ide <linux-ide@vger.kernel.org>

On Mon, 2007-10-29 at 11:20 +0000, Alan Cox wrote: 
> > I really doubt if libata alone would do much for me, as the disk and
> > bios doesn't really want to know about ata at all. We're 1998 here,
> > remember. ATA has to be disabled for this to read the disk at all.
> 
> 1998 is well into the world of ATA (IDE is just a confusing othername)
Yeah I read it as 'faster ide' but the board/disk won't do it. The disk
seems up to it, but something else is dodgy.
> 
> From your info there isn't enough to debug this. 
> 
> Boot the kernel with initcall_debug=1
> 
> and it will spew a list of each initializer as it calls it, you can then
> see which is the last called and look it up in the symbol table

That's the sort of thing a luser like me needs to know! 
/busies himself compiling a _working_ 2.6.22.6 kernel without gigabytes
of network stuff clogging buffers and with symbols in . . . split & load
by floppy, Reassemble.

Much later:
These initcalls all came in, ran for a 0-5 milliseconds, and returned
zero unless otherwise stated. There are more, but they're at the
beginning of the kernel, when it's setting itself up. I can copy the lot
if needed.

dma_bus_init
pci_legacy_init (ran for 6 msec)
	Probing PCI hardware
	PCI quirk; region 8000-803f claimed by PIIX4 ACPI
	PCI quirk: region 2180-218f claimed by PIIX4 SMB
	PIIX4 devres B PIO at 0398-0399
	PIIX4 devres C PIO at 0372-0373
	PIIX4 devres E PIO at 0370-0371
	PIIX4 devres G PIO at 0388-038f
pcibios_irq_init
	PCI: Discovered primary peer bus ff [IRQ]
	PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:01:0
	PCI: Found IRQ 10 for device 0000:00:0a:0
pcibios_init
..
procswaps_init
init_tmpfs
slab_sysfs
fasync_init
aio_setup
inotify_setup
inotify_user_setup
init_mbcache
dnotify_init
init_devpts_fs
init_ext3_fs
journal_init
init_ext2_fs
init_ramfs_fs
init_minix_fs
init_fat_fs
init_msdos_fs
init_vfat_fs
init_nls_cp437
init_nls_utf8
ipc_init
ipc_sysctl_init
crypto+algapi_init
cryptomgr_init
hmac_module_init
init+0x0/0x10
noop_init
as_init
	io scheduler <blah>
deadline_init
	io scheduler <blah>
deadline_init
	io scheduler <blah>
cfq_init
	io scheduler <blah>
bloct_trace_init
audit_classes_init
pci_init
	Limiting direct PCI/PCI transfers
pci_proc_init
fb_console_init
vesafb_init
rand_initialize
tty_init *** ran for 26 msec***
pty_init
rtc_init
	RTC <blah>
nvram_init
serial8250_init
serial9250_pci_init
isa_bus_init
floppy_init
	Floppy <blah>
***Ran for 15 msec***(asterisks mine)

loop_init
net_olddevs_init
loopback_init
videodev_init
	Linux video Capture <blah>
rz1000_ide_init
generic_ide_init
ide_init
	Uniform  Multi-Platform E-IDE driver Revision 7.00alpha2
	ide assuming 33 Mhz
ide_generic_init
	Hitatchi_DK226A-32 ATA disk drive
	ide0 at 0x1f0-0x1f7 on irq 14
*** ide_generic_init took 1446 msec to run***(asterisks mine)


idedisk_init
	hda: max request size:128KiB
	hda: 6332256 sectors (3242 MB) w/128 KiB Cache CHS=6282/16/63
	hda: hda1 hda2 hda3 hda4
*** Ran for 18 msec*** (asterisks mine)

mon_init
i8042_init
	PNP: No PS/2 controller found, probing ports directly
	serio i8042 KBD port at <blah>
	serio:i8042 AUX port at <blah>
i8042_init
serport_init
mousedev_init
	mouse PS/2 mouse <blah>
atkbd_init
psmouse_init
hid_init
	<USB blurb>
hid_init
flow_cache_init
xfrm_user_init
	Initialising XFRM Netlink Socket
af_unix_init
	NET: Registered protocol family 1
packet_init
	NET: Registered protocol family 17

***powernow_init***  Returned -19 (asterisks mine)

check_nmi_watchdog
apic_bug_finalize
print_ipi_mode
	Using IPI Shortcut mode
random32_reseed
pci_sysfs_init
seqgen_init
early_uart_console_switch
tcp_congestion_default
	input: PS2++ Logitech Touchpad 3 as class/input/input0
	input: AT keyboard as class/input/input1
	kjournald Commit interval 5 seconds
	EXT3-fs: mounted filesystem with ordered data mode
	VFS: Mounted root (ext3 filesystem) readonly
	Freeing unused kernel memory: 176k freed

Looking right back to the beginning, it ran a thing it called the
Locking API Testsuite
The summary was "145 out of 218 testcases failed, as expected" 

