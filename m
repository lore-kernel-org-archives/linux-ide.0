From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 11/14] ide-cd: don't abuse rq->buffer
Date: Thu, 26 Mar 2009 09:34:56 +0100
Message-ID: <20090326083456.GB32155@liondog.tnic>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <1237910776-10983-12-git-send-email-tj@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58646 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbZCZIfE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 04:35:04 -0400
Content-Disposition: inline
In-Reply-To: <1237910776-10983-12-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

On Wed, Mar 25, 2009 at 01:06:13AM +0900, Tejun Heo wrote:
> Impact: rq->buffer usage cleanup
> 
> ide-cd uses rq->buffer to carry pointer to the original request when
> issuing REQUEST_SENSE.  Use rq->special instead.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

-- 
Regards/Gruss,
    Boris.
