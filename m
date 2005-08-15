From: Vassili Leonov <vleo@linuxmedialabs.com>
Subject: kernel 2.4.31 sata_sil.c bug
Date: 16 Aug 2005 00:57:24 +0400
Message-ID: <1124139444.1971.7.camel@hydra.lml>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rynnlioEf1Njt+fikvbs"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linuxmedialabs.com ([63.247.194.250]:23777 "EHLO
	linuxmedialabs.com") by vger.kernel.org with ESMTP id S964961AbVHOU5r
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Aug 2005 16:57:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


--=-rynnlioEf1Njt+fikvbs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, 

Upgraded from kernel 2.4.26 to 2.4.31 and got problems with SATA SIL
controller.

This is the patch that fixes the problem (kernel VM access violation,
ksymoops output and this patch also attached):

========================================================================
--- linux-2.4.31/drivers/scsi/sata_sil.c        2005-06-01
04:56:56.000000000 +0400
+++ linux-2.4.31-lml/drivers/scsi/sata_sil.c    2005-08-16
00:27:43.000000000 +0400
@@ -427,7 +427,7 @@
                writeb(cls, mmio_base + SIL_FIFO_R0);
                writeb(cls, mmio_base + SIL_FIFO_W0);
                writeb(cls, mmio_base + SIL_FIFO_R1);
-               writeb(cls, mmio_base + SIL_FIFO_W2);
+               writeb(cls, mmio_base + SIL_FIFO_W1);
        } else
                printk(KERN_WARNING DRV_NAME "(%s): cache line size not
set.  Driver may not function\n",
                        pci_name(pdev));
=========================================================================

I don't understand too much about the mechanics of this driver, but it
seems that symmetry is violated by sequence R0,W0,R1,W2
After replacing it with R0,W0,R1,W1 I got the driver working so far.

This is my lspci for the card:

00:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112
SATARaid Controller (rev 01)

Thank you,

-- 
V.L.
--
Linux Media Labs
vleo@linuxmedialabs.com http://linuxmedialabs.com

--=-rynnlioEf1Njt+fikvbs
Content-Disposition: attachment; filename=kernel_2.4.31_sata_sil.ksymoops
Content-Type: text/plain; name=kernel_2.4.31_sata_sil.ksymoops; charset=KOI8-R
Content-Transfer-Encoding: 7bit

ksymoops 2.4.4 on i686 2.4.31smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.31smp/ (default)
     -m /boot/System.map-2.4.31smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address d882b041
d8825672
*pde = 014f2067
Oops: 0002
CPU:    1
EIP:    0010:[<d8825672>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: d882b041   ebx: 00000002   ecx: 00000008   edx: 00000000
esi: 00000002   edi: d49ef478   ebp: c554bea8   esp: c554be84
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 18207, stackpage=c554b000)
Stack: d882b041 d8825982 000001ae c02b41e0 d882ae00 d49ef400 d88260c0 d88261a0 
       d7fe3800 c554bec8 c01f1ff4 d7fe3800 d88260c0 00000000 d7fe3800 d88261a0 
       00000000 c554bee4 c01f209c d88261a0 d7fe3800 ffffffea 00000002 00000002 
Call Trace:    [<d8825982>] [<d88260c0>] [<d88261a0>] [<c01f1ff4>] [<d88260c0>]
  [<d88261a0>] [<c01f209c>] [<d88261a0>] [<d8825825>] [<d88261a0>] [<c01229b9>]
  [<d8825060>] [<d8825060>] [<d8825c68>] [<d8825060>] [<d8825c80>] [<c0126f22>]
  [<d8825060>] [<c01095f7>]
Code: 88 18 8b 4d 0c 83 79 18 01 0f 84 cd 00 00 00 bf 00 00 c0 00 

>>EIP; d8825672 <[sata_sil]sil_init_one+2c2/460>   <=====
Trace; d8825982 <[sata_sil].text.end+c9/107>
Trace; d88260c0 <[sata_sil]sil_pci_tbl+0/0>
Trace; d88261a0 <[sata_sil]sil_pci_driver+0/40>
Trace; c01f1ff4 <pci_announce_device+34/70>
Trace; d88260c0 <[sata_sil]sil_pci_tbl+0/0>
Trace; d88261a0 <[sata_sil]sil_pci_driver+0/40>
Trace; c01f209c <pci_register_driver+6c/70>
Trace; d88261a0 <[sata_sil]sil_pci_driver+0/40>
Trace; d8825825 <[sata_sil]sil_init+15/80>
Trace; d88261a0 <[sata_sil]sil_pci_driver+0/40>
Trace; c01229b9 <sys_init_module+6c9/840>
Trace; d8825060 <[sata_sil]sil_get_device_cache_line+0/30>
Trace; d8825060 <[sata_sil]sil_get_device_cache_line+0/30>
Trace; d8825c68 <[sata_sil].rodata.end+1a5/5fd>
Trace; d8825060 <[sata_sil]sil_get_device_cache_line+0/30>
Trace; d8825c80 <[sata_sil].rodata.end+1bd/5fd>
Trace; c0126f22 <bh_action+82/e0>
Trace; d8825060 <[sata_sil]sil_get_device_cache_line+0/30>
Trace; c01095f7 <system_call+33/38>
Code;  d8825672 <[sata_sil]sil_init_one+2c2/460>
00000000 <_EIP>:
Code;  d8825672 <[sata_sil]sil_init_one+2c2/460>   <=====
   0:   88 18                     mov    %bl,(%eax)   <=====
Code;  d8825674 <[sata_sil]sil_init_one+2c4/460>
   2:   8b 4d 0c                  mov    0xc(%ebp),%ecx
Code;  d8825677 <[sata_sil]sil_init_one+2c7/460>
   5:   83 79 18 01               cmpl   $0x1,0x18(%ecx)
Code;  d882567b <[sata_sil]sil_init_one+2cb/460>
   9:   0f 84 cd 00 00 00         je     dc <_EIP+0xdc>
Code;  d8825681 <[sata_sil]sil_init_one+2d1/460>
   f:   bf 00 00 c0 00            mov    $0xc00000,%edi


1 warning issued.  Results may not be reliable.

--=-rynnlioEf1Njt+fikvbs
Content-Disposition: attachment; filename=linux-2.4.31-sata_sil-patch
Content-Type: text/plain; name=linux-2.4.31-sata_sil-patch; charset=KOI8-R
Content-Transfer-Encoding: 7bit

--- linux-2.4.31/drivers/scsi/sata_sil.c        2005-06-01 04:56:56.000000000 +0400
+++ linux-2.4.31-lml/drivers/scsi/sata_sil.c    2005-08-16 00:27:43.000000000 +0400
@@ -427,7 +427,7 @@
                writeb(cls, mmio_base + SIL_FIFO_R0);
                writeb(cls, mmio_base + SIL_FIFO_W0);
                writeb(cls, mmio_base + SIL_FIFO_R1);
-               writeb(cls, mmio_base + SIL_FIFO_W2);
+               writeb(cls, mmio_base + SIL_FIFO_W1);
        } else
                printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
                        pci_name(pdev));


--=-rynnlioEf1Njt+fikvbs--

