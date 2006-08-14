From: Eric Windisch <eric@grokthis.net>
Subject: Libata-tj-stable patch /w sil3124 and PMP... 'device or resource
 busy'
Date: Mon, 14 Aug 2006 19:22:15 -0400
Message-ID: <44E105A7.3030900@grokthis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from marley.grokthis.net ([69.93.78.26]:6827 "EHLO
	marley.grokthis.net") by vger.kernel.org with ESMTP id S965059AbWHNXXj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Aug 2006 19:23:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

First, I should note that I've attempted to use the latest 
libata-tj-stable patch, against 2.6.17.4 and 2.6.17.7 (it patched 
cleanly), and I've tried 2.6.18-rc3.  All three have given me either the 
same, or a worse result.  My controller is a sil3124, I have 5 sata 
drives, and I'm using a couple sil 3726 PMPs (to support a potential 
maximum of 12 drives with my Norco 1220 disk array).

Regarding the behavior, while I can see all 5 disks, and even partition 
them (iirc, parted worked, but fdisk didn't), and see my created 
partitions, when attempting to use 'mdadm --create', I get the error:  
"Device or resource busy".   mkfs.ext3 gives a similar error as well.  
The disks are not mounted or otherwise being accessed (such as via 
software raid or lvm).

Please Cc my address on any replies,

Thank you.
