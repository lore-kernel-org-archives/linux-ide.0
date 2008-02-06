From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: another possible ide panic fix for blk-end-request
Date: Wed, 6 Feb 2008 21:54:24 +0100
Message-ID: <200802062154.25542.bzolnier@gmail.com>
References: <20080204.145312.39152078.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:40687 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbYBFUlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 15:41:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so666538wah.23
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 12:41:50 -0800 (PST)
In-Reply-To: <20080204.145312.39152078.k-ueda@ct.jp.nec.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: jens.axboe@oracle.com, petkovbb@googlemail.com, linux-ide@vger.kernel.org, j-nomura@ce.jp.nec.com

On Monday 04 February 2008, Kiyoshi Ueda wrote:
> Hi Jens, Bart, Boris,
> 
> I have reviewed all blk-end-request patches again to confirm whether
> there are any similar problems with the last week's ide-cd panic:
>     http://lkml.org/lkml/2008/1/29/140
> 
> And I found a possible similar bug in ide-io change:
> ide_end_drive_cmd() could be called for blk_pc_request() which could
> have bios.  To complete such requests correctly, we need to pass
> the actual size of the request.
> Otherwise, __blk_end_request() returns 1 because the request still has
> bios, and the system will BUG() unnecessarily.
> 
> The following patch fixes the bug and should be applied on top of
> Linus' git.
> Please review and apply.
> 
> 
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Borislav Petkov <petkovbb@googlemail.com>
> Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

applied, thanks
