From: "Nicklas Bondesson" <nicke@nicke.nu>
Subject: RE: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 22:57:23 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <S263518AbTL3V5X/20031230215723Z+18805@vger.kernel.org>
References: <Pine.LNX.4.44.0312301311530.6864-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:896 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S263518AbTL3V5X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2003 16:57:23 -0500
In-Reply-To: <Pine.LNX.4.44.0312301311530.6864-100000@coffee.psychology.mcmaster.ca>
List-Id: linux-ide@vger.kernel.org
To: 'Mark Hahn' <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

This is what a cat /proc/pci looks like (promise details): It doesn't say
anything about the latency.

Bus  0, device   9, function  0:
    RAID bus controller: Promise Technology, Inc. PDC20271 (rev 2).
      IRQ 7.
      Master Capable.  No bursts.  Min Gnt=4.Max Lat=18.
      I/O at 0xd000 [0xd007].
      I/O at 0xb800 [0xb803].
      I/O at 0xb400 [0xb407].
      I/O at 0xb000 [0xb003].
      I/O at 0xa800 [0xa80f].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe000ffff]. 

/Nicke

-----Original Message-----
From: Mark Hahn [mailto:hahn@physics.mcmaster.ca] 
Sent: den 30 december 2003 19:14
To: Nicklas Bondesson
Subject: Re: IDE-RAID Drive Performance

> The disks are setup with hdparm at boot time:

not normally necessary or desirable.

> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>  Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec

the 113 indicates that you're running on a fairly old/slow host.
as such, you cannot expect to achive the full disk bandwidth, though you can
probably do better than this by tweaking w/blockdev.
it's also worth checking your bios settings (pci latency too low?)


