From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc	cleanups
Date: Mon, 30 Mar 2009 14:14:13 +0300
Message-ID: <49D0A985.7090307@panasas.com>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <200903281451.01361.bzolnier@gmail.com> <20090328140405.GA2741@liondog.tnic> <49D08CEC.3010705@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-ca.panasas.com ([209.116.51.66]:1106 "EHLO
	laguna.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750993AbZC3LQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2009 07:16:08 -0400
In-Reply-To: <49D08CEC.3010705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org

On 03/30/2009 12:12 PM, Tejun Heo wrote:
> Borislav Petkov wrote:
>> On Sat, Mar 28, 2009 at 02:51:01PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>
>> [..]
>>
>>>> Bartlomiej, if you're okay with the changes and Jens acks the patches
>>>> and pushing the first three patches via pata-2.6, please feel free to
>>>> include these patches into your tree.
>>> Everything looks fine to me.  Once I get Jens' ack (block bits)
>>> and Borislav's one (ATAPI bits) I'll happily merge this patchset.
>> Yep, I just finished testing the whole series here so you can go ahead
>> and apply them pending a recast of patch 07/14 you'll hopefully be
>> receiving soon from Tejun.
> 
> After the earlier discussion with Boaz Harrosh, I ended up redoing the
> blk_rq_map_{kern|user}_*() stuff and am now in the process of testing
> it.  The patchset is rather large (20+ patches).  As the prealloc
> patch would fit on top of that series, I think it would be better to
> sequence things via git merge.  Is there a git tree I can use for
> pata-2.6 changes?  Or is the current linus master okay?
> 
> Thanks.
> 
> P.S.: Boaz, the above patchset implements blk_rq_map_kern_sgl() 

What is blk_rq_map_kern_sgl() ? I'm not sure I remember ?

What is it's API? and what does it do?

> and
> kills the SCSI layer hack.  That was the issue you were trying to
> solve, right?
> 

If you post URL of git tree I can have a look and start an early review
if you want

Thanks for doing this
Boaz
