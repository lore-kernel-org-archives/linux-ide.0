From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: retry link resume if necessary
Date: Tue, 12 Jan 2010 14:38:40 -0500
Message-ID: <4B4CCFC0.2070508@garzik.org>
References: <4B4A8994.8030600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f228.google.com ([209.85.217.228]:53268 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab0ALTim (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 14:38:42 -0500
Received: by gxk28 with SMTP id 28so15939065gxk.9
        for <linux-ide@vger.kernel.org>; Tue, 12 Jan 2010 11:38:42 -0800 (PST)
In-Reply-To: <4B4A8994.8030600@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, fengxiangjun <fengxiangjun@neusoft.com>, Jim Faulkner <jfaulkne@ccs.neu.edu>, Greg KH <greg@kroah.com>

On 01/10/2010 09:14 PM, Tejun Heo wrote:
> Interestingly, when SIDPR is used in ata_piix, writes to DET in
> SControl sometimes get ignored leading to detection failure.  Update
> sata_link_resume() such that it reads back SControl after clearing DET
> and retry if it's not clear.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: fengxiangjun<fengxiangjun@neusoft.com>
> Reported-by: Jim Faulkner<jfaulkne@ccs.neu.edu>
> Cc: stable@kernel.org
> ---
> Greg, although this patch should be included in -stable release in
> time, I think it should receive some more testing in devel branch for
> at least a couple of -rc cycles as it changes very fundamental part of
> hardreset protocol.  Is there a protocol for delayed inclusion into
> -stable?  If not, I'll try to remember and ping you back after some
> time but I'm almost sure that I'm gonna forget this.  :-)
>
> Thanks.
>
>   drivers/ata/libata-core.c |   38 +++++++++++++++++++++++++++++++-------
>   include/linux/libata.h    |    3 +++
>   2 files changed, 34 insertions(+), 7 deletions(-)

applied


