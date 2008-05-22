From: Tejun Heo <htejun@gmail.com>
Subject: Re: Drives not detected: sil3124 PMP to sil4726 5 drive enclosure
Date: Thu, 22 May 2008 11:25:52 +0900
Message-ID: <4834D9B0.8030902@gmail.com>
References: <48344E5D.1040301@utdallas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:20983 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbYEVCZ7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 22:25:59 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2982302rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 21 May 2008 19:25:58 -0700 (PDT)
In-Reply-To: <48344E5D.1040301@utdallas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Burchfield <rxb023100@utdallas.edu>
Cc: linux-ide@vger.kernel.org

Ryan Burchfield wrote:
> Hi all,
> I have done a bit of digging in the archives and find lots of related 
> issues but no working solutions. I don't know if this should be 
> considered a bug or not so help is appreciated.
> I have a sil3124 chipset PCI card flashed with base(non-RAID) BIOS. 
> Connected to this card I have a sil4726 chipset 5 drive enclosure with 
> up to date firmware. The enclosure has been configured using a Windows 
> machine with 2 750GB drives in RAID 1. So a host PC should see 1 logical 
> 750GB drive + configuration drive if my understanding is correct. I have 
> tried many of the latest kernels but the drives are not detected correctly.
> 
> At the moment I have just tried the latest fixes at upstream-fixes @ 
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> Attached below is a dmesg log with the above specified kernel for the 
> following action.
> 1) Boot computer
> 2) Begin recording dmesg log
> 3) Turn on sil4726 based drive enclosure
> 4) Wait for dmesg activity to settle
> 5) Stop logging
> 
> At the end of the process I have no additional disks in /dev/sd*.
> 
> Does anyone have any suggestions or any troubleshooting steps that I 
> should try? What can I do to provide more useful information?

Ah... please don't use hardware RAID mode w/ 4726.  Just use it as plain 
Port Multiplier.  Its ATA device emulation is really bad and just can't 
work with a generic driver.  We had to disable even the Config Disk 
recently to work around some detection issues.

Thanks.

-- 
tejun
