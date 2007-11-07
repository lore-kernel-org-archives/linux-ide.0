From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Support PIO polling-only hosts.
Date: Wed, 7 Nov 2007 15:28:29 +0000
Message-ID: <20071107152829.244afe30@the-village.bc.nu>
References: <20071107081052.GA25913@linux-sh.org>
	<20071107130940.16b5ea86@the-village.bc.nu>
	<20071107132702.GA27488@linux-sh.org> <4731C71A.4000406@rtr.ca>
	<20071107145326.GA27752@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-bounces@lists.sourceforge.net>
In-Reply-To: <20071107145326.GA27752@linux-sh.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linuxsh-dev>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
Sender: linuxsh-dev-bounces@lists.sourceforge.net
Errors-To: linuxsh-dev-bounces@lists.sourceforge.net
To: Paul Mundt <lethal@linux-sh.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <lkml@rtr.ca>, Andrew Morton <akpm@linux-foundation.org>, linuxsh-dev@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

> So I'll change the check to IRQ#0 == invalid, but if that's to be
> enforced kernel-wide, then all of the existing NO_IRQ cases should be
> ripped out and set to 0. This way at least people are getting screwed
> consistently, rather than just in particular subsystems.

Thats been gradually happening. Its now pretty clean except for powerpc
and odd bits of ARM stuff

Alan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
