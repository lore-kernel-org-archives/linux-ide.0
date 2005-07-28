From: Polly <pollyp100@yahoo.com>
Subject: Plextor 712 sa write issue
Date: Thu, 28 Jul 2005 08:18:46 -0700 (PDT)
Message-ID: <20050728151846.17096.qmail@web34312.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web34312.mail.mud.yahoo.com ([66.163.178.144]:24159 "HELO
	web34312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261543AbVG1PSv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jul 2005 11:18:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,

I am able to read-only mount and read from my Plextor
712-SA DVD burner, but I cannot mount the drive
read-write. I wonder if anyone here might have some
suggestions about how I could solve this problem.

Here is the error message I get when I try this to

mount -t iso9660 /dev/scd0 /mnt/cdrecorder -o rw:

---
Jul 28 11:37:54 HTPC kernel: cdrom: sr0: mrw address
space DMA selected
Jul 28 11:37:54 HTPC kernel: attempt to access beyond
end of device
Jul 28 11:37:54 HTPC kernel: sr0: rw=0, want=68,
limit=4
Jul 28 11:37:54 HTPC kernel: isofs_fill_super: bread
failed, dev=sr0, iso_blknum=16, block=16
---

I am running under 2.6.12.3, with ATA_ENABLE_ATAPI and
ATA_ENABLE_PATA in libata.h turned on. My motherboard
is an Intel 915G, with a Intel 82801 FW/FB (ICH6) Sata
controller. 

I see that there are a variety of branches out there
for SATA. Should I try any of them? Or can you
suggest any other strategy for solving this problem?

Also: Is this a known issue? Should I open a bug
report in Bugzilla on this? 

I'm pretty ignorant about the workings of SATA, so I
can't be much help with coding. But if a developer
would like to try out some fixes on my configuration,
I'd be happy work with him or her to do the testing.

Thanks in advance for your help,

-Polly


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
