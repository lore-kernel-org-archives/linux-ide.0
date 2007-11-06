From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt37x: Fix outstanding bug reports on the HPT374
 and 37x cable detect
Date: Tue, 6 Nov 2007 10:40:47 +0000
Message-ID: <20071106104047.3710f53a@the-village.bc.nu>
References: <20071105225338.20ef476f@the-village.bc.nu>
	<20071105184245.e45bc3b9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45528 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754215AbXKFKkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:40:23 -0500
In-Reply-To: <20071105184245.e45bc3b9.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> hm, pci_resource_start() returns a resource_size_t and I guess this (and a
> heck of a lot of other) code is bust on (whatever machine we added that for).

inl takes an unsigned long.

pci_resource_start historically was 32bit and became 64bit so we should
have no problems.
