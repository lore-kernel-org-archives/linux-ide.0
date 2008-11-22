From: Gene Heskett <gene.heskett@gmail.com>
Subject: Drive failure and ASUS
Date: Sat, 22 Nov 2008 09:01:33 -0500
Message-ID: <200811220901.33596.gene.heskett@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f11.google.com ([209.85.217.11]:48331 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757968AbYKVOBj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Nov 2008 09:01:39 -0500
Received: by gxk4 with SMTP id 4so1211906gxk.13
        for <linux-ide@vger.kernel.org>; Sat, 22 Nov 2008 06:01:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings;

The only way I can get this box to boot is to disconnect the data cable on a 
drive with 121 badblocks as somehow ASUS and JMicron-pata all seem to think 
its /dev/sda when hooked up, and it is no longer bootable.  I'm presently 
booted from a sata drive on that interface, which this ASUS board has about 8 
of.

So I've booted with the data cable off, and hooked it up once booted.  Unforch 
there seems to be no discovery of its presence.

No /dev/sdd stuff was created when I plugged the data cable into the drive.

The install is the August 2008 F8 respin and is uptodate.

How can I make the system aware that it is now there?  It has about 40 Gb of 
data I'd like to recover if I can.

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Birds are entangled by their feet and men by their tongues.
