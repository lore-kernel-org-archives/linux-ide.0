From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Date: Mon, 20 Oct 2008 21:21:01 +0900 (JST)
Message-ID: <20081020.212101.106262120.anemo@mba.ocn.ne.jp>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
	<48FB2B27.3090906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <48FB2B27.3090906@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org
List-Id: linux-ide@vger.kernel.org

On Sun, 19 Oct 2008 16:42:15 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> >
> > This controller has standard ATA taskfile registers and DMA
> > command/status registers, but the register layout is swapped on big
> > endian.  There are some other endian issue and some special registers
> > which requires many custom dma_ops/tp_ops routines and build_dmatable.
> >
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >   
> 
>    Again, mostly ACK but there are some things that I haven't noticed 
> before...

Thanks, I'll address all and send v5 patch soon.

---
Atsushi Nemoto
