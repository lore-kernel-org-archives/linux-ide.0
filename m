From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/8] ide: make legacy IDE VLB modules check for the
 "probe" kernel params
Date: Wed, 14 Feb 2007 10:53:29 +0000
Message-ID: <20070214105329.3cc6ec27@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
	<20070214015712.4619.78705.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49247 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751558AbXBNKjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 05:39:32 -0500
In-Reply-To: <20070214015712.4619.78705.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 14 Feb 2007 02:57:12 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> [PATCH] ide: make legacy IDE VLB modules check for the "probe" kernel params
> 
> Legacy IDE VLB host drivers didn't check for "probe" options when compiled
> as modules, which was obviously wrong as we don't want module to poke at
> random I/O ports by simply loading it.  Fix it by adding "probe" module param
> to legacy IDE VLB host drivers and obsolete old "ide0=dtc2278", "ide0=ht6560b",
> "ide0=qd65xx", "ide0=ali14xx", "ide0=umc8672" IDE driver options.

No point obsoleting the old ones. By the time being obsolete turns into
being anything like "gone", the hardware won't exist. It just causes
questions, confusion, noise and hassle, leave the old options be and make
the module options work too.

Alan
