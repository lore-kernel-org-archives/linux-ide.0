From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 15:20:06 -0800 (PST)
Message-ID: <20081109232006.5E0AD108056@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60308 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756413AbYKIXUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 18:20:38 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9NK68m002276
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 15:20:07 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #19 from eshaffer1@mac.com  2008-11-09 15:20 -------
Unfortunately I am uncertain how to get that output from the "irqpoll" kernel.
I tried $cat /proc/interrupts and got this output (from Live CD no?) :

ubuntu@ubuntu:~$ cat /proc/interrupts
           CPU0       
 16:         14   PMAC-PIC  Edge      MESH
 18:          1   PMAC-PIC  Edge      PMac
 19:        105   PMAC-PIC  Edge      PMac Output
 20:         95   PMAC-PIC  Edge      PMac Input
 21:          5   PMAC-PIC  Level     pcilynx
 22:          0   PMAC-PIC  Level     radeon@pci:0000:00:10.0
 25:      19152   PMAC-PIC  Level     ide2, ide3
 27:       6992   PMAC-PIC  Edge      ADB
 28:    1183341   PMAC-PIC  Level     ohci_hcd:usb1
 29:       7866   PMAC-PIC  Edge      ide0
 32:         71   PMAC-PIC  Edge      BMAC-txdma
 33:          2   PMAC-PIC  Edge      BMAC-rxdma
 42:         71   PMAC-PIC  Edge      BMAC-misc
BAD:          0

I also tried (beyond hope! :)) $cat /media/disk/proc/interrupts but receive an
error message of cat: /media/disk/proc/interrupts: no such file or directory.
Is it possible that since the "irqpoll" kernel has never completed booting this
file has not yet been written? 

Someday I will know more than just enough to be a danger to my system...until
then, I need a little more guidance on this one please. 


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
