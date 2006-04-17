From: Tejun Heo <htejun@gmail.com>
Subject: Re: A question about right-shift in ahci_port_start()
Date: Mon, 17 Apr 2006 16:46:09 +0900
Message-ID: <444347C1.7050506@gmail.com>
References: <1145258753.3417.5.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:62701 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750927AbWDQHqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Apr 2006 03:46:06 -0400
Received: by pproxy.gmail.com with SMTP id i49so581659pye
        for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 00:46:05 -0700 (PDT)
In-Reply-To: <1145258753.3417.5.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Hi, Jeff
> 
> When reading ahci_port_start(), I found the
> following code segments:
> 
> .......
> if (hpriv->cap & HOST_CAP_64)
>         writel((pp->cmd_slot_dma >> 16) >> 16, port_mmio +
> PORT_LST_ADDR_HI);
>         writel(pp->cmd_slot_dma & 0xffffffff, port_mmio +
> PORT_LST_ADDR);
>         readl(port_mmio + PORT_LST_ADDR); /* flush */
> ......
> 
> I can't figure out why you use ">>16>>16" instead of
> ">>32" for right-shift 32 bits.
> 

dma_addr_t is 32bits on some architectures and C hates when you do 32 
bit shift to 32bit variable.

$ cat test.c
#include <sys/types.h>

int main(void)
{
	u_int32_t t = 1234;
	t = t >> 32;
	return 0;
}

$ gcc test.c
test.c: In function 'main':
test.c:6: warning: right shift count >= width of type

-- 
tejun
