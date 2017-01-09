From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 12:30:26 -0500
Message-ID: <20170109173026.GD12827@mtj.duckdns.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
 <20170109162143.GA11959@infradead.org>
 <20170109172207.GA10557@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170109172207.GA10557@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 09, 2017 at 09:22:07AM -0800, Christoph Hellwig wrote:
> Prototype here, only tested with a simple mkfs.xfs and some I/O on
> AHCI so far:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/libata-kill-ata_scsi_rbuf

Yeah, the only thing which needs completion from atomic context is
atapi commands.  If that can be done on stack, it's all good.

Thanks.

-- 
tejun
