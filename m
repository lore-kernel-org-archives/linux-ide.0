From: Thomas Themel <themel@iwoars.net>
Subject: PDC202XX_OLD regression between 2.6 and 2.4
Date: Thu, 11 Mar 2004 20:01:00 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040311190100.GV19928@iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from iwoars.net ([217.160.110.113]:33029 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S261440AbUCKTBA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2004 14:01:00 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm currently trying to set up a system that contains a Promise 20267
controller, and it seems that DMA on that controller causes problems in
2.6. 

My test case consists of simply creating an empty ext3 file system and
running bonnie++ on it. In 2.4.25, this works as expected. In 2.6.3-rc4,
however, it breaks after a few seconds:

Mar 11 17:27:19 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:27:19 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:27:19 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:27:19 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:27:19 sophokles kernel: hdg: timeout waiting for DMA
Mar 11 17:27:40 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:27:40 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:27:40 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:27:40 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:27:40 sophokles kernel: hdg: timeout waiting for DMA
Mar 11 17:28:02 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:28:02 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:28:02 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:28:02 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:28:02 sophokles kernel: hdg: timeout waiting for DMA
Mar 11 17:28:22 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:28:22 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:28:22 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:28:22 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:28:22 sophokles kernel: hdg: timeout waiting for DMA

Other information:

hdparm output is slightly different between 2.4 and 2.6 (hda is an
identical drive on a vt8233a controller on the motherboard) - 

sophokles:~# diff -Nrua 2.4.25/ 2.6.4-rc3/
diff -Nrua 2.4.25/hda 2.6.4-rc3/hda
--- 2.4.25/hda  2004-03-11 19:48:29.000000000 +0100
+++ 2.6.4-rc3/hda       2004-03-11 19:52:28.000000000 +0100
@@ -6,5 +6,5 @@
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
- readahead    =  8 (on)
- geometry     = 14593/255/63, sectors = 234441648, start = 0
+ readahead    = 256 (on)
+ geometry     = 16383/255/63, sectors = 234441648, start = 0
diff -Nrua 2.4.25/hdg 2.6.4-rc3/hdg
--- 2.4.25/hdg  2004-03-11 19:48:32.000000000 +0100
+++ 2.6.4-rc3/hdg       2004-03-11 19:52:31.000000000 +0100
@@ -6,5 +6,5 @@
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
- readahead    =  8 (on)
- geometry     = 14593/255/63, sectors = 234441648, start = 0
+ readahead    = 256 (on)
+ geometry     = 16383/255/63, sectors = 234441648, start = 0

I am a bit confused by the geometry changes, but they can hardly
cause the problem since hda works nicely under 2.6.

Can I do anything to narrow this down, is there a way to get more
debugging output? 

PS: Is there an archive of this mailing list somewhere?

ciao,
-- 
[*Thomas  Themel*]  While differing widely in the various little bits we know,
[extended contact]  in our infinite ignorance we are all equal. 
[info provided in]
[*message header*]      - Karl Popper
