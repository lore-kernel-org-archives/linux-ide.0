From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 20/21] ide-floppy: merge idefloppy_{input,output}_buffers
Date: Sat, 12 Jan 2008 21:19:16 +0100
Message-ID: <200801122119.16517.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-20-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-21-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:21021 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759287AbYALUUI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640530ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:07 -0800 (PST)
In-Reply-To: <1200052699-28420-21-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> We merge idefloppy_{input,output}_buffers() into idefloppy_io_buffers() by
> introducing a 4th arg. called direction. According to its value
> we atapi_input_bytes() or atapi_output_bytes(). Also, simplify the interrupt

This change is fine but ...

> handler by removing multiple calls testing the data direction and using a local
> variable instead.

... the patch replaces 'test_bit(PC_WRITING, &pc->flags)' check with
'rq_data_dir(rq) == WRITE' one.  While this may look as "trivial" change it
is not such.  It should be done only after auditing the driver and making
sure that we are not introducing subtle regressions (=> I see that some
commands are setting PC_WRITING but are not setting REQ_RW bit), especially
given that these changes were not tested with the real hardware.

Please separate this change to another (post-)patch.

PS It would also be nice to remove IDEFLOPPY_DEBUG_BUGS define in a pre-patch.
