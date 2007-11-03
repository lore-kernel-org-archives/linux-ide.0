From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: increase 128 KB / cmd limit for ATAPI tape drives
Date: Sat, 03 Nov 2007 08:48:42 -0400
Message-ID: <472C6E2A.8020809@pobox.com>
References: <47275163.9020809@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35171 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbXKCMsn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:48:43 -0400
In-Reply-To: <47275163.9020809@cybernetics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: linux-ide@vger.kernel.org

Tony Battersby wrote:
> Commands sent to ATAPI tape drives via the SCSI generic (sg) driver are
> limited in the amount of data that they can transfer by the max_sectors
> value.  The max_sectors value is currently calculated according to the
> command set for disk drives, which doesn't apply to tape drives.  The
> default max_sectors value of 256 limits ATAPI tape drive commands to
> 128 KB.  This patch against 2.6.24-rc1 increases the max_sectors value
> for tape drives to 65535, which permits tape drive commands to transfer
> just under 32 MB.
> 
> Tested with a SuperMicro PDSME motherboard, AHCI, and a Sony SDX-570V
> SATA tape drive.
> 
> Note that some of the chipset drivers also set their own max_sectors
> value, which may override the value set in libata-core.  I don't have
> any of these chipsets to test, so I didn't go messing with them.  Also,
> ATAPI devices other than tape drives may benefit from similar changes,
> but I have only tape drives and disk drives to test.
> 
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>

applied


