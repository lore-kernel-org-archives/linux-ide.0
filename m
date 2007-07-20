From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 10/11] iomap: sort out the broken address reporting
 caused by the iomap layer
Date: Fri, 20 Jul 2007 13:22:04 +0100
Message-ID: <20070720132204.7bcc244b@the-village.bc.nu>
References: <200707091846.l69IkNop001393@imap1.linux-foundation.org>
	<46A0A689.9020800@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46787 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754995AbXGTMQc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:16:32 -0400
In-Reply-To: <46A0A689.9020800@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com, htejun@gmail.com

> > +/* Convert an iomap to text for this platform */
> > +extern char *iomap_name(void __iomem *addr, char *buf, size_t len);
> > +#define IOMAP_NAMELEN	12
> 
> this will truncate on 64-bit addresses

Yes I suppose we could have 64bit MMIO mappings. So make it 20 8)

Shall I send Andrew/you another diff to do this in the next batch of
updates I'll send out ?

Alan
