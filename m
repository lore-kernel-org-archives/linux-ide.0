From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
Date: Fri, 06 Aug 2004 13:06:03 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4113BA7B.20405@pobox.com>
References: <200408061623.i76GNfDa016095@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38313 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268192AbUHFRNp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Aug 2004 13:13:45 -0400
In-Reply-To: <200408061623.i76GNfDa016095@falcon10.austin.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@austin.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brett Russ <russb@emc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Doug Maxey wrote:
> On Thu, 05 Aug 2004 21:45:59 EDT, Jeff Garzik wrote:
> 
>>ATAPI works too.....  assuming your CD/DVD drive never encounters a 
>>CHECK CONDITION requiring REQUEST SENSE to be issued...  ;-)
> 
> 
>   Heh.  Where should one start looking to get this enabled?  I have to
>   admit that I have given the code only a few minutes viewing.

top of include/linux/libata.h:

/*
  * compile-time options
  */
#undef ATA_FORCE_PIO            /* do not configure or use DMA */
#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */
#undef ATA_IRQ_TRAP             /* define to ack screaming irqs */
#undef ATA_NDEBUG               /* define to disable quick runtime checks */
#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
#undef ATA_ENABLE_PATA          /* define to enable PATA support in some
                                  * low-level drivers */
#undef ATAPI_ENABLE_DMADIR      /* enables ATAPI DMADIR bridge support */

