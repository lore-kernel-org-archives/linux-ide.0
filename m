From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/4] ide: generic packet command representation
Date: Tue, 12 Feb 2008 01:09:24 +0100
Message-ID: <200802120109.24152.bzolnier@gmail.com>
References: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:11111 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334AbYBLANC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 19:13:02 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1341853nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 16:13:01 -0800 (PST)
In-Reply-To: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


On Monday 11 February 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's the ide_atapi_pc unification series. It all went pretty smoothly along
> the search & replace line. Using driver-specific members in ide_atapi_pc like
> idefloppy_callback and idetape_callback is kinda dumb but this approach seemed
> the fastest versus unnecessary callback function signature change that will
> touch stuff all over the place. Besides, ide-tape might be gone soon so that
> would alleviate the problem.

applied all four patches, thanks!

> On a different note, i noticed ide-scsi might also need a cleanup similar to the
> other drivers. It is next on my TODO list in case you don't have anything with a
> higher prio.

I was actually hoping that you'll continue unifying ATAPI handling...

[ ide-scsi is orphaned and has (probably) unfixable problems (because of having
  dependencies on both IDE and SCSI subsystems) so it is not worth IMO but I will
  of course accept patches... ]

Thanks,
Bart
