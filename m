From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: force PIO on IOMEGA
 ZIP 250 ATAPI
Date: Sun, 10 Jun 2007 16:22:30 +0100
Message-ID: <20070610162230.52f9ec81@the-village.bc.nu>
References: <20070610055236.GI29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59387 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751510AbXFJPRV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jun 2007 11:17:21 -0400
In-Reply-To: <20070610055236.GI29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, calvin.walton@gmail.com

On Sun, 10 Jun 2007 14:52:36 +0900
Tejun Heo <htejun@gmail.com> wrote:

> IOMEGA ZIP 250 ATAPI claims MWDMA0 support but fails SETXFERMODE if
> asked to configure itself to MWDMA0.  Force PIO.

This is only really a temporary fix. It appears to manage MWDMA0 in some
cases with old IDE..
