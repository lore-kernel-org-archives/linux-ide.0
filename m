From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][pata] ide: cable detection fixes
Date: Sun, 11 Feb 2007 23:08:40 +0000
Message-ID: <20070211230840.06c1f38b@localhost.localdomain>
References: <200702112324.21704.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50859 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932845AbXBKWy7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 17:54:59 -0500
In-Reply-To: <200702112324.21704.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

> * use eighty_ninty_three() in ide_ata66_check(), this actually fixes 3 bugs:
>   - bit 13 (word 93 validity check) == 1 and bit 12 (80-wire cable test) == 0
>     configuration was incorrectly treated as a 80-wire cable present

I think you mean bit 14 and bit 13. And for validity you must check bits
14/15 together as 0x01. Code seems to have the bits right not the
comment, but doesn't check bit 15.

You also change the IVB behaviour from assuming drives would set either
the correct bit and/or the valid bit, to drives must always set the
correct bit but not neccessarily valid. It would be nice to know if that
is intentional as the original IVB hack is murky early ATA standard
history and I am not sure what the drive id error in question actually
was ?

Alan
