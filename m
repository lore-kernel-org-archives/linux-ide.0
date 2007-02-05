From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream 2/2] pata_amd: don't configure udma
 mode faster than BIOS did
Date: Mon, 5 Feb 2007 13:26:10 +0000
Message-ID: <20070205132610.46f5f4fd@localhost.localdomain>
References: <20070205080518.GI1625@htj.dyndns.org>
	<20070205080801.GJ1625@htj.dyndns.org>
	<20070205112533.611558c2@localhost.localdomain>
	<45C724E3.6000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40881 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932378AbXBENNW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 08:13:22 -0500
In-Reply-To: <45C724E3.6000909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> 2. We don't have any way to detect cable type reliably on that
> controller, so getting cable type correctly automatically on hotplug is
> impossible anyway.

Ask the drive. For the cases where controller logic is unreliable return
CBL_UNK and let the drive deal with it. If the drive is wrong AND the
controller is wrong then the error handling logic will resolve it.

Alan
