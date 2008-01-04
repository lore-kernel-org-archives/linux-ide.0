From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 03/10] ide-floppy: convert to generic packet commands
Date: Fri, 4 Jan 2008 02:04:04 +0100
Message-ID: <200801040204.04816.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-3-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-4-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61225 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbYADBT3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 20:19:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2729246ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 17:19:28 -0800 (PST)
In-Reply-To: <1199366409-26016-4-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>

On Thursday 03 January 2008, Borislav Petkov wrote:
> Replace the ide-floppy packet commands opcode defines with the generic ones.
> Add a missing GPCMD_WRITE_12 (opcode 0xaa) to the generic ones in cdrom.h. The
> last one can be found in the current version of INF-8090, p.905.
> 
> CC: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

please move this patch at the beggining of the patch series so it can be
applied immediately (patch #2 needs some more work)

> ---
>  drivers/ide/ide-floppy.c |   26 +++++++++++++-------------
>  drivers/ide/ide-floppy.h |   21 ---------------------

Please also note that patch #2 moved these defines to ide-floppy.h and now
patch #3 removes them so by re-ordering patches you can make patch #2 simpler.

[ This is a general hint for optimizing patches to make them smaller and easier
  to maintain, it also makes reviewer's job easier. ]

[...]

> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -480,6 +480,7 @@ struct cdrom_generic_command
>  #define GPCMD_TEST_UNIT_READY		    0x00
>  #define GPCMD_VERIFY_10			    0x2f
>  #define GPCMD_WRITE_10			    0x2a
> +#define GPCMD_WRITE_12			    0xaa	/* ide floppy */

0xaa is a generic SCSI opcode so the above comment is not necessary

>  #define GPCMD_WRITE_AND_VERIFY_10	    0x2e
>  /* This is listed as optional in ATAPI 2.6, but is (curiously) 
>   * missing from Mt. Fuji, Table 57.  It _is_ mentioned in Mt. Fuji
