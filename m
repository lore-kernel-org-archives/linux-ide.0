From: Tejun Heo <tj@kernel.org>
Subject: Re: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled,
 CD-ROM drive dead
Date: Thu, 25 Mar 2010 09:38:24 +0900
Message-ID: <4BAAB080.3010401@kernel.org>
References: <4B9EA02F.2070704@hardwarefreak.com> <4B9EC67A.3020201@gmail.com> <4B9ED027.30800@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46660 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab0CYHOG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Mar 2010 03:14:06 -0400
In-Reply-To: <4B9ED027.30800@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/16/2010 09:26 AM, Stan Hoeppner wrote:
> ata2.00: ATAPI: Pioneer CD-ROM ATAPI Model DR-A24X  0102, E1.02, max MWDMA2
> ata2.00: failed to set xfermode (err_mask=0x100)
> TCP cubic registered
> NET: Registered protocol family 17
> Using IPI Shortcut mode
> rtc_cmos rtc_cmos: setting system clock to 2010-03-10 20:53:54 UTC (1268254434)
> ata2.00: failed to set xfermode (err_mask=0x100)
> ata2.00: limiting speed to MWDMA2:PIO3
> ata2.00: failed to set xfermode (err_mask=0x100)

AC_ERR_OTHER on SETXFER, that's rare.  Maybe the drive needs
ATA_HORKAGE_NOSETXFER?  Can you please post boot log with ide driver?

Thanks.

-- 
tejun
