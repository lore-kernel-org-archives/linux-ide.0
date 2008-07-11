From: "abhishek srivasatava" <getabhisheksrivastava@gmail.com>
Subject: erro in building(android_kernel)
Date: Fri, 11 Jul 2008 10:44:14 +0530
Message-ID: <ed4c39ba0807102214i55475bd7tfccead678d24dff9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:19763 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbYGKFOP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 01:14:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1845834ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jul 2008 22:14:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi
i am usng the linux-2.6.23-android-m3-rc20 kernel and  tool
chain
arm-2008q1-126-arm-none-linux-gnueabi.bin

while building the kernel i have found this error .............>

i am using  make goldfish_defconfig
 and make menuconfig and i am not copy the ".config" from the emulator
,is it necessory to copy the .config to build the kernel
i have solved that problem by applying add_pci_get_legacy_ide_irq.patch
and this patch solved that problem

now i am facing this problem--->

UPD     include/linux/compile.h
 CC      init/version.o
 LD      init/built-in.o
 LD      .tmp_vmlinux1
drivers/built-in.o: In function `nvram_ioctl':
/home/android/kernel/drivers/char/nvram.c:331: undefined reference to `rtc_lock'
drivers/built-in.o: In function `nvram_write':
/home/android/kernel/drivers/char/nvram.c:293: undefined reference to `rtc_lock'
drivers/built-in.o: In function `nvram_read':
/home/android/kernel/drivers/char/nvram.c:260: undefined reference to `rtc_lock'
drivers/built-in.o: In function `nvram_read_proc':
/home/android/kernel/drivers/char/nvram.c:403: undefined reference to `rtc_lock'
drivers/built-in.o: In function `nvram_check_checksum':
/home/android/kernel/drivers/char/nvram.c:191: undefined reference to `rtc_lock'
drivers/built-in.o:/home/android/kernel/drivers/char/nvram.c:173: more
undefined references to `rtc_lock' follow
drivers/built-in.o: In function `create_android_kdbg_endpoints':
/home/android/kernel/drivers/android/android_kernel_debug.c:668:
undefined reference to `usb_ep_autoconfig'
/home/android/kernel/drivers/android/android_kernel_debug.c:678:
undefined reference to `usb_ep_autoconfig'
make: *** [.tmp_vmlinux1] Error 1

but when i saw in include/linux/mc146818rtc.h
 it will defined extern spinlock_t rtc_lock;
shuold i chenge rtc_lock to spinlock_t rtc_lock;

or i read that use linus.patch
should i used this patch
pls help me

regards
Abhishek
