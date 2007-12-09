From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: change timing register masks
Date: Sun, 9 Dec 2007 18:10:40 +0100
Message-ID: <200712091810.40436.bzolnier@gmail.com>
References: <200712082049.20731.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:3396 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbXLIS5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 13:57:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1357943ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 10:57:24 -0800 (PST)
In-Reply-To: <200712082049.20731.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 08 December 2007, Sergei Shtylyov wrote:
> Since PIO autotuning is now done always, there's no need anymore to program
> the taskfile timings also on DMA modes, so chenge the IDE timing register
> masks accordingly, "inverting the polarity" of the masks while at it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied with a whitespace fix to shut up checkpatch.pl:

ERROR: use tabs not spaces
#66: FILE: drivers/ide/pci/hpt366.c:718:
+^I^I^I^I ^I^I^I  0x303c0000);$
