From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: use longer 0xff wait if parallel scan
 is enabled
Date: Thu, 22 Apr 2010 22:05:08 -0400
Message-ID: <4BD10054.8030102@garzik.org>
References: <4BBF058E.6080300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:49393 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab0DWCFL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 22:05:11 -0400
Received: by ywh32 with SMTP id 32so5299600ywh.33
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 19:05:11 -0700 (PDT)
In-Reply-To: <4BBF058E.6080300@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, garyhade@us.ibm.com

On 04/09/2010 06:46 AM, Tejun Heo wrote:
> There are some SATA devices which take relatively long to get out of
> 0xff status after reset.  In libata, this timeout is determined by
> ATA_TMOUT_FF_WAIT.  Quantum GoVault is the worst requring about 2s for
> reliable detection.  However, because 2s 0xff timeout can introduce
> rather long spurious delay during boot, libata has been compromising
> at the next longest timeout of 800ms for HHD424020F7SV00 iVDR drive.
>
> Now that parallel scan is in place for common drivers, libata can
> afford 2s 0xff timeout.  Use 2s 0xff timeout if parallel scan is
> enabled.
>
> Please note that the chance of spurious wait is pretty slim w/ working
> SCR access so this will only affect SATA controllers w/o SCR access
> which isn't too common these days.
>
> Please read the following thread for more information on the GoVault
> drive.
>
>    http://thread.gmane.org/gmane.linux.ide/14545/focus=14663
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Gary Hade<garyhade@us.ibm.com>
> ---
>   drivers/ata/libata-core.c |   18 ++++++++++++------
>   include/linux/libata.h    |   11 ++++++-----
>   2 files changed, 18 insertions(+), 11 deletions(-)

applied


