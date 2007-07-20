From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 10/11] iomap: sort out the broken address reporting caused
 by the iomap layer
Date: Fri, 20 Jul 2007 08:24:12 -0400
Message-ID: <46A0A96C.90702@garzik.org>
References: <200707091846.l69IkNop001393@imap1.linux-foundation.org>	<46A0A689.9020800@garzik.org> <20070720132204.7bcc244b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50159 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756325AbXGTMYP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:24:15 -0400
In-Reply-To: <20070720132204.7bcc244b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com, htejun@gmail.com

Alan Cox wrote:
>>> +/* Convert an iomap to text for this platform */
>>> +extern char *iomap_name(void __iomem *addr, char *buf, size_t len);
>>> +#define IOMAP_NAMELEN	12
>> this will truncate on 64-bit addresses
> 
> Yes I suppose we could have 64bit MMIO mappings. So make it 20 8)
> 
> Shall I send Andrew/you another diff to do this in the next batch of
> updates I'll send out ?

Please.  In general, I was running through patches from you sent by 
Andrew (his periodic libata patchbomb).  IIRC, a few of those were for 
testing and did want immediate upstreaming anyway?


