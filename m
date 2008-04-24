From: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH #upstream-fixes] sata_sis: SCR accessors should return
 -EINVAL when the requested SCR isn't available
Date: Thu, 24 Apr 2008 05:30:51 +0200
Message-ID: <480FFEEB.2060705@trash.net>
References: <480FE7EC.4030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stinky.trash.net ([213.144.137.162]:55420 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbYDXDaq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 23:30:46 -0400
In-Reply-To: <480FE7EC.4030002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> sis_scr_cfg_read() can't access SError and was incorrectly returning
> -1 instead of -EINVAL.  This went unnoticed because SError used to be
> cleared in @postreset() and it didn't care about how scr_read() failed
> but commit ac371987 moved SError clearing into sata_link_resume() and
> SCR access failure other than -EINVAL is considered an error condition
> and exposes the incorrect return value bug as detection failure.  Fix
> it.
> 
> Also, scsi_scr_cfg_write() was incorrectly returning 0 after it
> ignored the request to write to SError.  Make it also return -EINVAL.
> 
> This was bisected and reported by Patrick McHardy.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Patrick McHardy <kaber@trash.net>


Tested and works fine, thanks Tejun.
