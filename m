From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH v4] drivers/block/mtip32xx: Adding new driver mtip32xx
Date: Mon, 12 Sep 2011 20:25:41 +0200
Message-ID: <4E6E4EA5.1050701@fusionio.com>
References: <22A973199D2C2F46933448F6E7990A3002C80026@ntxboimbx31.micron.com> <4E44E782.7090309@fusionio.com> <2A9BE4FF6209B644B6F8EB62DE6AEA1E07663ED4@ntxfrembx01.micron.com> <20110909085433.GA9593@infradead.org> <4E69D519.8070802@fusionio.com> <20110912150228.GA5771@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110912150228.GA5771@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
List-Id: linux-ide@vger.kernel.org

On 2011-09-12 17:02, Christoph Hellwig wrote:
> On Fri, Sep 09, 2011 at 10:58:01AM +0200, Jens Axboe wrote:
>>>    Documentation/block/writeback_cache_control.txt file is the canonical
>>>    resource.  Implementing your driver at the make_request layer
>>>    unfortunately means you will have to do all the hard work yourself.
>>>  - also the call to blk_queue_flush(queue, 0); from ->make_request for
>>>    a non-data request is completely wrong.
>>
>> I noticed both of these flush/fua problems too and have fixed them up.
> 
> I still can't find any fixes in your repository.

It wasn't/isn't done, it's still sitting on the test box. I'll wrap it
up tomorrow.


-- 
Jens Axboe
