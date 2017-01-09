From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 09:22:07 -0800
Message-ID: <20170109172207.GA10557@infradead.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
 <20170109162143.GA11959@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968442AbdAIRWJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 12:22:09 -0500
Content-Disposition: inline
In-Reply-To: <20170109162143.GA11959@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 09, 2017 at 08:21:43AM -0800, Christoph Hellwig wrote:
> Having it global is kinda weird anyway.  But looking the code none
> of the commands actually using is in the paging path, so it could
> simply be replaced with a dynamic allocation in ata_scsi_rbuf_fill
> for the actually needed size, which often will be very small,
> or sometimes even 0.

Prototype here, only tested with a simple mkfs.xfs and some I/O on
AHCI so far:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/libata-kill-ata_scsi_rbuf
