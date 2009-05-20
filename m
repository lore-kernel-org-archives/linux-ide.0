From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] block: add function for waiting for a specific free
 tag
Date: Wed, 20 May 2009 20:55:40 +0900
Message-ID: <4A13EFBC.4010005@gmail.com>
References: <20090520065942.GD11363@kernel.dk> <20090520070104.GF11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f103.google.com ([209.85.216.103]:52582 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbZETLzn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 May 2009 07:55:43 -0400
Received: by pxi1 with SMTP id 1so85452pxi.33
        for <linux-ide@vger.kernel.org>; Wed, 20 May 2009 04:55:44 -0700 (PDT)
In-Reply-To: <20090520070104.GF11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Jens Axboe wrote:
> We need this in libata to ensure that we don't race between internal
> tag usage and the block layer usage.

Hmm... I can't think of a race condition.  Can you please elaborate
what can cause such race condition and how it can get resolved by
waiting for in-flight tag?  Currently, libata reserves a qc for EH so
there won't be any race around it (the old-EH path is broken if
invoked with commands in flight anyway, so doesn't matter).  Also, as
all failed rq's are on hold till EH finishes, if there's a race
condition around a tag, it will become a deadlock.

Thanks.

-- 
tejun
