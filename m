From: Tejun Heo <htejun@gmail.com>
Subject: Re: JMicron JMB363 issue fixed / ICH8 RAID volume trace
Date: Thu, 24 May 2007 11:48:44 +0200
Message-ID: <46555F7C.4000804@gmail.com>
References: <76366b180705231843i19f88582xaf22ba0d58313feb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:57548 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbXEXJtA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 05:49:00 -0400
Received: by nz-out-0506.google.com with SMTP id o37so562872nzf
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 02:49:00 -0700 (PDT)
In-Reply-To: <76366b180705231843i19f88582xaf22ba0d58313feb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: "ethanhsiao@jmicron.com" <ethanhsiao@jmicron.com>, linux-ide@vger.kernel.org

Andrew Paprocki wrote:
> Ethan, I believe my 2.6.22-rc2 kernel *is* working with respect to the
> libata problem. By removing CONFIG_IDE, the system now works fine. The
> reason why I thought that libata was still having a problem was
> because the system would hang after agpgart printed:
> "agpgart: detected an Intel 965G chipset."
> 
> I *thought* the system was once again waiting for the root drive to
> become available, but it turns out it was actually hung. I found
> another user with a Gigabyte board with the same issue. I also have
> 4GB ram.. http://lists.opensuse.org/opensuse-amd64/2007-04/msg00001.html
> 
> I added "mem=4096M" to the boot line and now everything is working
> properly. The IDE subsystem is off and libata is handling everything.
> I'll post on the kernel mailing list to see if this is a known issue
> w/ agpgart or amd64+4gb.
> 
> I do see some trace print out complaining about reads past the end of
> the device.. Does anyone have an idea if these are harmful? They are
> coming from my ICH8 RAID volumes:
> 
> sda: sda1
> sda: p1 exceeds device capacity
> sdb: unknown partition table
> sdc: sdc1
> sdc: p1 exceeds device capacity
> sdf1
> sdf: p1 exceeds device capacity
> ...
> attempt to access beyond end of device
> sda: rw=0, want=1953533832, limit=976773168
> Buffer I/O error on device sda1, logical block 244191472
> (repeats about 25 times)
> attempt to access beyond end of device
> sdf: rw=0, want=1875410824, limit=625142448
> (repeats about 25 times)
> sdc: rw=0, want=1875410824, limit=625142448
> attempt to access beyond end of device
> (repeats about 25 times)

What does 'fdisk -l' say?

-- 
tejun
