From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] libata: Support PIO polling-only hosts.
Date: Wed, 7 Nov 2007 22:27:02 +0900
Message-ID: <20071107132702.GA27488@linux-sh.org>
References: <20071107081052.GA25913@linux-sh.org>
	<20071107130940.16b5ea86@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20071107130940.16b5ea86@the-village.bc.nu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Nov 07, 2007 at 01:09:40PM +0000, Alan Cox wrote:
> On Wed, 7 Nov 2007 17:10:52 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > By default ata_host_activate() expects a valid IRQ in order to
> > successfully register the host. This patch enables a special case
> > for registering polling-only hosts that either don't have IRQs
> > or have buggy IRQ generation (either in terms of handling or
> > sensing), which otherwise work fine.
> > 
> > Hosts that want to use polling mode can simply set ATA_FLAG_PIO_POLLING
> > and pass in a NULL IRQ handler or invalid (< 0) IRQ.
> 
> NAK
> 
> Zero is "no IRQ", please use that for polling not "< 0"
> 
However, platform_get_irq() will happily return IRQ#0, and it's a valid
vector on plenty of machines. NO_IRQ is also < 0 on at least FR-V, ARM,
blackin, PA-RISC, some PowerPC, and even IDE.

We do have some devices that are physically on IRQ#0 that otherwise work
fine, they aren't ATA devices mind you, but to claim that IRQ#0 isn't a
valid vector is not in line with what hardware actually does, whether
it's a good idea or not. In our case the IRQ vector maps to an exception
offset, which we bump down to zero. We could force an off-by-1 there so
that the math that indexes IRQ#0 is bumped up one, but that entails
fixing up every one of our IRQ numbers for no obvious gain.

I don't really see any value in purposely crippling the range of
allowable vectors for these machines. Though I don't mind switching to a
NO_IRQ comparison instead of the < 0 case, so both can be handled.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
