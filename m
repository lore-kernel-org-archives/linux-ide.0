From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_sil: int slow_down uninitialized
Date: Sat, 5 Jul 2008 12:20:30 +0100
Message-ID: <20080705122030.13bb3523@lxorguk.ukuu.org.uk>
References: <1215248332.3396.16.camel@nigel-x60>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751570AbYGELiI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 07:38:08 -0400
In-Reply-To: <1215248332.3396.16.camel@nigel-x60>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nigel Kukard <nkukard@lbsd.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sat, 05 Jul 2008 08:58:52 +0000
Nigel Kukard <nkukard@lbsd.net> wrote:

> Hi Guys,
> 
> Maybe I'm wrong, but line 247 of sata_sil...
> static int slow_down;
> 
> is not initialized and used on line 540.

Static variables start at zero unless initialised explicitly - C language
says that.
