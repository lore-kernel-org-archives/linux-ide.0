From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: WIN_READ_NATIVE_MAX_EXT returns incomplete result
Date: Tue, 16 Nov 2004 19:29:31 +0100
Message-ID: <58cb370e04111610291be130b4@mail.gmail.com>
References: <20041116173444.GA27676@palantir8>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:37869 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262088AbUKPS3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Nov 2004 13:29:32 -0500
Received: by wproxy.gmail.com with SMTP id 58so597472wri
        for <linux-ide@vger.kernel.org>; Tue, 16 Nov 2004 10:29:32 -0800 (PST)
In-Reply-To: <20041116173444.GA27676@palantir8>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Habets <errandir_news@mph.eclipse.co.uk>
Cc: linux-ide@vger.kernel.org

Hi,

On Tue, 16 Nov 2004 17:34:44 +0000, Martin Habets
<errandir_news@mph.eclipse.co.uk> wrote:
> Hi,
> 
> I've been trying to get "Host Protected Area" to work with my 80GB
> Samsung SP0802N, as I have an old BIOS.
> The max LBA capacity is 156368016 sectors (0x951FC90), but I've set
> that to 66055248 with the setmax utility. Without this, or a 32GB clip,
> I never get past the BIOS.
> 
> Initially idedisk_check_hpa() failed to detect the difference. It
> turned out that idedisk_read_native_max_address_ext() returns
> 0x51FC90, i.e. the first '9' is missing!
> 
> When I use idedisk_read_native_max_address() it returns the right
> number.
> But I'm at a loss why the _ext() version does not work.
> 
> I'm on kernel 2.6.8 and in my BIOS I have 16383/16/63 for the disk.
> My IDE controller:
> 0000:00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev 20)
> 
> Attached are parts of dmesg output, which includes some printk's I
> put in. The "hob ..." lines come from this code in
> idedisk_read_native_max_address_ext():
>                 printk(KERN_INFO "%s: max_address_ext: high=0x%x low=0x%x\n",
>                                         drive->name, high, low);
>                 for(i=0;i<IDE_NR_PORTS;i++) {
>                         printk(KERN_INFO "hob %d: 0x%x, tf %d: 0x%x\n",
>                                          i, args.hobRegister[i],
>                                          i, args.tfRegister[i]);
>                 }
> 
> The 2nd attachment is dmesg output with a hack to use the non-lba48 code,
> which works ok.
> 
> Any clues?

In kernel 2.6.8 LBA48 support is disabled for ALi chipsets with revisions
<= 0xC4 (drive->addressing is set to zero) but idedisk_check_hpa()
incorrectly uses drive->id directly which results in this bug (because
do_rw_taskfile() and ide_end_drive_cmd() rely on drive->addressing).

This patch should fix it:

--- ide-disk.c.orig	2004-11-05 23:24:41.000000000 +0100
+++ ide-disk.c	2004-11-16 19:24:17.321273832 +0100
@@ -625,7 +625,7 @@
 static inline void idedisk_check_hpa(ide_drive_t *drive)
 {
 	unsigned long long capacity, set_max;
-	int lba48 = idedisk_supports_lba48(drive->id);
+	unsigned int lba48 = drive->addressing;
 
 	capacity = drive->capacity64;
 	if (lba48)

Moreover you shouldn't hit this bug in current kernels because they
use LBA48 (with some limitations: no DMA for LBA48 area) for ALi
chipsets revs <= 0xC4.

Bartlomiej
