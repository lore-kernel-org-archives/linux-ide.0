From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: fix some codestyle and most of the checkpatch.pl issues
Date: Tue, 26 Feb 2008 23:37:29 +0100
Message-ID: <200802262337.29873.bzolnier@gmail.com>
References: <1204012194-4208-1-git-send-email-petkovbb@gmail.com> <1204012194-4208-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:23797 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764952AbYBZWXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 17:23:42 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1257917nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 26 Feb 2008 14:23:42 -0800 (PST)
In-Reply-To: <1204012194-4208-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>


On Tuesday 26 February 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-cd.c |  634 +++++++++++++++++++++++++------------------------
>  1 files changed, 323 insertions(+), 311 deletions(-)

With 300 lines changed this is not trivial to review/apply anymore
(yeah, I sound like a broken record ;-) and since I've already applied
Paolo's patch from two days ago this one heavily rejects...

Moreover md5sum is different before/after the patch - I tried really hard
to figure out why (by reverting some changes) but finally I gave up.

Please:
- resync
- factor out changes which affect resulting binary
- resubmit

Thanks,
Bart
