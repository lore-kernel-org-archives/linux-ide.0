From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4] drivers/block/mtip32xx: Adding new driver mtip32xx
Date: Fri, 9 Sep 2011 05:02:57 -0400
Message-ID: <20110909090257.GA16871@infradead.org>
References: <22A973199D2C2F46933448F6E7990A3002C80026@ntxboimbx31.micron.com>
 <4E44E782.7090309@fusionio.com>
 <2A9BE4FF6209B644B6F8EB62DE6AEA1E07663ED4@ntxfrembx01.micron.com>
 <20110909085433.GA9593@infradead.org>
 <4E69D519.8070802@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:43823
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932889Ab1IIJDB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2011 05:03:01 -0400
Content-Disposition: inline
In-Reply-To: <4E69D519.8070802@fusionio.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>

On Fri, Sep 09, 2011 at 10:58:01AM +0200, Jens Axboe wrote:
> >  - also the call to blk_queue_flush(queue, 0); from ->make_request for
> >    a non-data request is completely wrong.
> 
> I noticed both of these flush/fua problems too and have fixed them up.

Where?  Remember that sequencing a pre-flush in a make_request driver
is fairly complicated.

