From: "Nicklas Bondesson" <nicke@nicke.nu>
Subject: RE: IDE-RAID Drive Performance
Date: Wed, 31 Dec 2003 00:26:25 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <S265929AbTL3X0Z/20031230232625Z+4252@vger.kernel.org>
References: <Pine.LNX.4.44.0312301311530.6864-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:640 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S265929AbTL3X0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2003 18:26:25 -0500
In-Reply-To: <Pine.LNX.4.44.0312301311530.6864-100000@coffee.psychology.mcmaster.ca>
List-Id: linux-ide@vger.kernel.org
To: 'Willy Gardiol' <willy@gardiol.org>, 'Mark Hahn' <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

It was the PCI latency value that was wrong. It was set to 0 in the BIOS so
I have changed it now to 64. I now get the following figures! :)

hdparm:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.12 seconds =114.29 MB/sec
 Timing buffered disk reads:  64 MB in  1.53 seconds = 41.83 MB/sec

bonnie:

Version 1.02b       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
%CP
gollum         800M  4681  98 37827  76 17590  30  4888  95 39400  26 310.4
3
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
%CP
                 16   310  99 +++++ +++ 21319 100   329  99 +++++ +++  1766
96
gollum,800M,4681,98,37827,76,17590,30,4888,95,39400,26,310.4,3,16,310,99,+++
++,+++,21319,100,329,99,+++++,+++,1766,96 

Thanks for the help!

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


