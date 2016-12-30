From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/3] ata: allow subsystem to be used on m68k arch
Date: Fri, 30 Dec 2016 18:14:36 +0100
Message-ID: <3484511.F6TxDiWTi4@amdc3058>
References: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <1483106478-1382-2-git-send-email-b.zolnierkie@samsung.com>
 <20161230141249.GA4543@infradead.org>
 <CGME20161230171438epcas1p3c1d8ea8e4c77d796b81f7130c5e61d3f@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43664 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbcL3ROm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2016 12:14:42 -0500
In-reply-to: <20161230141249.GA4543@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org


Hi,

On Friday, December 30, 2016 06:12:49 AM Christoph Hellwig wrote:
> On Fri, Dec 30, 2016 at 03:01:16PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > When libata was merged m68k lacked IOMAP support.  This has not been
> > true for a long time now so allow subsystem to be used on m68k.
> 
> Is that dependency needed at all anymore?  What exact functionality
> is missing on m32r and s390?

* m32r: I don't know why it was restricted but it builds fine nowadays
  (I will fix it later in incremental patch)

* s390: no PATA hardware, legacy IDE subsystem is also not supported

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

