From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH upstream-fixes] libata: unlock HPA if device shrunk
Date: Tue, 06 Apr 2010 10:57:09 -0400
Message-ID: <4BBB4BC5.5070200@garzik.org>
References: <4BB93DD9.7030909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:52661 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab0DFPEm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2010 11:04:42 -0400
Received: by iwn35 with SMTP id 35so2270387iwn.21
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2010 08:04:42 -0700 (PDT)
In-Reply-To: <4BB93DD9.7030909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, yaa.bta@gmail.com

On 04/04/2010 09:33 PM, Tejun Heo wrote:
> Some BIOSes don't configure HPA during boot but do so while resuming.
> This causes harddrives to shrink during resume making libata detach
> and reattach them.  This can be worked around by unlocking HPA if old
> size equals native size.
>
> Add ATA_DFLAG_UNLOCK_HPA so that HPA unlocking can be controlled
> per-device and update ata_dev_revalidate() such that it sets
> ATA_DFLAG_UNLOCK_HPA and fails with -EIO when the above condition is
> detected.
>
> This patch fixes the following bug.
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=15396
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Oleksandr Yermolenko<yaa.bta@gmail.com>
> ---
>   drivers/ata/libata-core.c |   74 +++++++++++++++++++++++++++-------------------
>   include/linux/libata.h    |    1
>   2 files changed, 46 insertions(+), 29 deletions(-)

patch is bigger than I would like for #upstream-fixes... but nothing to 
be done about that...  applied, thanks


