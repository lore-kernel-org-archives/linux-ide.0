From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] PCMCIA: Add another MemoryCard to ide-cd/pata_pcmcia
Date: Wed, 11 Jul 2007 00:16:43 +0200
Message-ID: <200707110016.43152.bzolnier@gmail.com>
References: <200707101137.25955.openembedded@hrw.one.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:21068 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761284AbXGJWEt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1434490ugf
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:49 -0700 (PDT)
In-Reply-To: <200707101137.25955.openembedded@hrw.one.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>


[ please always cc: linux-ide@ on ATA patches ]

^
s/ide-cd/ide-cs/ ;-)

On Tuesday 10 July 2007, Marcin Juszkiewicz wrote:
> From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
> 
> One card submitted by user.
> 
> Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

This patch doesn't apply because of whitespace damage
(all spaces were converted to tabs).

I fixed it manually and applied.

Thanks,
Bart
