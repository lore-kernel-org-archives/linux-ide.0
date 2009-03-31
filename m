From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc	cleanups
Date: Tue, 31 Mar 2009 18:10:24 +0900
Message-ID: <49D1DE00.9030600@gmail.com>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <200903281451.01361.bzolnier@gmail.com> <20090328140405.GA2741@liondog.tnic> <49D08CEC.3010705@kernel.org> <49D0A985.7090307@panasas.com> <49D0FF56.3080205@kernel.org> <49D1D7A3.40303@panasas.com> <49D1DCE2.1050201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:13295 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbZCaJKb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 05:10:31 -0400
In-Reply-To: <49D1DCE2.1050201@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

I really should proof read before hitting the send button.  My head is
somehow pretty good at messing up sentences.

Tejun Heo wrote:
> The reason why I want with sgl is because it's the sg mapping
                   went                    it has
...
> wouldn't be that large anyway.  Both aren't worth worrying about
> considering how relative coldness of the path and other overhead of

Eh.. that was a nice mix of "how the path is relatively cold" and
"relative coldness of the path".  :-)

Thanks.

-- 
tejun
