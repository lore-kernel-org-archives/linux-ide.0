From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-eh: Use switch() instead of sparse array for
 protocol strings
Date: Mon, 9 Jan 2017 12:31:54 -0500
Message-ID: <20170109173154.GE12827@mtj.duckdns.org>
References: <1483973368-6828-1-git-send-email-geert@linux-m68k.org>
 <20170109152319.GA12827@mtj.duckdns.org>
 <CAMuHMdW6KPq6-7vmpTTv_M30zbqkdVbewgaOaCqYT+UzXpGU9Q@mail.gmail.com>
 <20170109160424.GB12827@mtj.duckdns.org>
 <CAMuHMdV3n9rq8eTjwxKzRLroF2YJYi2qvCzQ4eDhDEkGB=4dLw@mail.gmail.com>
 <20170109172723.GA30423@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33959 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935323AbdAIRcD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 12:32:03 -0500
Content-Disposition: inline
In-Reply-To: <20170109172723.GA30423@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

On Mon, Jan 09, 2017 at 09:27:23AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 09, 2017 at 05:30:02PM +0100, Geert Uytterhoeven wrote:
> > > ata_force_param_buf is __initdata and shouldn't really matter.
> > 
> > It mainly matters because of e.g. bootloader limitations.
> 
> Do we need a full 4k for the force parameters?  What would a typical
> command line for it look like?

Maybe a couple hundreds bytes at max, but it's a bit weird to restrict
this given that it is bss, not gigantic and __initdata.  What kind of
bootloader limitations are we talking about?

Thanks.

-- 
tejun
