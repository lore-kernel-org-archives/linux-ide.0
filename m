From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Another project for you... :)
Date: Fri, 9 Jun 2006 18:29:33 -0400
Message-ID: <87f94c370606091529q2cb2a197v96ef95c3e4b55643@mail.gmail.com>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
	 <44883BAE.7070406@pobox.com>
	 <1149820043.5721.7.camel@forrest26.sh.intel.com>
	 <4488E6F6.10306@pobox.com>
	 <1149822824.5721.16.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:51475 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751412AbWFIW3e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 18:29:34 -0400
Received: by wx-out-0102.google.com with SMTP id h28so568204wxd
        for <linux-ide@vger.kernel.org>; Fri, 09 Jun 2006 15:29:34 -0700 (PDT)
In-Reply-To: <1149822824.5721.16.camel@forrest26.sh.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, htejun@gmail.com, linux-ide@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>

> > Also, a feature Alan requests on occasion:  Call the ATA "set max"
> > command to fully address the hard drive, including HPA.  The Linux
> > standard is to export the raw hardware directly, making 100% of the
> > hardware capability available to the user (and, in this case,
> > Linux-based BIOS and recovery tools).
>
> I'll first study what this means, then start to work on it.
>
> Best wishes,
> Forrest

The below relates to PATA and HPA (Host Protected Area), but I assume
it would be relevant to SATA as well.

====
This has been discussed before in the archives.  I think the desired
behavior was to have the Linux Kernel look for HPAs by default and to
open the drive up to the full size via "set max" on boot, but to have
a boot parameter to disable this behavior if desired.

FYI: There is a userland tool called setmax floating around.  (I can
find if you're interested.)  The userland tool works fine for LBA28
drives, but does not have LBA48 support.  That may get to be an issue,
but at least from my perspective, I have not yet seen any 128+ GiB
drives with HPAs setup.  I do occasionally see smaller drives with
HPAs.

FYI2: I do computer forensics and make dd images of drives routinely.
As part of the process I double check if a HPA is present or not.  I
typically use the userland setmax tool to open it up if the linux
kernel failed to do so on bootup for some reason.  (I've only seen
that a few times so far.)

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
