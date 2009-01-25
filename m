From: Mark Lord <liml@rtr.ca>
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Sun, 25 Jan 2009 13:04:28 -0500
Message-ID: <497CA9AC.7030208@rtr.ca>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan> <20090125110742.4ba54c0b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55615 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbZAYSEc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jan 2009 13:04:32 -0500
In-Reply-To: <20090125110742.4ba54c0b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
..
> Mount by label also means you can flip back and forth between the
> different drivers and kernel revisions.
..

That only works with an initrd or initramfs,
not with kernel-only boots.  Real P.I.T.A. that is.
