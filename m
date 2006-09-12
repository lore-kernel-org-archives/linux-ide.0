From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: libata hotplug with md, unplugging does not remove drive from md?
Date: Tue, 12 Sep 2006 15:56:28 +0200
Message-ID: <c384c5ea0609120656w478afacblcd51d2a346401d6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:38974 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030226AbWILN43 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Sep 2006 09:56:29 -0400
Received: by wr-out-0506.google.com with SMTP id i32so473812wra
        for <linux-ide@vger.kernel.org>; Tue, 12 Sep 2006 06:56:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am testing the (work-in-progress / upcoming) libata SATA hotplug and
here is my report and a question about intended behaviour.

Using mainstream 2.6.17.11 kernel patched with
libata-tj-2.6.17.4-20060710.tar.bz2 from
http://home-tj.org/files/libata-tj-stable/.

Supermicro P8SCT motherboard with Intel ICH6R, using AHCI libata driver.

In short, I use ext3 over a md RAID-5 /dev/md0 over 4 SATA drives /dev/sd[a-d]
each driven by libata ahci. I unplug, then replug the drive that is
rebuilding in RAID-5.

When I unplug that drive, /dev/sda is removed, hotplug seems to work to
the point where proc/mdstat shows the drive failed, but not removed.

Replugging shows the drive re-appearing as /dev/sde

It seems hot unplug does not remove a drive from an md array.

Is this intentional?

-- 
Leon

p.s. My much more detailed message of the above was rejected as SPAM
and is submitted to postmaster for review.
