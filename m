From: "Nicklas Bondesson" <nicke@nicke.nu>
Subject: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 11:41:47 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <S265746AbTL3Klr/20031230104147Z+18382@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:896 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S265746AbTL3Klr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2003 05:41:47 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

I think i'm getting really bad values from my disks. It's two Western
Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected to a
Promise TX2000 (PDC20271) card (RAID1 using ataraid).

The disks are setup with hdparm at boot time:

/sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda
/sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hdc

When running hdparm -tT I get the following:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
 Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
 Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec

Are these normal values? I don't think so. Please advise.

/Nicke

