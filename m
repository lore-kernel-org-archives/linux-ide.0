From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] sis5513: fix potential use after free
Date: Tue, 27 Nov 2018 23:05:24 -0800
Message-ID: <20181128070524.GB30936@infradead.org>
References: <1543366526-46767-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543366526-46767-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 28, 2018 at 08:55:26AM +0800, Pan Bian wrote:
> The function sis_find_family drops lpc_bridge reference via pci_dev_put,
> however, after that, field lpc_bridge->revision is read. This may result
> in a use after free bug. The patch moves the put operation after the
> condition check.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
