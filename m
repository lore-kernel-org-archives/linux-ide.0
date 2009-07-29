From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH upstream] libata: remove spindown skipping and warning
Date: Tue, 28 Jul 2009 21:17:15 -0400
Message-ID: <4A6FA31B.9080905@garzik.org>
References: <4A4D70F4.5010909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60157 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbZG2BRT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:17:19 -0400
In-Reply-To: <4A4D70F4.5010909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, jaswinder@kernel.org

Tejun Heo wrote:
> This was a hack to give userland shutdown tools time to drop manual
> spindown.  All popular distros updated quite some time ago and the due
> is well passed.  Drop it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>
> ---
>  Documentation/feature-removal-schedule.txt |   18 ----------
>  drivers/ata/libata-scsi.c                  |   51 -----------------------------
>  include/linux/libata.h                     |    1 
>  3 files changed, 70 deletions(-)

applied - yay!


