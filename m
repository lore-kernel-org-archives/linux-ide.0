From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] libata: pass host flags into
 __ata_pci_sff_init_one() helper
Date: Thu, 18 Feb 2010 23:33:12 +0000
Message-ID: <20100218233312.2f9a47c3@lxorguk.ukuu.org.uk>
References: <20100218185914.16594.61415.sendpatchset@localhost>
	<20100218185922.16594.98925.sendpatchset@localhost>
	<20100218214448.692552fd@lxorguk.ukuu.org.uk>
	<201002182341.02203.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55224 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040Ab0BRX3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Feb 2010 18:29:35 -0500
In-Reply-To: <201002182341.02203.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> - __ has been also used for exactly such purpose in the kernel, i.e.:

As helpers for inlines and like the yes... 

Matter of style anyway.
