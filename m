From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 04/30] ACPI driver support for pata
Date: Tue, 6 Mar 2007 16:29:24 +0000
Message-ID: <20070306162924.2c06bcab@lxorguk.ukuu.org.uk>
References: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net>
	<45ED649A.20207@gmail.com>
	<20070306151415.45db1d52@lxorguk.ukuu.org.uk>
	<45ED7A27.3030504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:59776 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S965928AbXCFP0k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 10:26:40 -0500
In-Reply-To: <45ED7A27.3030504@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com, lenb@kernel.org

> Tejun is just repeating what I've been saying:  you don't need a 
> separate driver, call out from sata_nv or whereever instead.

You do need a separate driver because you've got no guarantee that the
PATA chip you are driving has a non-ACPI driver of any kind. For the
Nvidia PATA Tejun may be right, although it'll be very risky since you've
no idea what the ACPI methods decide to reconfigure the moment you start
touching the chip via ACPI and directly.

Alan
