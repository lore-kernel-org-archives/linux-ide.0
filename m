From: Jens Axboe <axboe@suse.de>
Subject: Re: /dev/hda problem with samsung hd
Date: Thu, 22 May 2003 14:10:34 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030522121034.GE812@suse.de>
References: <1053605323.1135.16.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:1756 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261798AbTEVL53 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2003 07:57:29 -0400
Content-Disposition: inline
In-Reply-To: <1053605323.1135.16.camel@alice>
List-Id: linux-ide@vger.kernel.org
To: pacho baratta <pachox@evolinux.it>
Cc: linux-ide@vger.kernel.org

On Thu, May 22 2003, pacho baratta wrote:
> i'm working with a disk (samsung sv1022d) that my system cannot see. i
> have a live cd with kernel 2.4.20 and glibc-2.2.5.
> 
> now when i boot i find in dmesg:
> 
> hda samsung sv1022d my100 ata disk drive
> hda: task_no_data_intr 0x51 {DriveRady SeekComplete Error}
> hda: task_no_data_intr 0x04 {DriveStatusError}
> hda: 1 sectors (0 mb) w/480KiB Cache CHS=1240/255/63

I fixed this some time ago, the patch is in 2.4.21-rc kernels. So please
try 2.4.21-rc2 and see if it works.

-- 
Jens Axboe

