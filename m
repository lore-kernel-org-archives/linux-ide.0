From: Ian Leonard <ian@smallworld.cx>
Subject: Highpoint hpt370 raid and span disks
Date: Wed, 14 Jan 2004 10:40:45 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040114104045.GU3426@dino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:42114 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265568AbUANKkr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2004 05:40:47 -0500
Received: from dino ([81.103.192.30]) by mta01-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20040114104039.KJVD5044.mta01-svc.ntlworld.com@dino>
          for <linux-ide@vger.kernel.org>; Wed, 14 Jan 2004 10:40:39 +0000
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Greetings,

I have tried to get the htpraid.o module working with spanned raid  
disks with a hpt370 chip (it is a slightly older version). I did this

1. Setup the raid in the hpt bios
2. loaded the hptraid.o module (kernel: 2.4.24)
3. fdisk /dev/ataraid/d0 and create /dev/ataraid/d0p1
I note that:
fdisk shows one partition of 80GB (which is correct because I 		 
have 2x40GB disks).
Also /proc/
4. mke2fs -j /dev/ataraid/d0p1
5. mount the partition and df shows 80GB.
6. run a test program that fills up the disk with many 1GB files. At  
about the 32nd file I see errors from ext3 and also i/0 errors ide  
controller. The error messages list the hdg device and indicate that  
they can't find sectors in the second disk.

After a reboot, the raid bios marks the 2nd disk with 'broken span'.

I see from a previous posting that spanning is supported, so I maybe  
missing something. Any help appreciated.
	
--
Ian Leonard

Please ignore spelling and punctuation - I did.
