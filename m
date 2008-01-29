From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Problem with ata layer in 2.6.24
Date: Tue, 29 Jan 2008 17:12:19 +0000
Message-ID: <20080129171219.53a8efed@core>
References: <200801272122.21823.gene.heskett@gmail.com>
	<1201539043.31293.7.camel@zem>
	<1201540830.6526.19.camel@localhost>
	<200801281230.32910.gene.heskett@gmail.com>
	<alpine.LNX.1.00.0801281248190.13593@iabervon.org>
	<479E1D9E.3000900@bobjweil.com>
	<20080129121201.2f727f5f@core>
	<479F5D29.1020705@bobjweil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60065 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753833AbYA2RQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 12:16:51 -0500
In-Reply-To: <479F5D29.1020705@bobjweil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rgheck <rgheck@bobjweil.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>, Gene Heskett <gene.heskett@gmail.com>, Zan Lynx <zlynx@acm.org>, Calvin Walton <calvin.walton@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ide Mailing list <linux-ide@vger.kernel.org>

  
> Is this >4GB or >=4GB? I've seen contradictory reports, and I've got 4GB.

Depends how the memory is mapped. Any memory physically above the 4GB
boundary

Alan
