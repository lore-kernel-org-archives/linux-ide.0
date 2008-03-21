From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/17] ide-tape: remove pipeline-specific code in idetape_space_over_filemarks()
Date: Fri, 21 Mar 2008 01:09:23 +0100
Message-ID: <200803210109.23513.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-6-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:62262 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916AbYCTX43 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:29 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1587211ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:26 -0700 (PDT)
In-Reply-To: <1205736090-4435-6-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> Since we don't do pipeline read-ahead anymore, we don't have to look for
> filemarks we have crossed. Therefore, remove the code chunk that does that and
> pass on the command to the tape. As a side effect, remove unused
> idetape_wait_first_stage().
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
