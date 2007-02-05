From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c
 cable check
Date: Mon, 5 Feb 2007 10:57:44 +0000
Message-ID: <20070205105744.6f22fc7d@localhost.localdomain>
References: <20070205074535.GE1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46807 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbXBEKqN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 05:46:13 -0500
In-Reply-To: <20070205074535.GE1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

On Mon, 5 Feb 2007 16:45:35 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The 80c wire bit is bit 13, not 14.  Bit 14 is always 1 if word93 is
> implemented.  This increases the chance of incorrect wire detection
> especially because host side cable detection is often unreliable and
> we sometimes soley depend on drive side cable detection.  Fix it.

NAK to the fix but not the report

We must check bits 15 and 14 to know if bit 13 is valid. The old code is
wrong (follows the old IDE bits) but your change is probably no better as
you remove the needed validity check.

	if ((dev_id[93] & 0xC000) == 0x4000) && (dev_id[93] & 0x2000))
		return 0;

Alan
