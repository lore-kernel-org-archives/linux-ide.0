From: Eric Windisch <eric@grokthis.net>
Subject: Libata PMP patch /w sil3124... 'device or resource busy'
Date: Thu, 03 Aug 2006 18:58:16 -0400
Message-ID: <44D27F88.1070807@grokthis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from marley.grokthis.net ([69.93.78.26]:34255 "EHLO
	marley.grokthis.net") by vger.kernel.org with ESMTP
	id S1751275AbWHCW6W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Aug 2006 18:58:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

I've attempted to use the patch here, against 2.6.17.7 (it patched 
cleanly)...
  
http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2

While I can partition the disks and see my created partitions, when 
attempting to use 'mdadm --create' or mkfs.ext3, I get the error:
"Device or resource busy".

The disks are not mounted or otherwise being accessed (such as via 
software raid or lvm).  My hardware is a sil3124 controller, 5 sata 
drives, and a couple Sil 3726 PMP's (embedded in a Norco 1220 disk array).

I plan to further test against 2.6.18-rc3 and 2.6.17.4 /w patch.

Any initial suggestions before I try the other kernels?

Thank you.
