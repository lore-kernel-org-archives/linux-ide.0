From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: increase 128 KB / cmd limit for ATAPI tape
 drives
Date: Wed, 31 Oct 2007 12:50:01 +0000
Message-ID: <20071031125001.4570f207@the-village.bc.nu>
References: <47275163.9020809@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40529 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755020AbXJaMss (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 08:48:48 -0400
In-Reply-To: <47275163.9020809@cybernetics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 30 Oct 2007 11:44:35 -0400
Tony Battersby <tonyb@cybernetics.com> wrote:

> Commands sent to ATAPI tape drives via the SCSI generic (sg) driver are
> limited in the amount of data that they can transfer by the max_sectors
> value.  The max_sectors value is currently calculated according to the
> command set for disk drives, which doesn't apply to tape drives.  The
> default max_sectors value of 256 limits ATAPI tape drive commands to
> 128 KB.  This patch against 2.6.24-rc1 increases the max_sectors value
> for tape drives to 65535, which permits tape drive commands to transfer
> just under 32 MB.

Seems reasonable to me and is valid for all ATAPI devices as far as I can
see since we use READ_10/WRITE_10 commands.

Alan
