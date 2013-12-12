From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] libata: provide the ability to disable a disk via the
 params.
Date: Thu, 12 Dec 2013 20:47:39 +0000
Message-ID: <robbat2-20131212T204111-907351030Z@orbis-terrarum.net>
References: <1386464187-6993-1-git-send-email-robbat2@gentoo.org>
 <20131212133935.GA32683@htj.dyndns.org>
 <robbat2-20131212T200207-028507804Z@orbis-terrarum.net>
 <52AA1E67.6000801@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:57626 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab3LLUrk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Dec 2013 15:47:40 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 740CC33F2D1
	for <linux-ide@vger.kernel.org>; Thu, 12 Dec 2013 20:47:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <52AA1E67.6000801@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Dec 12, 2013 at 09:36:55PM +0100, Levente Kurusa wrote:
> > 2. One of my friends wondered if it would be worthwhile to add force
> > keywords for other HORKAGE bits, and if so, should the
> > ata_lflag/ata_link force bits also be presented?
> I don't think so. Most of the other HORKAGEs are automatically
> recognized and applied by the code. I think the only ones
> which can cause trouble if not detected at first are the ones that are
> currently in the list.
His logic was thinking that it will aid debugging/testing on new buggy
devices if the options are available at boot.

I'd think of the following as candidates for that:
ATA_HORKAGE_NODMA
ATA_HORKAGE_MAX_SEC_128
ATA_HORKAGE_DIAGNOSTIC
ATA_HORKAGE_BROKEN_HPA
ATA_HORKAGE_DISABLE
ATA_HORKAGE_HPA_SIZE
ATA_HORKAGE_IVB
ATA_HORKAGE_STUCK_ERR (only set by code presently, not by blacklist)
ATA_HORKAGE_BRIDGE_OK
ATA_HORKAGE_ATAPI_MOD16_DMA
ATA_HORKAGE_NOSETXFER
ATA_HORKAGE_MAX_SEC_LBA48

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
