From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 10/10] ide-floppy: replace ntoh{s,l} and hton{s,l} calls with the generic byteorder macros
Date: Fri, 4 Jan 2008 02:29:04 +0100
Message-ID: <200801040229.04956.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-10-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-11-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61225 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYADBTc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 20:19:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2729246ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 17:19:31 -0800 (PST)
In-Reply-To: <1199366409-26016-11-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 03 January 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

minor thing:

WARNING: line over 80 characters
#88: FILE: drivers/ide/ide-floppy.c:759:
+               put_unaligned(cpu_to_be16(blocks), (unsigned short *) &pc->c[7]);

seems like it can be fixed by removing space between '(unsigned short *)'
and '&pc->c[7]'

otherwise looks good, please move it at the beginning of the patch series

PS I need some sleep so the rest of patches have to wait till tomorrow...
