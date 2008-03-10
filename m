From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/4] ide-tape: remove pipeline functionality-v2
Date: Tue, 11 Mar 2008 00:24:35 +0100
Message-ID: <200803110024.35174.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:53468 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYCJXMz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:12:55 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2142916fga.17
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:12:53 -0700 (PDT)
In-Reply-To: <1205082632-3418-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Sunday 09 March 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here are some patches removing the code for adding r/w requests to the pipeline.
> Instead, they are being queued straight onto the device request queue now. In
> addition, pipeline speed/control calculation has been removed since it becomes
> also unused.
> 
>  drivers/ide/ide-tape.c |  334 +++++++-----------------------------------------
>  1 files changed, 46 insertions(+), 288 deletions(-)

Thanks for re-doing the patches, I applied everything (it seems that thanks
to the recast the changes become more obvious and we may now simplify patches
even more - please see the other mails).

Bart
