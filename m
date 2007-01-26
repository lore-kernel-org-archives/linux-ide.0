From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET] libata: PATA driver	for Celleb
Date: Fri, 26 Jan 2007 02:46:21 -0500
Message-ID: <45B9B1CD.4040600@garzik.org>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43440 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030718AbXAZHq2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jan 2007 02:46:28 -0500
In-Reply-To: <200701260724.l0Q7OISY027645@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, alan@lxorguk.ukuu.org.uk

Akira Iguchi wrote:
> Dear everyone.
> 
> Thank you for many useful comments.
> This is the latest patchset for the PATA controller of Celleb. 
> 
> This patchset consists of
> [1] add another IRQ calls (core and headers)
> [2] add another IRQ calls (libata drivers)
> [3] PATA driver for Celleb
> 
> And patch[3] depends on patch[1,2].
> 
> This patchset is based on the Tejun's "devres" git tree, which is
> available at the followin URL.

Everything looks great, thanks!

I'll apply this patchset immediately after applying Tejun's devres patchset.

	Jeff



