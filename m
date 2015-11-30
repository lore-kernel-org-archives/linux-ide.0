From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sil: disable trim
Date: Mon, 30 Nov 2015 10:06:21 -0500
Message-ID: <20151130150621.GE3535@mtj.duckdns.org>
References: <alpine.LRH.2.02.1511261128250.31851@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34482 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbbK3PGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2015 10:06:24 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1511261128250.31851@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 26, 2015 at 12:00:59PM -0500, Mikulas Patocka wrote:
> When I connect an Intel SSD to SATA SIL controller (PCI ID 1095:3114), any
> TRIM command results in I/O errors being reported in the log. There is
> other similar error reported with TRIM and the SIL controller:
> https://bugs.centos.org/view.php?id=5880
> 
> Apparently the controller doesn't support TRIM commands. This patch
> disables TRIM support on the SATA SIL controller.
> 
> ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata7.00: BMDMA2 stat 0x50001
> ata7.00: failed command: DATA SET MANAGEMENT
> ata7.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag 0 dma 512 out
>          res 51/04:01:00:00:00/00:00:00:00:00/a0 Emask 0x1 (device error)
> ata7.00: status: { DRDY ERR }
> ata7.00: error: { ABRT }
> ata7.00: device reported invalid CHS sector 0
> sd 8:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> sd 8:0:0:0: [sdb] tag#0 Sense Key : Illegal Request [current] [descriptor]
> sd 8:0:0:0: [sdb] tag#0 Add. Sense: Unaligned write command
> sd 8:0:0:0: [sdb] tag#0 CDB: Write same(16) 93 08 00 00 00 00 00 21 95 88 00 20 00 00 00 00
> blk_update_request: I/O error, dev sdb, sector 2200968
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@kernel.org

Applied to libata/for-4.4-fixes.  Thanks.

-- 
tejun
