From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 01/10] move ide-floppy historical changelog to Documentation/ide/ChangeLog.ide-floppy.1996-2002;
Date: Fri, 4 Jan 2008 01:36:56 +0100
Message-ID: <200801040136.56767.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-2-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61267 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbYADBT2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 20:19:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2729251ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 03 Jan 2008 17:19:27 -0800 (PST)
In-Reply-To: <1199366409-26016-2-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 03 January 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied with two minor fixes (and sorry for being such a pedant ;):

* Summary line moved to patch description and "ide-floppy: cleanup header"
  used instead.  Please try to keep summary line within 80-columns limit,
  otherwise it makes git-log output etc ugly.

* I don't know why scripts/checkpatch.pl doesn't complain but quilt did:

  Warning: trailing whitespace in lines 44,46,61,62 of Documentation/ide/ChangeLog.ide-floppy.1996-2002

  so I fixed it manually.
