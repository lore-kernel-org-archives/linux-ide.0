From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_via: magic vt6421 fix for transmission
 problems w/ WD drives
Date: Wed, 02 Jun 2010 13:51:07 -0400
Message-ID: <4C069A0B.6030504@garzik.org>
References: <4C03C728.9080107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.211.179]:50881 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab0FBRvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2010 13:51:12 -0400
Received: by ywh9 with SMTP id 9so5331413ywh.17
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2010 10:51:09 -0700 (PDT)
In-Reply-To: <4C03C728.9080107@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, JosephChan@via.com.tw, sjorrit@gmail.com, stable@kernel.org

On 05/31/2010 10:26 AM, Tejun Heo wrote:
> vt6421 has problems talking to recent WD drives.  It causes a lot of
> transmission errors while high bandwidth transfer as reported in the
> following bugzilla entry.
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=15173
>
> Joseph Chan provided the following fix.  I don't have any idea what it
> does but I can verify the issue is gone with the patch applied.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Originally-from: Joseph Chan<JosephChan@via.com.tw>
> Reported-by: Jorrit Tijben<sjorrit@gmail.com>
> Cc: stable@kernel.org
> ---
> Joseph, can you please add some documentation of what it does and why?
>
> Thanks.
>
>   drivers/ata/sata_via.c |   13 +++++++++++++
>   1 file changed, 13 insertions(+)

applied


