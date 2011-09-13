From: Eric Seppanen <eds@reric.net>
Subject: Re: [PATCH v4] drivers/block/mtip32xx: Adding new driver mtip32xx
Date: Tue, 13 Sep 2011 09:46:07 -0700
Message-ID: <CAJqx+goSvc75q0gr3AkG3RqXi5_rUCuy+igx9+EZBFvyZLj39A@mail.gmail.com>
References: <22A973199D2C2F46933448F6E7990A3002C80026@ntxboimbx31.micron.com>
 <4E44E782.7090309@fusionio.com> <2A9BE4FF6209B644B6F8EB62DE6AEA1E07663ED4@ntxfrembx01.micron.com>
 <20110909085433.GA9593@infradead.org> <20110913124906.GA17855@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60492 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab1IMQq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Sep 2011 12:46:28 -0400
In-Reply-To: <20110913124906.GA17855@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>, jaxboe@fusionio.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, jmoyer@redhat.com, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>

On Tue, Sep 13, 2011 at 5:49 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
> Btw, there is another _huge_ issue with the driver, and that is the
> lack of any internal queueing. =A0Remember the make_request interface=
 is
> an extremly thin layer (or rather the lack of it) below the filesyste=
m.
>
> So for example if eh_active is non-zero you return -EBUSY to the
> filesystems. =A0That's an error code it a) doesn't recognize and b)
> couldn't handle even if it did. =A0Similarly mtip_hw_get_scatterlist
> simply blocks if no tag is currently available instead of queueing
> it up.

Just out of curiosity, why is blocking on no-tag-available a bad
thing?  How is it any different than the blocking that will occur when
a request queue is full?  When the hardware queue depth is bigger than
that of a request queue, what extra benefit does queuing give?
