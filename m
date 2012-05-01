From: Mark Lord <kernel@teksavvy.com>
Subject: Re: ata_eh_link_autopsy:  Bug?
Date: Tue, 01 May 2012 16:27:00 -0400
Message-ID: <4FA04714.7050602@teksavvy.com>
References: <4FA043BE.2010009@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:3753 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab2EAU1C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2012 16:27:02 -0400
In-Reply-To: <4FA043BE.2010009@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 12-05-01 04:12 PM, Mark Lord wrote:
> In libata-eh.c, the function ata_eh_link_autopsy() tries to decide
> if an operation is worth retrying.
> 
> I notice that for MEDIA ERRORs, it always sits there for minutes
> doing futile retries, when it's pretty obvious that the drive
> is reporting an uncorrectable error.
> 
> Is this code correct?
> 
> 
>                 /* determine whether the command is worth retrying */
>                 if (qc->flags & ATA_QCFLAG_IO ||
>                     (!(qc->err_mask & AC_ERR_INVALID) &&
>                      qc->err_mask != AC_ERR_DEV))
>                         qc->flags |= ATA_QCFLAG_RETRY;
> 
> 
> I think this part may be incorrect:  qc->err_mask != AC_ERR_DEV
> Shouldn't that test be this instead:  !(qc->err_mask & AC_ERR_DEV)  ??

MMmm.. even that isn't good enough, because the first ATA_QCFLAG_IO test
bypasses the rest of that logic and triggers unconditional retries.  Ugh.

So something like this perhaps:

                  /* determine whether the command is worth retrying */
                  if (qc->flags & ATA_QCFLAG_IO ||
                      (!(qc->err_mask & AC_ERR_INVALID) &&
                       qc->err_mask != AC_ERR_DEV))
-                         qc->flags |= ATA_QCFLAG_RETRY;
+                         if (!(qc->err_mask & AC_ERR_MEDIA))
+                            qc->flags |= ATA_QCFLAG_RETRY;


> The mask is just about never exactly equal to AC_ERR_DEV.
> In the case of a media error, it is (AC_ERR_DEV | AC_ERR_MEDIA) at this point.
> 
> Tejun?


