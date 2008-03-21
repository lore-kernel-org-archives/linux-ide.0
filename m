From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 13/17] ide-tape: remove pipelined mode tape control flags
Date: Fri, 21 Mar 2008 01:09:44 +0100
Message-ID: <200803210109.44607.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-14-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:63085 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635AbYCTX4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:35 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587151ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:34 -0700 (PDT)
In-Reply-To: <1205736090-4435-14-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied

> @@ -1832,14 +1822,6 @@ static int idetape_init_read(ide_drive_t *drive, int max_stages)
>  		}
>  	}
>  
> -	if (!test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
> -		if (tape->nr_pending_stages >= 3 * max_stages / 4) {
> -			tape->measure_insert_time = 1;
> -			tape->insert_time = jiffies;
> -			tape->insert_size = 0;
> -			tape->insert_speed = 0;
> -		}
> -	}

It is !test_bit() so the second 'if ()' block should be preserved
(I fixed this while merging the patch).
