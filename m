From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: T10/04-262 ATA pass thru - patch.
Date: Wed, 29 Sep 2004 13:20:30 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040929132030.B30946@tuxdriver.com>
References: <20040928001633.A8363@florence.linkmargin.com> <415AFF27.7080906@tteng.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:55561 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S268798AbUI2Sdu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2004 14:33:50 -0400
Received: (from linville@localhost)
	by ra.tuxdriver.com (8.11.6/8.11.6) id i8THKVf31384
	for linux-ide@vger.kernel.org; Wed, 29 Sep 2004 13:20:31 -0400
Content-Disposition: inline
In-Reply-To: <415AFF27.7080906@tteng.com.br>; from luciano@tteng.com.br on Wed, Sep 29, 2004 at 03:29:59PM -0300
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, Sep 29, 2004 at 03:29:59PM -0300, Luciano A. Stertz wrote:
> 	If I understand it correctly, the kernel receives an ATA command, 
> creates a CDB, gets the ATA command from the CDB and issues it.
> 	It's a nice workaround, but user space software will still have to be 
> aware that the target device appears as SCSI but isn't in fact a SCSI 
> device... I guess that the ideal situation would be:
> 	1. The user space program sends SCSI commands to the device, without 
> even have to worry if it's really a SCSI device;
> 	2. The kernel issues equivalent ATA commands and fills in the requested 
> data.

Actually, I think you have it a little bit backwards.

Andy's patch would allow someone who knows the SCSI device is actually
an ATA device to send the device an ATA command through the SCSI
infrastructure (e.g using sg).

My patch will allow the SATA devices to accept the traditional
SMART-related ioctls (HDIO_DRIVE_CMD and HDIO_DRIVE_TASK).  The
information from those ioctls will be translated to an ATA pass-thru
SCSI command.  Andy's patch will then allow these commands to execute.

As before, the smart commands will need an option to tell them to treat
the drives like ATA drives rather than SCSI drives, but the unmodified
binaries will still work.

Does that clear things up?

John
-- 
John W. Linville
linville@tuxdriver.com
