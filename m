From: "Nicklas Bondesson" <nicke@nicke.nu>
Subject: RE: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 22:23:44 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <S265806AbTL3VXr/20031230212455Z+18774@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:384 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S265806AbTL3VXr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2003 16:23:47 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Thanks for the info. What do you mean by "w/blockdev" and what should a
proper pci latency value bee?

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


