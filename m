From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/12] libata: convert the remaining PATA drivers to new
 init model
Date: Fri, 9 Mar 2007 12:49:15 +0000
Message-ID: <20070309124915.444fa871@lxorguk.ukuu.org.uk>
References: <1173438935540-git-send-email-htejun@gmail.com>
	<11734389363614-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39002 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932184AbXCILpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:45:08 -0500
In-Reply-To: <11734389363614-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> Tested pdc_adma and pata_legacy.  Both are as broken as before.  The
> rest are compile tested only.

pata_legacy should be working. If you are using the Jeff/Linus tree
you'll need to remove the buggy crap for ACPI and then test.

It does still leave ports around and I need to find a sane way to probe
for an ATA port presence before using libata (or have a 'no drives go
away' action)


Other than the one noted NAK point the rest of the core changes look good
to me and the PATA ones sane, as well as good cleanups.

Acked-by: Alan Cox <alan@redhat.com>
