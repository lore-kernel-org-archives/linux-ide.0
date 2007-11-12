From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: possibly a dumb question about sb600/700
Date: Mon, 12 Nov 2007 13:16:40 +0000
Message-ID: <20071112131640.3bf0073c@the-village.bc.nu>
References: <47381768.2060803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48673 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758314AbXKLNRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 08:17:12 -0500
In-Reply-To: <47381768.2060803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: conke.hu@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 12 Nov 2007 18:05:44 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Hello,
> 
> I've been looking at PATA support for sb600 and 700 and found something
> weird.
> 
> * IDE atiixp.c has a separate entry for sb600 such that it only probes
> the first port but sb700 doesn't use the entry.  So, does sb600 has one
> PATA channel but sb700 has two?
> 
> * libata pata_atiixp.c doesn't have special handling for sb600's
> single-channeldness.  Is this okay?

Should be just fine as I understand it all anyway - the second channel
will have no resources assigned if absent which is handled by libata core
already.

Alan
