From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 08/17] ide-tape: remove pipeline-specific code from idetape_end_request()
Date: Fri, 21 Mar 2008 01:09:31 +0100
Message-ID: <200803210109.31169.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-9-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:63085 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144AbYCTX4a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587151ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:29 -0700 (PDT)
In-Reply-To: <1205736090-4435-9-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> As a side effect, remove unused idetape_kfree_stage() and
> idetape_abort_pipeline()
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied

[ I resurrected taking tape->lock + clearing IDETAPE_FLAG_PIPELINE_ACTIVE ]
