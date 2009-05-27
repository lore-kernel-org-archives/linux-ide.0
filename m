From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.29] ide-tape: remove back-to-back REQUEST_SENSE detection
Date: Wed, 27 May 2009 09:40:40 +0200
Message-ID: <200905270940.40610.bzolnier@gmail.com>
References: <20090527072004.GA8127@liondog.tnic>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:49511 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763600AbZE0Hfl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 May 2009 03:35:41 -0400
Received: by an-out-0708.google.com with SMTP id d40so9526484and.1
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2009 00:35:43 -0700 (PDT)
In-Reply-To: <20090527072004.GA8127@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: stable@kernel.org, tj@kernel.org, linux-ide@vger.kernel.org

On Wednesday 27 May 2009 09:20:04 Borislav Petkov wrote:
> Hi,
> 
> please include, commit id upstream:
> 
> 1e75540ec5202cae63cd238c86bd880e3d496546

This is for-next branch..

The right commit is 36999a5af1b6c5379e59f0ddf434db08d03c19e4 (because it
was later cherry picked into for-linus) and has my S-o-B line.
