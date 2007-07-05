From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc7] libata: quirk IOMEGA ZIP 250 ATAPI FLOPPY
Date: Thu, 5 Jul 2007 13:39:26 +0100
Message-ID: <20070705133926.66050cce@the-village.bc.nu>
References: <20070705033131.GW29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44486 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758400AbXGEMdK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 08:33:10 -0400
In-Reply-To: <20070705033131.GW29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, bruinjm@xs4all.nl

> but IDE simply ignores the error and continues to operate in MWDMA
> mode, so I guess we can remove the 'temporary fix' comment or add
> another quirk type - ATA_HORKAGE_SETXFER_MAY_FAIL - and use it.

Should we warn in these cases ? Or issue a new identify and check the
mode activated ?

Alan
