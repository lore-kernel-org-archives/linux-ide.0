From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22] remove Intel combined mode quirk
Date: Fri, 9 Mar 2007 17:29:47 +0000
Message-ID: <20070309172947.79ef61bf@lxorguk.ukuu.org.uk>
References: <20070309160127.GA10226@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38560 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767355AbXCIQZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 11:25:51 -0500
In-Reply-To: <20070309160127.GA10226@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

>     Signed-off-by: Jeff Garzik <jeff@garzik.org>

Acked-by: Alan Cox <alan@redhat.com>

and you can remove even more code as pci_request_resources() will now
just do the right thing for all cases.

