From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Mon, 16 Jan 2012 11:25:09 -0800
Message-ID: <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
References: <20120109003255.GA6598@havoc.gtf.org> <CA+55aFwcBQSoWfqdT9CxV=GAr5ex0=RnqtBDFty+=_Lua2VXGw@mail.gmail.com>
 <4F12E57E.3090805@garzik.org> <1326676534.13517.3.camel@minggr> <1326691403.13517.21.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326691403.13517.21.camel@minggr>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 15, 2012 at 9:23 PM, Lin Ming <ming.m.lin@intel.com> wrote:
>
> Set SATA mode to IDE on my machine can reproduce this problem.
> The cause is that ata port async suspend was not enabled yet.

Yup. Your patch helps.

But why don't we fix the silly legacy mode thing? Yeah, Apple's
firmware is crap and doesn't tend to initialize things, but still - we
should have at least an option to not use the legacy PIIX mode just
because the chipset wasn't programmed for AHCI by the bootup.

That would also help with people who have a BIOS that has the option,
but where the person hadn't noticed, and left it in legacy mode.

The IO ports are all there, the *only* reason we don't use AHCI seems
to be that the firmware didn't turn off the legacy bit, so it doesn't
show as an AHCI interface. That's kind of sad.

                Linus
