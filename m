From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement no[hs]rst force params
Date: Fri, 22 Aug 2008 02:11:13 -0400
Message-ID: <48AE5881.9020806@garzik.org>
References: <48A2C32D.1090000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50842 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbYHVGLS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:11:18 -0400
In-Reply-To: <48A2C32D.1090000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, linux@sun7.cn

Tejun Heo wrote:
> Implement force params nohrst, nosrst and norst.  This is to work
> around reset related problems and ease debugging.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Dino Wu, specifying libata.force=nohrst will work around the problem
> till the problem is properly fixed.
> 
> Thanks.
> 
>  Documentation/kernel-parameters.txt |    3 ++
>  drivers/ata/libata-core.c           |   46 +++++++++++++++++++++++-------------
>  drivers/ata/libata-eh.c             |    4 +++
>  include/linux/libata.h              |    1 
>  4 files changed, 38 insertions(+), 16 deletions(-)

applied


