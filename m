From: Chisato Yamauchi <cyamauch@plamo.linet.gr.jp>
Subject: Re: PATCH: blacklist update
Date: Sat, 25 Mar 2006 15:07:25 +0900 (JST)
Message-ID: <20060325.150725.74740567.cyamauch@plamo.linet.gr.jp>
References: <1140449118.26526.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from HKRbf196.hyogo-ip.dti.ne.jp ([210.159.251.196]:6220 "EHLO
	plamo.linet.gr.jp") by vger.kernel.org with ESMTP id S1750744AbWCYGH1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Mar 2006 01:07:27 -0500
In-Reply-To: <1140449118.26526.21.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: blacklist update
Date: Mon, 20 Feb 2006 15:25:17 +0000

> A long time after testing confirmed the SN-124 was ok Klaas Gadeyne
> discovered that early revision N001 is not.

  Hi,

  I report that the ASI ARAID99 series 1010/1500/2000 (RAID0 mode) have
a problem about UDMA.

  Although I've tried using the RAID0 mode of ARAID99 2000 
(HDD:Maxtor 6L300S0 x2) connected with Sil3112A, Sil3114, Sil3124, 
ICH2(with Marvell PATA->SATA bridge), SiS5513(with Marvell PATA->SATA
bridge) and AMD8111(with Marvell PATA->SATA bridge), since the 
beginning of February.  Howerver, NONE of DMA modes work... (The PIO4
mode is OK except AMD8111.)

  Please add the RAID0 mode of ARAID99 1010/1500/2000 to the blacklist
of liata-core.c and ide-dma.c:

*** drivers/scsi/libata-core.c._orig_   2006-03-02 07:37:27.000000000 +0900
--- drivers/scsi/libata-core.c  2006-03-23 18:58:33.000000000 +0900
***************
*** 2072,2077 ****
--- 2072,2083 ----
  }
  
  static const char * ata_dma_blacklist [] = {
+       "ASI ARAID99 2000 Striping Rev:1.20",
+       "ASI ARAID99 2000 Striping Rev:1.10",
+       "ASI ARAID99 1500 Striping Rev:1.20",
+       "ASI ARAID99 1500 Striping Rev:1.10",
+       "ASI ARAID99 1010 Striping Rev:1.20",
+       "ASI ARAID99 1010 Striping Rev:1.10",
        "WDC AC11000H",
        "WDC AC22100H",
        "WDC AC32500H",
*** drivers/ide/ide-dma.c._orig_        2006-03-23 18:04:44.000000000 +0900
--- drivers/ide/ide-dma.c       2006-03-23 18:58:22.000000000 +0900
***************
*** 101,106 ****
--- 101,112 ----
  
  static const struct drive_list_entry drive_blacklist [] = {
  
+       { "ASI ARAID99 2000 Striping Rev:1.20", "ALL"   },
+       { "ASI ARAID99 2000 Striping Rev:1.10", "ALL"   },
+       { "ASI ARAID99 1500 Striping Rev:1.20", "ALL"   },
+       { "ASI ARAID99 1500 Striping Rev:1.10", "ALL"   },
+       { "ASI ARAID99 1010 Striping Rev:1.20", "ALL"   },
+       { "ASI ARAID99 1010 Striping Rev:1.10", "ALL"   },
        { "WDC AC11000H"        ,       "ALL"           },
        { "WDC AC22100H"        ,       "ALL"           },
        { "WDC AC32500H"        ,       "ALL"           },


  Note that the ARAID99 series(1010,1500,2000) have a common
firmware, so all ARAID99 models must have this UDMA problem.
By the way, the RAID1 mode of ARAID99 has NO PROBLEM about UDMA.
The string of RAID1 mode is something like:

  ASI ARAID99 2000 Mirror Rev x.xx

That is, the RAID1 modes are NOT blacklisted in above patch.

==  Chisato Yamauchi  =================================
