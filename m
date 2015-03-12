From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: revert "libata: use blk taging" et al.
Date: Thu, 12 Mar 2015 09:59:26 -0400
Message-ID: <20150312135926.GK25944@htj.duckdns.org>
References: <5500863D.4070807@cybernetics.com>
 <5500B783.20106@fb.com>
 <5500BF6F.6080000@cybernetics.com>
 <20150312023148.GA1960870@devbig257.prn2.facebook.com>
 <CAPcyv4izOUB93ySh1Qua6qbDC8utgCjY5Zj__NbUXvS9MNY5EQ@mail.gmail.com>
 <20150312121157.GH25944@htj.duckdns.org>
 <20150312124601.GA2750169@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150312124601.GA2750169@devbig257.prn2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Tony Battersby <tonyb@cybernetics.com>, Jens Axboe <axboe@fb.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thu, Mar 12, 2015 at 05:46:01AM -0700, Shaohua Li wrote:
> ata: Add a new flag for sas controller
> 
> Add a new flag to destinguish sas controller. sas controller has its own tag
> allocation, which doesn't directly match to ata tag. We use the new flag for
> sas ata tag allocation.

This doesn't really explain why the patch came to be.  Can you please
update it to include what broke how and got fixed?  A Fixes: tag would
be nice too.

Thanks.

-- 
tejun
