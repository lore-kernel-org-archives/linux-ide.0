From: Tejun Heo <htejun@gmail.com>
Subject: Re: Libata-tj-stable patch /w sil3124 and PMP... 'device or resource
 busy'
Date: Tue, 15 Aug 2006 21:55:26 +0900
Message-ID: <44E1C43E.1020302@gmail.com>
References: <44E105A7.3030900@grokthis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:31874 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965088AbWHOMzd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 08:55:33 -0400
Received: by nz-out-0102.google.com with SMTP id n1so566774nzf
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 05:55:33 -0700 (PDT)
In-Reply-To: <44E105A7.3030900@grokthis.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Windisch <eric@grokthis.net>
Cc: linux-ide@vger.kernel.org

Eric Windisch wrote:
> First, I should note that I've attempted to use the latest 
> libata-tj-stable patch, against 2.6.17.4 and 2.6.17.7 (it patched 
> cleanly), and I've tried 2.6.18-rc3.  All three have given me either the 
> same, or a worse result.  My controller is a sil3124, I have 5 sata 
> drives, and I'm using a couple sil 3726 PMPs (to support a potential 
> maximum of 12 drives with my Norco 1220 disk array).
> 
> Regarding the behavior, while I can see all 5 disks, and even partition 
> them (iirc, parted worked, but fdisk didn't), and see my created 
> partitions, when attempting to use 'mdadm --create', I get the error:  
> "Device or resource busy".   mkfs.ext3 gives a similar error as well.  
> The disks are not mounted or otherwise being accessed (such as via 
> software raid or lvm).

Hello, Eric.

Can you post the result of 'dmesg', 'cat /proc/mounts' and 'fuser -v 
/dev/sdX#'?

-- 
tejun
