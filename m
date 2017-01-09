From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 08:21:43 -0800
Message-ID: <20170109162143.GA11959@infradead.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170109160424.GB12827@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 09, 2017 at 11:04:24AM -0500, Tejun Heo wrote:
> ata_force_param_buf is __initdata and shouldn't really matter.
> ata_scsi_rbuf, hmmm, idk.  Maybe we can allocate it dynamically when
> registering the first ATA device so that systems w/o them can avoid
> the wastage.

Having it global is kinda weird anyway.  But looking the code none
of the commands actually using is in the paging path, so it could
simply be replaced with a dynamic allocation in ata_scsi_rbuf_fill
for the actually needed size, which often will be very small,
or sometimes even 0.
