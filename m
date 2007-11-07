From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] libata: Support PIO polling-only hosts.
Date: Wed, 7 Nov 2007 23:53:26 +0900
Message-ID: <20071107145326.GA27752@linux-sh.org>
References: <20071107081052.GA25913@linux-sh.org>
	<20071107130940.16b5ea86@the-village.bc.nu>
	<20071107132702.GA27488@linux-sh.org> <4731C71A.4000406@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4731C71A.4000406@rtr.ca>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 07, 2007 at 09:09:30AM -0500, Mark Lord wrote:
> Paul Mundt wrote:
> >On Wed, Nov 07, 2007 at 01:09:40PM +0000, Alan Cox wrote:
> >>On Wed, 7 Nov 2007 17:10:52 +0900
> >>Paul Mundt <lethal@linux-sh.org> wrote:
> >>>By default ata_host_activate() expects a valid IRQ in order to
> >>>successfully register the host. This patch enables a special case
> >>>for registering polling-only hosts that either don't have IRQs
> >>>or have buggy IRQ generation (either in terms of handling or
> >>>sensing), which otherwise work fine.
> >>>
> >>>Hosts that want to use polling mode can simply set ATA_FLAG_PIO_POLLING
> >>>and pass in a NULL IRQ handler or invalid (< 0) IRQ.
> >>NAK
> >>
> >>Zero is "no IRQ", please use that for polling not "< 0"
> >>
> >However, platform_get_irq() will happily return IRQ#0, and it's a valid
> >vector on plenty of machines. NO_IRQ is also < 0 on at least FR-V, ARM,
> >blackin, PA-RISC, some PowerPC, and even IDE.
> 
> Too bad.  The Penultimate Penguin wants zero to continue to mean "no IRQ".
> 
> Dig into the archives for multiple threads on this exact topic.
> The end result is that "0" means "no IRQ".  If your physical IRQ actually
> is the number 0, then reencode it to some other value for this purpose.
> 
I've read the threads, but this does little to do with the fact it's
still a perfectly valid vector, and I'm not about to force every IRQ
vector on my platform off-by-1 in order to satisfy a religious point of
view with zero reflection on what the hardware actually looks like.

So I'll change the check to IRQ#0 == invalid, but if that's to be
enforced kernel-wide, then all of the existing NO_IRQ cases should be
ripped out and set to 0. This way at least people are getting screwed
consistently, rather than just in particular subsystems.

> Yes, a bit of pain, but that's how many parts of the kernel expect it,

Just as many parts of the kernel make no such assumption.

> and in the end it's no more overall hassle than doing it differently might
> have been.
> 
Spoken like someone who doesn't have to contend with off-by-1 IRQ
vectors as a result of an entirely cosmetic change. It's certainly easier
to parrot a party line when you aren't being bitten by it.

So again, I'll make the change, but it's utter nonsense.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
