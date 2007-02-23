From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-eh: Add a simple mechanism for silencing error
 reporting
Date: Fri, 23 Feb 2007 12:10:40 +0000
Message-ID: <20070223121040.3c67b16f@lxorguk.ukuu.org.uk>
References: <20070205161124.48bf16c6@localhost.localdomain>
	<45DEC179.1080308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59286 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932281AbXBWLGz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 06:06:55 -0500
In-Reply-To: <45DEC179.1080308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

> I would rather pass an ok-to-fail-without-recovery type flag to EH. 
> This TFLAG_QUIET approach is poorly defined, probably temporary, and not 
> really interesting for upstream

Fail without recovery flags make sense, but then we also need to ensure
it is a fail without recovery messages. We could add qc->ignore_mask to
mirror qc->err_mask ?

Alan

