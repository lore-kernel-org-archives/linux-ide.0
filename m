From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 18/18] ide: use flags in IRQ handler
Date: Sat, 14 Jun 2008 19:47:55 +0200
Message-ID: <200806141947.55580.bzolnier@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-19-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:10415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbYFNRr0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 13:47:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3007218fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 10:47:25 -0700 (PDT)
In-Reply-To: <1213252870-20474-19-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Thursday 12 June 2008, Borislav Petkov wrote:
> Pass pc->flags to the IRQ handler from the drivers (ide-tape/floppy/scsi) thus
> making it more pc-unaware.

This moves the problem around without improving the overall situation
w.r.t. pc->flags (now ATAPI drivers are more pc-aware instead).

It also adds one more argument to the already overloaded ide_pc_intr()
(my fault, I went a bit overboard but I added a nice TODO explanation! ;).

Since there are better ideas on how to deal with pc->flags (you've even
described them yourself in the first mail :) I skipped this patch for now.
