From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Subject: Re: [1/2] 2.6.21-rc7: known regressions
Date: Sun, 15 Apr 2007 20:21:07 -0600
Message-ID: <20070416022107.GA21432@ellpspace.math.ualberta.ca>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org> <20070416003714.GL3691@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070416003714.GL3691@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Dave Jones <davej@redhat.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Apr 16, 2007 at 02:37:14AM +0200, Adrian Bunk wrote:
> 
> Subject    : kernels fail to boot with drives on ATIIXP controller
>              (ACPI/IRQ related)
> References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=229621
c              http://lkml.org/lkml/2007/3/4/257
> Submitter  : Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
> Status     : unknown

Sigh!  Again!  AFAICT the current "rc" kernels should boot
using 'pata_atiixp' driver _provided_ I will use 'acpi=off'.
At least on the hardware in question.  More details at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=229621#c10

OTOH I mentioned few times that another machine, which want
to use 'pata_via' fails to read _anything_ from a disk.  See
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=234650
Mentioned there 2.6.20-1.3054.fc7 really corresponds to
2.6.21-rc6-git1 (AFAICT).

   Michal
