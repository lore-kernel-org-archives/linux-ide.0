From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SC1200 failure in 2.6.23 and 2.6.24-rc1-git10
Date: Wed, 7 Nov 2007 22:54:53 +0000
Message-ID: <20071107225453.34f8f340@the-village.bc.nu>
References: <20071101213013.M54162@visp.net.lb>
	<20071106221521.4f64a066.akpm@linux-foundation.org>
	<20071107132630.M65286@visp.net.lb>
	<4731D85E.70201@daa.com.au>
	<20071107160426.M31617@visp.net.lb>
	<47320E37.8010106@rtr.ca>
	<20071107211932.M35475@visp.net.lb>
	<47323CAF.2030102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46430 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752816AbXKGWy5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Nov 2007 17:54:57 -0500
In-Reply-To: <47323CAF.2030102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Denys Fedoryshchenko <denys@visp.net.lb>, James Andrewartha <jamesa@daa.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

> CFA spec requires 848a in word[0], not 844a, which explains
> why hdparm thought it might be ATAPI.  I've updated my hdparm
> source to detect this for hdparm-7.8 (unreleased).
> That card (16MB) is definitely buggy.
> But your other (1GB) card looks fine.
> 
> Thanks.  Somebody else may help with the libata issue.

848A is the preferred configuration value

The use of 044A is also allowed in the case of it being non-removable.
Guess someone got muddled up in the middle.

844A is a bit iffy and it should still be detectable as Word 83 bit 2
should be set ?


As to the old IDE (not libata ?) issue - I suspect a convertor without
DMA support as a first guess.

Alan
