From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Early CFA adapters are not required to support
 mode setting
Date: Mon, 5 Feb 2007 23:11:52 +0000
Message-ID: <20070205231152.59527980@localhost.localdomain>
References: <20070205162830.5f9cff4a@localhost.localdomain>
	<20070205145220.4eb3269b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58904 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965050AbXBEW7F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 17:59:05 -0500
In-Reply-To: <20070205145220.4eb3269b.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

> libata-fix-hopefully-all-the-remaining-problems-with.patch.  Should I drop
> libata-fix-hopefully-all-the-remaining-problems-with.patch?

The hopefully fix all the remaining problems patch did say not to merge
it I thought. Please don't merge it yet - Jeff has asked for some
improvements and its not fixing the cases under investigation so it'll
confuse stuff rather than help at the moment.

Alan
