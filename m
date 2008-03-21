From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/17] ide-tape: remove pipeline-specific code from idetape_setup
Date: Fri, 21 Mar 2008 01:09:41 +0100
Message-ID: <200803210109.41404.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-12-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929AbYCTX4e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587213ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:33 -0700 (PDT)
In-Reply-To: <1205736090-4435-12-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


On Monday 17 March 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

->max_stages and ->{min,max}_pipeline are later removed in patch #14,
it makes sense to merge both patches together [ as I did ;-) ]

[...]

> -	if (tape->max_stages == 0) {
> -		tape->max_stages   = 1;
> -		tape->min_pipeline = 1;
> -		tape->max_pipeline = 1;
> -	}
> -
> -	t1 = (tape->stage_size * HZ) / (speed * 1000);
> -	tmid = (*(u16 *)&tape->caps[16] * 32 * HZ) / (speed * 125);
> -	tn = (IDETAPE_FIFO_THRESHOLD * tape->stage_size * HZ) / (speed * 1000);
> -
> -	if (tape->max_stages)
> -		t = tn;
> -	else
> -		t = t1;
> +	t = (tape->stage_size * HZ) / (speed * 1000);

tape->max_stages was always > 0 so 't' should use 'tn' not 't1'
(fixed during merge)
