From: Fabio Coatti <cova@ferrara.linux.it>
Subject: Re: [PATCH,RFT] SATA interrupt handling
Date: Sun, 4 Jul 2004 14:14:49 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407041414.49953.cova@ferrara.linux.it>
References: <40E77352.5090703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mid-1.inet.it ([213.92.5.18]:41900 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S265545AbUGDMRN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jul 2004 08:17:13 -0400
In-Reply-To: <40E77352.5090703@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Erik Andersen <andersen@codepoet.org>

Alle 05:02, domenica 4 luglio 2004, Jeff Garzik ha scritto:

> Attached is the latest SATA patch (and BK info).
>
> When I turned on the PATA support in libata to do some ATAPI development
> on my ICH5, I reproduced the behavior that Fabio Coatti was seeing on
> his box.  This patch fixed my PATA interface, here's hoping it fixes
> Fabio's problem as well.

Yes, I can confirm that this patch fixes my problem as well. (tested against 
2.6.7-mm5).
Now my box boots just fine, good work!


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
