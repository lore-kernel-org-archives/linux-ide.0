From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH #ide-phase2] ide-dma: don't reset request fields on dma_timeout_retry()
Date: Tue, 21 Apr 2009 13:53:59 +0200
Message-ID: <200904211354.00036.bzolnier@gmail.com>
References: <1240099122-18381-1-git-send-email-tj@kernel.org> <200904201357.44507.bzolnier@gmail.com> <49ED3C24.4010709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:53794 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbZDULx4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 07:53:56 -0400
Received: by ewy24 with SMTP id 24so1547064ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 21 Apr 2009 04:53:55 -0700 (PDT)
In-Reply-To: <49ED3C24.4010709@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@googlemail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

On Tuesday 21 April 2009 05:23:16 Tejun Heo wrote:
> Impact: drop unnecessary code
> 
> Now that everything uses bio and block operations, there is no need to
> reset request fields manually when retrying a request.  Every field is
> guaranteed to be always valid.  Drop unnecessary request field
> resetting from ide_dma_timeout_retry().

Yep.

> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> This patch applies on top of this patchset.  I updated the #ide-phase2
> git branch to include this patch.  Thanks.

I pulled ide-phase2 into ide-2.6/for-next.

Thanks a lot for this work!
