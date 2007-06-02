From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22-rc3 hibernate(?) disables SMART on ide
Date: Sat, 02 Jun 2007 18:45:55 +0900
Message-ID: <46613C53.8010205@gmail.com>
References: <46609290.5030701@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:35892 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758794AbXFBLja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jun 2007 07:39:30 -0400
Received: by wa-out-1112.google.com with SMTP id j4so866376wah
        for <linux-ide@vger.kernel.org>; Sat, 02 Jun 2007 04:39:30 -0700 (PDT)
In-Reply-To: <46609290.5030701@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, IDE Linux <linux-ide@vger.kernel.org>, ballen@gravity.phys.uwm.edu

David Greaves wrote:
> I have 2 ide disks. If I enable SMART and hibernate/suspend2disk, SMART is
> disabled when I resume.
> 
> Same as in 2.6.21.1
> 
> cu:~# smartctl -son /dev/hda
> smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF ENABLE/DISABLE COMMANDS SECTION ===
> SMART Enabled.
> 
> cu:~# /usr/net/bin/hibernate
> [poweron resume here]
> cu:~# smartctl -a /dev/hda
> smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Seagate Barracuda ATA II family
> Device Model:     ST320420A
> Serial Number:    3CL04RKY
> Firmware Version: 3.21
> User Capacity:    20,404,101,120 bytes
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   4
> ATA Standard is:  Exact ATA specification draft version not indicated
> Local Time is:    Fri Jun  1 22:37:15 2007 BST
> SMART support is: Available - device has SMART capability.
> SMART support is: Disabled
> 
> SMART Disabled. Use option -s with argument 'on' to enable it.

According to the ATA standard, the device (drive) itself is responsible
for preserving SMART enabled status over power cycles.  It seems your
drive doesn't wanna do that.  I don't think mangling with SMART setup in
the kernel is wise thing to do.  Bruce, any ideas?  Maybe hook smartd
such that it gets suspend/resume events?

Thanks.

-- 
tejun

