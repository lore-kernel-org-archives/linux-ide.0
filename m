From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: libata-acpi: allow _GTF on SATA, but disable on PATA for now
Date: Mon, 12 Mar 2007 09:55:28 -0700
Message-ID: <20070312095528.3dd7a693.kristen.c.accardi@intel.com>
References: <200703100559.l2A5x6kP017578@hera.kernel.org>
	<45F296B9.7000005@garzik.org>
	<20070310164059.4ba68bcc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34277 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030673AbXCLQ6W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 12:58:22 -0400
In-Reply-To: <20070310164059.4ba68bcc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, len.brown@intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, 10 Mar 2007 16:40:59 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Instead merge the one that fixe the non PCI
> crashes and we might get further.

In bugzilla #7907 you could post your patch and see if the reporters there
can at least confirm that it fixes their problem.

Meanwhile, to solve the problem for these people, and without introducing
a lot of new code at this stage in the release, perhaps you can suggest 
a more accurate way to detect PATA vs. SATA so we can fix the bug?  Either 
that or Len should drop the ATA ACPI support from 2.6.21 altogether and
we should try to coordinate our efforts better for 2.6.22.  The alternative
to dropping the ACPI support is to set the default for libata.acpi to off.

Thanks,
Kristen
