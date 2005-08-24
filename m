From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Another libata TODO item
Date: Wed, 24 Aug 2005 08:41:16 +0100
Message-ID: <20050824074116.GF24513@infradead.org>
References: <430C10E7.9060502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750720AbVHXHlS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <430C10E7.9060502@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Aug 24, 2005 at 02:17:11AM -0400, Jeff Garzik wrote:
> 
> Difficulty:  beginner / intermediate
> 
> Modern network drivers have a per-NIC list of debugging messages that 
> can be enabled/disabled at runtime, implemented as a bitmask named 
> 'msg_enable' in each driver.  VERY useful for tracing specific events 
> during debugging.  grep for 'msg_enable', 'netif_msg_', and 'NETIF_MSG_'.
> 
> To make libata debugging easier and more fine-grained, we should convert 
> DPRINTK/VPRINTK calls in libata to code that looks like
> 
> 	if (ata_msg_xxx(ap->msg_enable))
> 		printk(...)

Would be nice if you could move that one up to the scsi layer and combine
it with the existing scsi core loglevel handling.
