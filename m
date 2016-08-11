From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 1/2] Use kmap_atomic when rewriting attached page
Date: Thu, 11 Aug 2016 16:13:34 +0200
Message-ID: <20160811141334.GA16956@lst.de>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com> <1470790829-3793-2-git-send-email-shaun@tancheff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470790829-3793-2-git-send-email-shaun@tancheff.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>, Shaun Tancheff <shaun.tancheff@seagate.com>
List-Id: linux-ide@vger.kernel.org

> +static unsigned int ata_format_dsm_trim_descr(struct scatterlist *sg, u32 num,
> +					      u64 sector, u32 count)
> +{
> +	void *ptr = kmap_atomic(sg_page(sg));


Please use sg_copy_from_buffer to be safe against all corner cases.
