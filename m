From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #3
Date: Thu, 14 Feb 2008 10:26:11 +0900
Message-ID: <47B398B3.40308@gmail.com>
References: <12028937731333-git-send-email-htejun@gmail.com>	<20080213155701.48871761.akpm@linux-foundation.org>	<47B38E13.1060503@gmail.com> <20080213170950.86945835.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.180]:47863 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757444AbYBNB0T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 20:26:19 -0500
Received: by el-out-1112.google.com with SMTP id v27so219734ele.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 17:26:18 -0800 (PST)
In-Reply-To: <20080213170950.86945835.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jengelh@computergmbh.de, matthew@wil.cx, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:
> On Thu, 14 Feb 2008 09:40:51 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Can you please take a look at ata_eh_link_report() in
>> drivers/ata/libata-eh.c?
> 
> I did.  Punishment?

Heh.. :-)

>>  Currently, it has some problems.
> 
> Yes, and the patches do clean that up.

Yeap, it does.

> ho hum.  What tends to happen with this sort of thing is that fi we merge
> it, it ends up getting used more often than one expected...

Hmmm... Okay.  mprintk being printk, I'm not too sure how it can go over
usual expectations but well, yeah, that actually is my expectation.

> If you stand back and squint at it, there are quite a few places where we
> do this sort of thing: allocate a buffer, squirt characters into it,
> reallocating and/or flushing as we proceed.  All sysfs and procfs read-side
> code, for a start...

printk is a special case, I think.  It's the primary logging/debugging
method which can't fail and as it's mostly interpreted by human beings
(and developers in problematic cases), it has different maneuvering room
on errors - ie. it's far better to print messages w/o header or proper
log level than failing to print, which is quite different requirements
from other components.

Thanks.

-- 
tejun
