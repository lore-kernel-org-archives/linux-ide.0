From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Another libata TODO item
Date: Wed, 24 Aug 2005 03:51:58 -0400
Message-ID: <430C271E.7060006@pobox.com>
References: <430C10E7.9060502@pobox.com> <20050824074116.GF24513@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750732AbVHXHwH@vger.kernel.org>
In-Reply-To: <20050824074116.GF24513@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Aug 24, 2005 at 02:17:11AM -0400, Jeff Garzik wrote:
>>To make libata debugging easier and more fine-grained, we should convert 
>>DPRINTK/VPRINTK calls in libata to code that looks like
>>
>>	if (ata_msg_xxx(ap->msg_enable))
>>		printk(...)
> 
> 
> Would be nice if you could move that one up to the scsi layer and combine
> it with the existing scsi core loglevel handling.


Doubtful.  libata's use of SCSI will become optional, so using SCSI 
logging throughout libata core would be inappropriate.  Block layer 
would be more reasonable.

In any case, I also contine to be skeptical of in-kernel logging subsystems.

	Jeff
