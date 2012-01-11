From: Perry Wagle <wagle@mac.com>
Subject: Addonics 5-Port HPM-XU (USB/ESATA) port multiplier
Date: Tue, 10 Jan 2012 20:11:37 -0800
Message-ID: <6BDC5BD2-F838-49B9-A8AE-69DB0F121087@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nk11p03mm-asmtp993.mac.com ([17.158.233.224]:46745 "EHLO
	nk11p99mm-asmtpout003.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747Ab2AKFLl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jan 2012 00:11:41 -0500
Received: from tuple.ftrdhcpuser.net
 (static-50-43-56-158.bvtn.or.frontiernet.net [50.43.56.158])
 by nk11p03mm-asmtp993.mac.com
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTPSA id <0LXM00LO38ZDTU50@nk11p03mm-asmtp993.mac.com> for
 linux-ide@vger.kernel.org; Tue, 10 Jan 2012 20:11:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying to get a Addronics 5-Port HPM-XU (USB/ESATA) port multiplier to 
work on Fedora 16, and it will see only one disk on the up-to-five SATA disk 
device while in non-RAID mode.

Since my crashbox is a notebook without SATA, I tried to get USB to work 
first.  The thread on that is at:

    http://marc.info/?l=linux-usb&w=2&r=1&s=addronics&q=b

(note the misspelling of addonics).

My interpretation of what was going on there is that the second disk is
assigned a SCSI LUN of 1, but that's not handled properly.

Now I'm trying to get it to work via ESATA, and I'm having a similar experience
(before I got errors, but now nothing).  I'm assuming a similar thing is going on 
here, except that my (weak) reading  of the source has it not sending LUN's 
at all.  So the second disk isn't seen at all.

What information do you need to help me out?

Thanks!

-- Perry Wagle

