From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/24] ide-tape: cleanup pipeline-specific code from idetape_init_read
Date: Sun, 2 Mar 2008 19:48:34 +0100
Message-ID: <200803021948.34386.bzolnier@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <1204361928-30229-6-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:39140 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758849AbYCBTDf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 14:03:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1533901ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 11:03:35 -0800 (PST)
In-Reply-To: <1204361928-30229-6-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Saturday 01 March 2008, Borislav Petkov wrote:
> Also, remove idetape_kmalloc_stage() and idetape_add_stage_tail() since they've
> become unused, as a result.

I wonder whether some of these changes should be done before patch #2 or #3?

It could be that it would make patches #2-4 obvious, ie.

> -	if (!test_bit(IDETAPE_FLAG_PIPELINE_ERR, &tape->flags) &&
> -	    tape->nr_stages < max_stages) {
> -		new_stage = idetape_kmalloc_stage(tape);
> -		while (new_stage != NULL) {
> -			new_stage->rq = rq;
> -			idetape_add_stage_tail(drive, new_stage);
> -			if (tape->nr_stages >= max_stages)
> -				break;
> -			new_stage = idetape_kmalloc_stage(tape);
> -		}
> -	}

I can see now that after this change ->first_stage will be always NULL
