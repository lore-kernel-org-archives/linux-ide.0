From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc
	cleanups
Date: Sat, 28 Mar 2009 15:04:05 +0100
Message-ID: <20090328140405.GA2741@liondog.tnic>
References: <1237910776-10983-1-git-send-email-tj@kernel.org> <200903281451.01361.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754346AbZC1OE0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200903281451.01361.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Mar 28, 2009 at 02:51:01PM +0100, Bartlomiej Zolnierkiewicz wrote:

[..]

> > Bartlomiej, if you're okay with the changes and Jens acks the patches
> > and pushing the first three patches via pata-2.6, please feel free to
> > include these patches into your tree.
> 
> Everything looks fine to me.  Once I get Jens' ack (block bits)
> and Borislav's one (ATAPI bits) I'll happily merge this patchset.

Yep, I just finished testing the whole series here so you can go ahead
and apply them pending a recast of patch 07/14 you'll hopefully be
receiving soon from Tejun.

-- 
Regards/Gruss,
    Boris.
