From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 3/5] libsas: dynamic queue depth
Date: Tue, 20 Sep 2011 18:18:08 -0400
Message-ID: <20110920221808.GC2530@infradead.org>
References: <20110920220819.1094.12265.stgit@localhost6.localdomain6>
 <20110920221038.1094.7832.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110920221038.1094.7832.stgit@localhost6.localdomain6>
Sender: linux-scsi-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Luben Tuikov <ltuikov@yahoo.com>, jgarzik@pobox.com, JBottomley@parallels.com, Jack Wang <jack_wang@usish.com>, Xiangliang Yu <yuxiangl@marvell.com>, Mark Salyzyn <msalyzyn@us.xyratex.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-ide@vger.kernel.org

On Tue, Sep 20, 2011 at 03:10:46PM -0700, Dan Williams wrote:
> The queue-depth for libsas-attached devices initializes to 32 and can
> only be increased manually via sysfs to a max of 64, while mpt2sas
> attached devices initialize to 254 and dynamically float via the
> midlayer ->change_queue_depth interface.
> 
> No performance regression was observed with this change on the isci
> driver.

Looks reasonable to me.

