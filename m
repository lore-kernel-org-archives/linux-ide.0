From: Jordan Neumeyer <jnengland77@gmail.com>
Subject: =?utf-8?b?cGF0YV9zaXM6?= =?utf-8?b?c2dfd3JpdGU=?= errors
Date: Mon, 15 Jan 2007 19:05:29 +0000 (UTC)
Message-ID: <loom.20070115T195130-154@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:45384 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbXAOTKZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Jan 2007 14:10:25 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H6XDX-0004GH-NT
	for linux-ide@vger.kernel.org; Mon, 15 Jan 2007 20:10:04 +0100
Received: from 209-159-211-241.bhfc.net ([209-159-211-241.bhfc.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 20:10:03 +0100
Received: from jnengland77 by 209-159-211-241.bhfc.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 15 Jan 2007 20:10:03 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Well recently I've been using libata since my my distribution offered it when
they switched to 2.6.19( maybe? 18) in the initramfs image.  I have a sis 5513
controller, which after a couple of days started acting up and coming up with
the following error:

sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing data i$;
 program grip not setting count and/or reply_len properly
printk: 319 messages suppressed.
sg_write: data in/out 30576/30576 bytes for SCSI command 0xbe--guessing data $n;
 program grip not setting count and/or reply_len properly
printk: 321 messages suppressed.
sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing data $n;
 program grip not setting count and/or reply_len properly
printk: 323 messages suppressed.
sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing data $n;
 program grip not setting count and/or reply_len properly
printk: 323 messages suppressed.
sg_write: data in/out 16464/16464 bytes for SCSI command 0xbe--guessing data $n;
 program grip not setting count and/or reply_len properly
printk: 324 messages suppressed.

It's repeated over, and over; differing amounts of bytes.  I'm unsure what
invoked such errors, because it only started to happen a few days after use of
the kernel.  Which was 2.6.19-beyond kernel.  I don't believe any additions made
by the beyond kernel affected the libata system.

Has this been fixed in the 2.6.20-rcXs?  

~Jordan Neumeyer 

