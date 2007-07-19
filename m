From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Wed, 18 Jul 2007 23:23:19 -0300
Message-ID: <ohu2n4-lcf.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41922 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758248AbXGSCZs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jul 2007 22:25:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBLi5-0008J7-M3
	for linux-ide@vger.kernel.org; Thu, 19 Jul 2007 04:25:45 +0200
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 04:25:45 +0200
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 04:25:45 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Linux 2.6.22
Intel(R) Celeron(R) CPU 2.26GHz
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
Reiserfs3

	I have 2 PATA HDs and they always worked perfectly with
software (kernel) raid1 using the old IDE kernel drivers. Now I use
the new libata drivers (VIA), and it keep giving those erros messages:

attempt to access beyond end of device
md1: rw=0, want=155284112, limit=155284096

	Is it raid's fault? Or libata's fault? The raid1 is ok:

/dev/md1:
        Version : 00.90.03
  Creation Time : Wed Jul 11 03:38:05 2007
     Raid Level : raid1
     Array Size : 77642048 (74.05 GiB 79.51 GB)
  Used Dev Size : 77642048 (74.05 GiB 79.51 GB)
   Raid Devices : 2
  Total Devices : 2
Preferred Minor : 1
    Persistence : Superblock is persistent

    Update Time : Wed Jul 18 23:22:24 2007
          State : clean
 Active Devices : 2
Working Devices : 2
 Failed Devices : 0
  Spare Devices : 0

           UUID : 6aed7615:3574770f:268e26d7:19872c99
         Events : 0.29260

    Number   Major   Minor   RaidDevice State
       0       8        2        0      active sync   /dev/sda2
       1       8       18        1      active sync   /dev/sdb2

-- 
Linux 2.6.22: Holy Dancing Manatees, Batman!
http://www.lastfm.pt/user/danielfraga
http://u-br.net
The Pointer Sisters - "Automatic" (Platinum & Gold Collection Series)

