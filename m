From: Joost Kraaijeveld <J.Kraaijeveld@Askesis.nl>
Subject: Sil 3114 with 2 disks problem
Date: Wed, 01 Mar 2006 11:50:30 +0100
Message-ID: <1141210230.7288.34.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from laudanum.demon.nl ([82.161.125.16]:21946 "EHLO
	obelix.askesis.nl") by vger.kernel.org with ESMTP id S1030185AbWCAKum
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Mar 2006 05:50:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff,

As you are listed as the maintainer of the Sil 3114 (sata_sil.c) I
direct my question to you. If you are not the right person (anymore) or
if you know better person (or place) to ask this question, I would
appreciate a pointer.

I experiencing (unworkable) performance problems after a change in my
hardware configuration.  I added a second drive (SAMSUNG SP2504C) to my
on-board Sil 3114 SATA controller). Largish I/O operations (e.g. start
applications of moderate size (Openoffice,  Mozilla, Synaptic) , running
bonnie, hdparm -t /dev/sda, copying large files) lock up my Gnome
desktop and make my music stutter (the first one being the nastiest ;-).
Running hdparm or bonnie do not show any performance problems in terms
of actual throughput (see below) but the unresponsive machine is quit
annoying. None of the perfomance problems appear if I do the same
operations on my 3Ware 9500 RAID 5 array.

Do you recognize these problems and/or do you have a sollution? If not,
could you give me an advise as to what I could do to diagnose the
probleme better? 

I have the following hard/software configuration:

Stock Debian 2.6.15-1-amd64-k8-smp kernel
 - / and swap-partion  on /dev/sda1 (sil 3114)
 - /var on /dev/sdb1 (sil 3114)
 - /home on /dev/sdc1 (3ware)

Dual Opteron Tyan 2885 board with 2 prcs (248), 4 GB
Sil 3114 on-board  SATA controler
 with 1 WDC WD2000JD-00H and 1 SAMSUNG SP2504C, no raid 
3Ware 9500S-8 RAID5 with 5  WDC WD1200SD disks

Performance hints:
WDC WD2000JD-00H
hdparm -t /dev/sda: Timing buffered disk reads:  170 MB in  3.02 seconds
=  56.28 MB/sec

SAMSUNG SP2504C
hdparm -t /dev/sda: Timing buffered disk reads:  170 MB in  3.02 seconds
=  56.28 MB/sec

3Ware 9500S-8
hdparm -t /dev/sdc: Timing buffered disk reads:  374 MB in  3.01 seconds
= 124.11 MB/sec

-- 
Groeten,

Joost Kraaijeveld
Askesis B.V.
Molukkenstraat 14
6524NB Nijmegen
tel: 024-3888063 / 06-51855277
fax: 024-3608416
e-mail: J.Kraaijeveld@Askesis.nl
web: www.askesis.nl

