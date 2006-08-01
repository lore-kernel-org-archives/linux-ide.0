From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata question
Date: Wed, 02 Aug 2006 00:33:27 +0900
Message-ID: <44CF7447.300@gmail.com>
References: <1154445491.18593.111.camel@acme>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:15734 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932273AbWHAPdc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 11:33:32 -0400
Received: by py-out-1112.google.com with SMTP id t32so1233003pyc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 08:33:32 -0700 (PDT)
In-Reply-To: <1154445491.18593.111.camel@acme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Oberholtzer <roger@opq.se>
Cc: linux-ide@vger.kernel.org

Roger Oberholtzer wrote:
> Should hotplug work with Intel Corporation 82801GB/GR/GH (ICH7
> Family) chipset? I am trying kernel 2.6.17.7
> 
> I have been trying the warmplug stuff. But I am not convinced it is 
> acting as I expect. If I remove a disk and then do a scan, shouldn't
> the disk entry go away?

Eventually, yes.  Do you mind to send me the dmesg?

> I know about the problems with just removing a disk. But this is with
> one that is not mounted. I just want to see if the disks are properly
> sensed as coming and going. I am using the warmplug instructions on
> your web site.

There are some complications with piix PCS register (port 
enable/disable) which always seems to have some problem.  If you can use 
AHCI mode, it will be *much* better.

If you think the driver doesn't do the right thing(tm), please send me 
detailed info.  I'll try to fix the problem if possible or explain why 
it can't be fixed at the very least.

-- 
tejun
