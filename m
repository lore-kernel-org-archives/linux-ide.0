From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: promise tx2650 + ss1600 + dmraid
Date: Wed, 8 Dec 2010 15:43:48 +0100
Message-ID: <20101208144348.GA28274@frolo.macqel>
References: <20101208102113.GA9588@frolo.macqel> <19711.33361.541394.839427@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:6802 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752959Ab0LHOny (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2010 09:43:54 -0500
Content-Disposition: inline
In-Reply-To: <19711.33361.541394.839427@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: ataraid-list@redhat.com, linux-ide@vger.kernel.org

Hi Mikael,

CCing ataraid-list@redhat.com. 

On Wed, Dec 08, 2010 at 02:04:17PM +0100, Mikael Pettersson wrote:
> Philippe De Muyter writes:
>  > Hello Mikael and list,
>  > 
>  > I am currently fighting with a Promise tx2650 raid controller + SuperSwap 1600
>  > SATA-I/II enclosure on a linux 2.6.34.7 (opensuse 11.3) installation.
>  > 
>  > The installation seems to have detected a raid array :
>  > 
>  > 	# cat /proc/partitions
>  > 	major minor  #blocks  name
>  > 
>  > 	   8        0  244198584 sda
>  > 	   8        1          1 sda1
>  > 	   8        5     144585 sda5
>  > 	   8        6    4190208 sda6
>  > 	   8        7  238813184 sda7
>  > 	   8       16  244198584 sdb
>  > 	   8       17          1 sdb1
>  > 	   8       21     144585 sdb5
>  > 	   8       22    4190208 sdb6
>  > 	   8       23  238813184 sdb7
>  > 	 253        0  243164048 dm-0
>  > 	 253        1  243162112 dm-1
>  > 	 253        2     144585 dm-2
>  > 	 253        3    4190208 dm-3
>  > 	 253        4  238813184 dm-4
>  > 	# mount
>  > 	/dev/mapper/pdc_beaidahccb_part7 on / type ext4 (rw,acl,user_xattr)
>  > 	proc on /proc type proc (rw)
>  > 	sysfs on /sys type sysfs (rw)
>  > 	debugfs on /sys/kernel/debug type debugfs (rw)
>  > 	devtmpfs on /dev type devtmpfs (rw,mode=0755)
>  > 	tmpfs on /dev/shm type tmpfs (rw,mode=1777)
>  > 	devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
>  > 	/dev/mapper/pdc_beaidahccb_part5 on /boot type ext4 (rw,acl,user_xattr)
>  > 	securityfs on /sys/kernel/security type securityfs (rw)
>  > 
>  > but I do not know how to see that it works.
>  > 
>  > Also the leds on the enclosure do not show activity or raid status.
>  > 
>  > I also wonder why the sata_promise driver is not used (not listed by lsmod)
> 
> Because the PDC42819 is a completely different controller than
> those driven by sata_promise.  We know that it's AHCI-like, but
> we don't have documentation or reference driver source, so it's
> basically unsupported.

OK :(

> 
>  > lspci says :
>  > 	# lspci -v -s 02:00.0
>  > 	02:00.0 RAID bus controller: Promise Technology, Inc. PDC42819 [FastTrak TX2650/TX4650]
>  > 		Subsystem: Promise Technology, Inc. Device 3f21
>  > 		Flags: bus master, fast devsel, latency 0, IRQ 17
>  > 		I/O ports at cc00 [size=128]
>  > 		I/O ports at c800 [size=256]
>  > 		Memory at fbcff000 (32-bit, non-prefetchable) [size=4K]
>  > 		Memory at fbcc0000 (32-bit, non-prefetchable) [size=128K]
>  > 		Memory at fbcfc000 (32-bit, non-prefetchable) [size=8K]
>  > 		Expansion ROM at fbc80000 [disabled] [size=256K]
>  > 		Capabilities: [50] Power Management version 2
>  > 		Capabilities: [70] Express Legacy Endpoint, MSI 00
>  > 		Capabilities: [94] SATA HBA v1.0
>  > 		Capabilities: [100] Advanced Error Reporting
>  > 		Capabilities: [140] Virtual Channel
>  > 		Capabilities: [160] Device Serial Number 00-00-00-02-00-00-00-01
>  > 		Capabilities: [170] Power Budgeting <?>
>  > 		Kernel driver in use: ahci
>  > 	# lspci -n -s 02:00.0
>  > 	02:00.0 0104: 105a:3f20

I also made some experiments with dmraid :

	tmp219:~ # dmraid -s
	*** Active Set
	name   : pdc_beaidahccb
	size   : 486328096
	stride : 32
	type   : mirror
	status : ok
	subsets: 0
	devs   : 2
	spares : 0
	tmp219:~


after that, I disconnected /dev/sdb, got messages in dmesg :

	[ 1802.706653] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xe frozen
	[ 1802.706656] ata7: irq_stat 0x00000040, connection status changed
	[ 1802.706658] ata7: SError: { PHYRdyChg CommWake DevExch }
	[ 1802.706663] ata7: hard resetting link
	[ 1810.365051] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

and dmraid now says that my raid array is inconsistent

	ERROR: pdc: wrong # of devices in RAID set "pdc_beaidahccb" [1/2] on /dev/sda
	ERROR: pdc: wrong # of devices in RAID set "pdc_beaidahccb" [1/2] on /dev/sda
	*** *Inconsistent* Active Set
	name   : pdc_beaidahccb
	size   : 486328096
	stride : 32
	type   : mirror
	status : inconsistent
	subsets: 0
	devs   : 1
	spares : 0
	tmp219:~ #

I wrote many files to the disk (that took several minutes) and then
reconnected /dev/sdb.  I did not see any disk activity, but after some
seconds dmraid again showed status as ok;  that cannot be true because
simply copying the files I had just added to the 'master' disk would
have lasted for about ten minutes.

Trying to force a rebuild with dmraid -R pdc_beaidahccb /dev/sdb failed
with :
	tmp219:~ # dmraid -R pdc_beaidahccb /dev/sdb
	Volume "pdc_beaidahccb" is not in rebuild state (current: 16)
	Rebuild: cannot rebuild from current state!

	tmp219:~ #

Does someone know how to use dmraid to effectively have rebuild
functionality ?

Philippe

-- 
Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
