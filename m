From: Philippe De Muyter <phdm@macqel.be>
Subject: promise tx2650 + ss1600 support
Date: Wed, 8 Dec 2010 11:21:13 +0100
Message-ID: <20101208102113.GA9588@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:47699 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841Ab0LHKaK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2010 05:30:10 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mikpe@it.uu.se, linux-ide@vger.kernel.org

Hello Mikael and list,

I am currently fighting with a Promise tx2650 raid controller + SuperSwap 1600
SATA-I/II enclosure on a linux 2.6.34.7 (opensuse 11.3) installation.

The installation seems to have detected a raid array :

	# cat /proc/partitions
	major minor  #blocks  name

	   8        0  244198584 sda
	   8        1          1 sda1
	   8        5     144585 sda5
	   8        6    4190208 sda6
	   8        7  238813184 sda7
	   8       16  244198584 sdb
	   8       17          1 sdb1
	   8       21     144585 sdb5
	   8       22    4190208 sdb6
	   8       23  238813184 sdb7
	 253        0  243164048 dm-0
	 253        1  243162112 dm-1
	 253        2     144585 dm-2
	 253        3    4190208 dm-3
	 253        4  238813184 dm-4
	# mount
	/dev/mapper/pdc_beaidahccb_part7 on / type ext4 (rw,acl,user_xattr)
	proc on /proc type proc (rw)
	sysfs on /sys type sysfs (rw)
	debugfs on /sys/kernel/debug type debugfs (rw)
	devtmpfs on /dev type devtmpfs (rw,mode=0755)
	tmpfs on /dev/shm type tmpfs (rw,mode=1777)
	devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
	/dev/mapper/pdc_beaidahccb_part5 on /boot type ext4 (rw,acl,user_xattr)
	securityfs on /sys/kernel/security type securityfs (rw)

but I do not know how to see that it works.

Also the leds on the enclosure do not show activity or raid status.

I also wonder why the sata_promise driver is not used (not listed by lsmod)

lspci says :
	# lspci -v -s 02:00.0
	02:00.0 RAID bus controller: Promise Technology, Inc. PDC42819 [FastTrak TX2650/TX4650]
		Subsystem: Promise Technology, Inc. Device 3f21
		Flags: bus master, fast devsel, latency 0, IRQ 17
		I/O ports at cc00 [size=128]
		I/O ports at c800 [size=256]
		Memory at fbcff000 (32-bit, non-prefetchable) [size=4K]
		Memory at fbcc0000 (32-bit, non-prefetchable) [size=128K]
		Memory at fbcfc000 (32-bit, non-prefetchable) [size=8K]
		Expansion ROM at fbc80000 [disabled] [size=256K]
		Capabilities: [50] Power Management version 2
		Capabilities: [70] Express Legacy Endpoint, MSI 00
		Capabilities: [94] SATA HBA v1.0
		Capabilities: [100] Advanced Error Reporting
		Capabilities: [140] Virtual Channel
		Capabilities: [160] Device Serial Number 00-00-00-02-00-00-00-01
		Capabilities: [170] Power Budgeting <?>
		Kernel driver in use: ahci
	# lspci -n -s 02:00.0
	02:00.0 0104: 105a:3f20

Any suggestion ?

Thanks in advance

Philippe

-- 
Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
