From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: fix drive side 80c
 cable check, take 3
Date: Mon, 5 Feb 2007 14:36:08 +0000
Message-ID: <20070205143608.1b3328b6@localhost.localdomain>
References: <20070205074535.GE1625@htj.dyndns.org>
	<20070205105744.6f22fc7d@localhost.localdomain>
	<20070205124106.GK1625@htj.dyndns.org>
	<20070205132706.1ff6d761@localhost.localdomain>
	<20070205142119.GM1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45996 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932842AbXBEOYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 09:24:46 -0500
In-Reply-To: <20070205142119.GM1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

On Mon, 5 Feb 2007 23:21:19 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The 80c wire bit is bit 13, not 14.  Bit 14 is always 1 if word93 is
> implemented.  This increases the chance of incorrect wire detection
> especially because host side cable detection is often unreliable and
> we sometimes soley depend on drive side cable detection.  Fix the test
> and add word93 validity check.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Sure, updated as suggested.

Acked-by: Alan Cox <alan@redhat.com>
