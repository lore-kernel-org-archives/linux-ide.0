From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH v4] drivers/block/mtip32xx: Adding new driver mtip32xx
Date: Tue, 13 Sep 2011 23:03:16 +0200
Message-ID: <4E6FC514.7070401@fusionio.com>
References: <22A973199D2C2F46933448F6E7990A3002C80026@ntxboimbx31.micron.com> <4E44E782.7090309@fusionio.com> <2A9BE4FF6209B644B6F8EB62DE6AEA1E07663ED4@ntxfrembx01.micron.com> <20110909085433.GA9593@infradead.org> <20110913124906.GA17855@infradead.org> <CAJqx+goSvc75q0gr3AkG3RqXi5_rUCuy+igx9+EZBFvyZLj39A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.fusionio.com ([66.114.96.31]:38476 "EHLO mx2.fusionio.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702Ab1IMVDW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Sep 2011 17:03:22 -0400
In-Reply-To: <CAJqx+goSvc75q0gr3AkG3RqXi5_rUCuy+igx9+EZBFvyZLj39A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Seppanen <eds@reric.net>
Cc: Christoph Hellwig <hch@infradead.org>, "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>

On 2011-09-13 18:46, Eric Seppanen wrote:
> On Tue, Sep 13, 2011 at 5:49 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> Btw, there is another _huge_ issue with the driver, and that is the
>> lack of any internal queueing.  Remember the make_request interface is
>> an extremly thin layer (or rather the lack of it) below the filesystem.
>>
>> So for example if eh_active is non-zero you return -EBUSY to the
>> filesystems.  That's an error code it a) doesn't recognize and b)
>> couldn't handle even if it did.  Similarly mtip_hw_get_scatterlist
>> simply blocks if no tag is currently available instead of queueing
>> it up.
> 
> Just out of curiosity, why is blocking on no-tag-available a bad
> thing?  How is it any different than the blocking that will occur when
> a request queue is full?  When the hardware queue depth is bigger than
> that of a request queue, what extra benefit does queuing give?

The blocking for a free tag is fine, the actual implementation is
definitely not optimal (using a rw semaphore with count initialized to
the tag depth, ugh). You'll need to block for a free tag in any case, or
add a thread to restart things on a free tag. The thread would not help
performance.

But the -EBUSY is definitely a bug, that needs to be a waiting condition
as well.

-- 
Jens Axboe

