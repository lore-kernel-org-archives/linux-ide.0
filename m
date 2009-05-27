From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 2.6.29] ide-tape: remove back-to-back REQUEST_SENSE
	detection
Date: Wed, 27 May 2009 10:03:45 +0200
Message-ID: <20090527080345.GA9162@liondog.tnic>
References: <20090527072004.GA8127@liondog.tnic> <200905270940.40610.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:50146 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbZE0IDr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2009 04:03:47 -0400
Received: by bwz22 with SMTP id 22so4384824bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2009 01:03:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905270940.40610.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: stable@kernel.org, tj@kernel.org, linux-ide@vger.kernel.org

On Wed, May 27, 2009 at 09:40:40AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 27 May 2009 09:20:04 Borislav Petkov wrote:
> > Hi,
> > 
> > please include, commit id upstream:
> > 
> > 1e75540ec5202cae63cd238c86bd880e3d496546
> 
> This is for-next branch..
> 
> The right commit is 36999a5af1b6c5379e59f0ddf434db08d03c19e4 (because it
> was later cherry picked into for-linus) and has my S-o-B line.

Thanks, had the wrong commit id noted here.

-- 
Regards/Gruss,
    Boris.
