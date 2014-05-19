From: Alan Evans <alanwevans@gmail.com>
Subject: ahci: host/target numbers change with detection order
Date: Mon, 19 May 2014 14:46:42 -0600
Message-ID: <CAMFVOoU=nbVSzZPU0eJ6Gy=yFNdWQfctANjfQyVjAp0hJFzDrA@mail.gmail.com>
Reply-To: AlanWEvans@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:48165 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbaESUqn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2014 16:46:43 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so9796856qga.14
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2014 13:46:42 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a host that is used to process the data on removable drives.
It is essential to be able to indicate to an operator which drives are
done and can be removed.

When we were using a HighPoint card that uses sata_mv.ko we could
count on the results of 'udevadm info -q path -n <dev>' representing a
single physical port on the card.

I have been testing a new card based on a Marvell 88SE9230 (ahci.ko)
and I find that the scsi host number and corresponding target are
changing depending on the order drives are attached to the system, not
based on the port number.

Further for some reason in /sys/class/scsi_host I am seeing 8 hosts
created per card where I would expect 4.

Does anyone have any thoughts on why the behaviour differs between
ahci.ko and sata_mv.ko?  Is it the chip?  The module?

$ uname -a
Linux host01 3.2.0-0.bpo.4-amd64 #1 SMP Debian 3.2.54-2~bpo60+1 x86_64 GNU/Linux

I know its an old kernel, but at the moment I cannot do much about it.

$ sudo lspci -v -s 06:00.0
06:00.0 SATA controller: Marvell Technology Group Ltd. Device 9230
(rev 10) (prog-if 01 [AHCI 1.0])
    Subsystem: Marvell Technology Group Ltd. Device 9230
    Flags: bus master, fast devsel, latency 0, IRQ 51
    I/O ports at ec00 [size=8]
    I/O ports at e880 [size=4]
    I/O ports at e800 [size=8]
    I/O ports at e480 [size=4]
    I/O ports at e400 [size=32]
    Memory at faffe000 (32-bit, non-prefetchable) [size=2K]
    Expansion ROM at fafe0000 [disabled] [size=64K]
    Capabilities: [40] Power Management version 3
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
    Capabilities: [70] Express Legacy Endpoint, MSI 00
    Capabilities: [e0] SATA HBA v0.0
    Capabilities: [100] Advanced Error Reporting
    Kernel driver in use: ahci

$ ls -ld /sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host*
drwxr-xr-x 4 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host10
drwxr-xr-x 4 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host11
drwxr-xr-x 4 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host12
drwxr-xr-x 5 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host13
drwxr-xr-x 5 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host6
drwxr-xr-x 5 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host7
drwxr-xr-x 5 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host8
drwxr-xr-x 5 root root 0 May 19 14:16
/sys/devices/pci0000:00/0000:00:09.0/0000:06:00.0/host9

--- and the HighPoint Card ---

$ sudo lspci -v -s 04:00.0
04:00.0 SCSI storage controller: HighPoint Technologies, Inc.
RocketRAID 2310 4 Port SATA-II Controller (rev 02)
    Subsystem: Marvell Technology Group Ltd. Device 11ab
    Flags: bus master, fast devsel, latency 0, IRQ 30
    Memory at fad00000 (64-bit, non-prefetchable) [size=1M]
    I/O ports at d800 [size=256]
    [virtual] Expansion ROM at fac80000 [disabled] [size=512K]
    Capabilities: [40] Power Management version 2
    Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
    Capabilities: [60] Express Legacy Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting
    Kernel driver in use: sata_mv

$ ls -ld /sys/devices/pci0000:00/0000:00:07.0/0000:04:00.0/host*
drwxr-xr-x 5 root root 0 May 19 14:40
/sys/devices/pci0000:00/0000:00:07.0/0000:04:00.0/host0
drwxr-xr-x 4 root root 0 May 19 14:42
/sys/devices/pci0000:00/0000:00:07.0/0000:04:00.0/host1
drwxr-xr-x 4 root root 0 May 19 14:42
/sys/devices/pci0000:00/0000:00:07.0/0000:04:00.0/host2
drwxr-xr-x 5 root root 0 May 19 14:42
/sys/devices/pci0000:00/0000:00:07.0/0000:04:00.0/host3

If this is a behaviour from the ahci module could someone point me in
the direction of how to alter it?  A patch to make it behave like
sata_mv?  Or is there another way to get the port number?  Some low
level scsi or ahci command I can call?

Thanks in advance,
-Alan
