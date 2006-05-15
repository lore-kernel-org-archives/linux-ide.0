From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 19:37:56 +0100
Message-ID: <1147718277.26686.89.camel@localhost.localdomain>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <20060515101831.0e38d131.akpm@osdl.org>  <4468C530.6080409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965116AbWEOSZl@vger.kernel.org>
In-Reply-To: <4468C530.6080409@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
List-Id: linux-ide@vger.kernel.org

On Llu, 2006-05-15 at 14:15 -0400, Jeff Garzik wrote:
> which persists on Sil 311x on rare motherboards.  The rest are either 
> addressed with the improved error handling, or are ATAPI + VIA AFAICS.

ATAPI + VIA to that pattern is also showing up on pata_via cases as
well, but only on via so far. Its as if there is a case where the IRQ of
the first command is lost sometimes.
