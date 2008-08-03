From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Sun, 3 Aug 2008 20:17:19 +0100
Message-ID: <20080803201719.576f85f6@lxorguk.ukuu.org.uk>
References: <1217779055.4179.10.camel@localhost.localdomain>
	<20080803173941.314edf33@lxorguk.ukuu.org.uk>
	<1217783433.4179.18.camel@localhost.localdomain>
	<20080803194501.24fa3e51@lxorguk.ukuu.org.uk>
	<1217791284.4179.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758880AbYHCTen@vger.kernel.org>
In-Reply-To: <1217791284.4179.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> I don't envisage anything in terms of code changes (or removal) coming
> out of this.  What I would like is a nice roadmap of where to start for
> people contemplating writing IDE drivers.

For the vendors I've talked with the answer is usually "both". A libata
driver for the future and current distributions, and an old IDE driver
for older RHEL and SLES releases. Fortunately the driver specific parts
for those that are capable of running under old IDE are not too hard to
plug into libata.

Alan
