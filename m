From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Date: Fri, 17 Oct 2008 15:42:49 +0100
Message-ID: <20081017154249.5fd0e7d3@lxorguk.ukuu.org.uk>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
	<20081017141310.GA14999@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20081017141310.GA14999@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, sshtylyov@ru.mvista.com
List-Id: linux-ide@vger.kernel.org

> Btw, I don't think architecture specific subdirectories in subsystems are
> generally usefull.  Just as in this example this IDE controller happens
> only to be in use on a particular MIPS-based SOC but there is nothing
> really architecture specific in most such devices.

Well drivers/ide is legacy stuff anyway and on its slow way out but it has
always had architecture subdirectories so it isn't a material change.

Alan
