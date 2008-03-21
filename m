From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 06/17] ide-tape: remove idetape_pipeline_size()
Date: Fri, 21 Mar 2008 01:09:25 +0100
Message-ID: <200803210109.26119.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-7-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:63085 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbYCTX42 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:28 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587151ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:27 -0700 (PDT)
In-Reply-To: <1205736090-4435-7-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> The computation of the block offset of the the tape position (MTIOCPOS,
> MTIOCGET) is not influenced by the stages queued in the pipeline anymore but by
> the size of the current buffer which is going to be sent to the drive.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied

[ I resurrected deleted idetape_wait_for_pipeline() call ]
