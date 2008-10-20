From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
Date: Tue, 21 Oct 2008 00:08:50 +0900 (JST)
Message-ID: <20081021.000850.08318458.anemo@mba.ocn.ne.jp>
References: <48FB7D9E.4030803@ru.mvista.com>
	<20081020.231450.51866269.anemo@mba.ocn.ne.jp>
	<48FC9878.4030306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <48FC9878.4030306@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org
List-Id: linux-ide@vger.kernel.org

On Mon, 20 Oct 2008 18:40:56 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Do you mean I should use IDE_HFLAG_NO_SET_MODE instead of just
> > returning from set_pio_mode?
> 
>     No, that's for the smart RAID controllers that program the transfer modes 
> themselves. In your case, hwif->port_ops->set_pio_mode() must be NULL -- if 
> you're not going to allow the mode programming, that is.

I see.  Thanks.

---
Atsushi Nemoto
