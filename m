From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 09:27:23 -0800
Message-ID: <20170109172723.GA30423@infradead.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
 <CAMuHMdV3n9rq8eTjwxKzRLroF2YJYi2qvCzQ4eDhDEkGB=4dLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034361AbdAIR1Z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 12:27:25 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdV3n9rq8eTjwxKzRLroF2YJYi2qvCzQ4eDhDEkGB=4dLw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 09, 2017 at 05:30:02PM +0100, Geert Uytterhoeven wrote:
> > ata_force_param_buf is __initdata and shouldn't really matter.
> 
> It mainly matters because of e.g. bootloader limitations.

Do we need a full 4k for the force parameters?  What would a typical
command line for it look like?
