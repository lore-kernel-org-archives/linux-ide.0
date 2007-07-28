From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Store bus addresses (versus -mm for testing)
Date: Sat, 28 Jul 2007 12:55:54 +0100
Message-ID: <20070728125554.532e8954@the-village.bc.nu>
References: <20070726192315.61ffe93d@the-village.bc.nu>
	<46AAFA3E.50407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44235 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755590AbXG1LxC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 07:53:02 -0400
In-Reply-To: <46AAFA3E.50407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

> Eeeek... I don't think this is a good idea.  I liked the getting
> original address from mapped address thing.  Is it impossible to get
> that working on some archs?  Or is it just not there yet?

Its basically impossible. Either the platform or the libata code would
have to keep a copy of the bus and virtual mappings for the various
devices. If the arch layers do it then we have to fix each architecture
and track all the iomaps where the info is not in fact needed.

Alan
