From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: ide-tape oops
Date: Wed, 09 Mar 2005 21:23:33 -0800
Message-ID: <422FD9D5.5010509@osdl.org>
References: <7619.202.12.233.21.1110421544.squirrel@webmail.theforce.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030403060101040206060508"
Received: from fire.osdl.org ([65.172.181.4]:16536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261924AbVCJFf6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2005 00:35:58 -0500
In-Reply-To: <7619.202.12.233.21.1110421544.squirrel@webmail.theforce.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grahame Jordan <gbj@theforce.com.au>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030403060101040206060508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grahame Jordan wrote:
> Hi,
> 
> I have a machine on which when I run something like mt -f /dev/ht0 status
> it seg faults. However I have another machine same spec that works OK?
> 
> Any help would be appreciated
> 

<drive> is null in idetape_chrdev_open.
Please apply and test with the attached patch, just to try to
find out what is going one.

> 
> Debian testing
> Linux hanlay 2.6.8-2-686-smp #1 SMP Mon Jan 24 02:32:52 EST 2005 i686
> GNU/Linux
> P4 3.2GHz
> 1GB RAM
> 
>  <6>i2c /dev entries driver
> Unable to handle kernel NULL pointer dereference at virtual address 00000020
>  printing eip:
> f891744e
> *pde = 00000000
> Oops: 0000 [#3]
> PREEMPT SMP
> Modules linked in: i2c_dev i2c_i801 i2c_core tsdev mousedev psmouse ipv6
> snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport
> snd_mpu401_uart snd_rawmidi snd_seq_device snd hw_random shpchp pciehp
> pci_hotplug intel_agp intel_mch_agp agpgart evdev ehci_hcd eth1394
> uhci_hcd usbcore i810_audio ac97_codec soundcore piix sk98lin ohci1394
> capability commoncap ide_tape sbp2 ieee1394 ide_cd ide_core genrtc ext2
> ext3 jbd mbcache sr_mod cdrom sd_mod sata_promise ata_piix libata scsi_mod
> unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
> CPU:    0
> EIP:    0060:[<f891744e>]    Not tainted
> EFLAGS: 00010297   (2.6.8-2-686-smp)
> EIP is at idetape_chrdev_open+0x3e/0x190 [ide_tape]
> eax: 00000000   ebx: 00000000   ecx: f738d440   edx: fffffffa
> esi: 00000000   edi: cb534000   ebp: f7642380   esp: cb535dac
> ds: 007b   es: 007b   ss: 0068
> Process mt (pid: 7038, threadinfo=cb534000 task=f7005210)
> Stack: f738b51c f7642380 0000000f 00000001 00000286 00000000 00000132
> f7b2ac00
>        f756cd9c 422faee6 24eb6ec0 f756cdd8 cb457400 cb457404 40165000
> c1000000
>        c014de6b c1169f40 422faee6 24eb6ec0 00000000 c02de380 00000282
> 00000246
> Call Trace:
>  [<c014de6b>] zap_pte_range+0x3b/0x2d0
>  [<c0142a56>] buffered_rmqueue+0x116/0x230
>  [<c0142e80>] __alloc_pages+0x310/0x370
>  [<c013e2bb>] find_get_page+0x3b/0x70
>  [<c013f5b9>] filemap_nopage+0x229/0x3c0
>  [<c0179cf1>] dput+0x31/0x270
>  [<c016fe4e>] link_path_walk+0xc2e/0x1020
>  [<c014d9ee>] pte_alloc_map+0xae/0x100
>  [<c016ebf7>] permission+0x67/0x80
>  [<c016a453>] cdev_get+0x53/0xb0
>  [<c016a0a5>] chrdev_open+0x125/0x290
>  [<c0160931>] get_empty_filp+0x71/0x110
>  [<c015ec2a>] dentry_open+0x16a/0x260
>  [<c015eab8>] filp_open+0x68/0x70
>  [<c015ed69>] get_unused_fd+0x49/0x100
>  [<c015ef9b>] sys_open+0x5b/0x90
>  [<c01061fb>] syscall_call+0x7/0xb
> Code: 8b 5e 20 89 b5 80 00 00 00 f0 0f ba ab fc 18 00 00 02 19 c0


-- 
~Randy

--------------030403060101040206060508
Content-Type: text/x-patch;
 name="ide_tape_test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_tape_test.patch"


idetape_chrdev_open() is finding drive == NULL; test why?

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/ide/ide-tape.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -Naurp ./drivers/ide/ide-tape.c~ide_tape_test ./drivers/ide/ide-tape.c
--- ./drivers/ide/ide-tape.c~ide_tape_test	2005-03-01 23:37:54.000000000 -0800
+++ ./drivers/ide/ide-tape.c	2005-03-09 21:16:57.000000000 -0800
@@ -4108,6 +4108,8 @@ static int idetape_chrdev_open (struct i
 	if (i >= MAX_HWIFS * MAX_DRIVES)
 		return -ENXIO;
 	drive = idetape_chrdevs[i].drive;
+	printk("ide-tape-open-test: using minor = %d, i = %d, drive = 0x%p\n",
+		minor, i, drive);
 	tape = drive->driver_data;
 	filp->private_data = drive;
 
@@ -4640,6 +4642,7 @@ static int idetape_cleanup (ide_drive_t 
 		return 1;
 	}
 	idetape_chrdevs[minor].drive = NULL;
+	printk("ide-tape-cleanup-test: clearing drive for minor = %d\n", minor);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	DRIVER(drive)->busy = 0;
 	(void) ide_unregister_subdriver(drive);
@@ -4779,6 +4782,8 @@ static int idetape_attach (ide_drive_t *
 		;
 	idetape_setup(drive, tape, minor);
 	idetape_chrdevs[minor].drive = drive;
+	printk("ide-tape-attach-test: using minor = %d for drive = 0x%p\n",
+		minor, drive);
 
 	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
 			S_IFCHR | S_IRUGO | S_IWUGO,

--------------030403060101040206060508--
