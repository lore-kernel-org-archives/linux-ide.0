From: Samuel Flory <sflory@rackable.com>
Subject: Re: patchset updates 2.4 ide
Date: Fri, 10 May 2002 16:47:23 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3CDC5C0B.2070008@rackable.com>
References: <Pine.LNX.4.10.10205101157290.3133-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

   This fixes the dma issues I was seeing on the Tyan 2720.  Now dma is 
on by default.  Thanks Andre!

   Now I need to figure why I'm getting spammed with "invalidate: busy 
buffer".  It's not this patch as it happens on 2.4.18, and 2.4.19pre7 
without dma turned on.


Andre Hedrick wrote:
> http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2
> http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
> 
> Closer to making it modular and selectable/split io/mmio channel access.
> 
> There are a few patches left out as time was a crunch.
> 
> Cheers
> 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


