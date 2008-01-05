From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 09/10] ide-floppy: use test_bit wrappers for testing flags
Date: Sat, 5 Jan 2008 17:10:58 +0100
Message-ID: <200801051710.58924.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-9-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-10-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:7645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbYAEP75 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 10:59:57 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2920584ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 07:59:56 -0800 (PST)
In-Reply-To: <1199366409-26016-10-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


There are two issues here:

* set_bit()/test_bit() are atomic operations and they don't see to be
  necessary in case of ide-floppy.c (standard '|'/'&' should be enough)

* using wrappers for these operations is not a bad idea but doing it _now_
  just makes it harder for us to figure out how to introduced common ATA
  Packet command interface for all ATAPI device drivers (the other drivers
  are using very similar flag handling and flag names currently)

so I would say that we should defer introducting these wrappers for now
(patch converting set_bit()/test_bit() to '|'/'&' would still be welcomed).

On Thursday 03 January 2008, Borislav Petkov wrote:
> also, fix header comments and remove superfluous ones. There should be no
> functionality change resulting from this patch.

fixes for comments look fine but they should be merged with the other
patch (the one containing checkpatch.pl/comments fixes)

Thanks,
Bart
