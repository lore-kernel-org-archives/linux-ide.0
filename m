From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Cable detection fixes
Date: Fri, 2 Mar 2007 12:45:34 +0000
Message-ID: <20070302124534.5fcfec9f@lxorguk.ukuu.org.uk>
References: <20070301173003.5d5ab4a6@lxorguk.ukuu.org.uk>
	<45E77D60.0@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41330 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422826AbXCBLlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 06:41:32 -0500
In-Reply-To: <45E77D60.0@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@osdl.org

> However, given that we are in -rc cycle, and the wide impact of this 
> change, this patch wants splitting.  The ->cable_detect stuff should be 
> in a separate patch from the IDENTIFY DEVICE ordering stuff.  This 
> ensures sanity when git-bisecting changes, and allows fast-tracking of 
> the identify-ordering change.

Fine by me - I carefully sent Linus the hook but no changes using it and
sent those changes just to the list/you.

Alan
