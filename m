From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/17] ide-tape: remove remaining pipeline functionality
Date: Fri, 21 Mar 2008 01:09:38 +0100
Message-ID: <200803210109.38671.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-11-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:61980 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbYCTX4d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587156ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:32 -0700 (PDT)
In-Reply-To: <1205736090-4435-11-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> The driver is using now solely its own request queue.

patch summary and patch description are _very_ sparse

[ at least two things are worth mentioning here:

  - tape->next_stage is always NULL so it is safe to remove
    all code depending on tape->next_stage != NULL

  - this patch removes the last place which sets
    IDETAPE_FLAG_PIPELINE_ACTIVE in tape->flags ]

> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
