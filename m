From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc	cleanups
Date: Tue, 31 Mar 2009 02:20:22 +0900
Message-ID: <49D0FF56.3080205@kernel.org>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <200903281451.01361.bzolnier@gmail.com> <20090328140405.GA2741@liondog.tnic> <49D08CEC.3010705@kernel.org> <49D0A985.7090307@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757733AbZC3RUs@vger.kernel.org>
In-Reply-To: <49D0A985.7090307@panasas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Boaz Harrosh wrote:
>> P.S.: Boaz, the above patchset implements blk_rq_map_kern_sgl() 
> 
> What is blk_rq_map_kern_sgl() ? I'm not sure I remember ?
> What is it's API? and what does it do?
> 
>> and kills the SCSI layer hack.  That was the issue you were trying
>> to solve, right?
> 
> If you post URL of git tree I can have a look and start an early review
> if you want

Here's the patchset.  It builds but I haven't even booted it yet, so
expect some breakages.

  http://git.kernel.org/?p=linux/kernel/git/tj/misc.git;a=shortlog;h=map-untested
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git map-untested

Thanks.

-- 
tejun
