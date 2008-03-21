From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/17] ide-tape: remove pipeline functionality-v3
Date: Fri, 21 Mar 2008 01:04:17 +0100
Message-ID: <200803210104.17651.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:61980 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbYCTX4Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:24 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587156ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:22 -0700 (PDT)
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Monday 17 March 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's the rest of the pipeline removal series. What's left is to rewrite the
> whole allocation logic around tape->merge_stage and all the other small buffers
> so that we can get at least some sanity into the driver before working on it
> any further :).
> 
>  Documentation/ide/ide-tape.txt |  211 ++++---------
>  drivers/ide/ide-tape.c         |  689 ++--------------------------------------
>  2 files changed, 99 insertions(+), 801 deletions(-)

Thanks.

I applied everything except patches #3-4 (as they need to be delayed
after tape->merge_state and co. rewrite).

Bart
