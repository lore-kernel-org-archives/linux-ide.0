From: Kay Sievers <kay.sievers@vrfy.org>
Subject: ide subsystem does not create "driver" symlinks in sysfs
Date: Sat, 05 Mar 2005 15:36:55 +0100
Message-ID: <1110033415.7532.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from soundwarez.org ([217.160.171.123]:20645 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261456AbVCEOg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Mar 2005 09:36:58 -0500
Received: from dhcp-113.off.vrfy.org (c223089.adsl.hansenet.de [213.39.223.89])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id E73E2863C
	for <linux-ide@vger.kernel.org>; Sat,  5 Mar 2005 15:36:55 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The ide layer does not create the expected "driver" link at the
physical device in sysfs.

Here is the block device:
  [root@pim ~]# ls -l /sys/block/hda
  -r--r--r--   1 root root 4096 Mar  4 21:25 dev
  lrwxrwxrwx   1 root root    0 Mar  4 21:25 device -> ../../devices/pci0000:00/0000:00:1f.1/ide0/0.0

The physical device misses the "driver" link:
  [root@pim ~]# ls -l '/sys/devices/pci0000:00/0000:00:1f.1/ide0/0.0'
  lrwxrwxrwx  1 root root    0 Mar  5 14:35 block -> ../../../../../block/hda
  lrwxrwxrwx  1 root root    0 Mar  4 21:25 bus -> ../../../../../bus/ide

Also the entries below the drivers directory are missing in /sys/bus:
  [root@pim ~]# tree /sys/bus/ide/
  /sys/bus/ide
  |-- devices
  |   |-- 0.0 -> ../../../devices/pci0000:00/0000:00:1f.1/ide0/0.0
  |   `-- 1.0 -> ../../../devices/pci0000:00/0000:00:1f.1/ide1/1.0
  `-- drivers
      |-- ide-cdrom
      `-- ide-disk

Here is the example of a scsi block device, which looks as expected:
  [root@pim ~]# tree /sys/bus/scsi
  /sys/bus/scsi
  |-- devices
  |   `-- 2:0:0:0 -> ../../../devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host2/target2:0:0/2:0:0:0
  `-- drivers
      `-- sd
          `-- 2:0:0:0 -> ../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/host2/target2:0:0/2:0:0:0

It would be nice, if this can be fixed, as userspace like udev and HAL
expects these values to show up.

Thanks,
Kay

