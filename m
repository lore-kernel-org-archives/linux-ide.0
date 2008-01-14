From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/12] ide-floppy redux v2.5
Date: Mon, 14 Jan 2008 22:38:17 +0100
Message-ID: <200801142238.17282.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:2242 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbYANVoK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 16:44:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so900338ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 13:44:07 -0800 (PST)
In-Reply-To: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Sunday 13 January 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here are the remaining patches which had issues to be worked out. I decided
> to keep the Flexible Disk Page and Capacity Descriptor in
> idefloppy_floppy_t for the sake of the two printk calls for which they are
> used. Otherwise, we'll be changing long-known driver behavior and this won't
> be acceptable. I'll audit the driver to see whether rq_data_dir() can replace
> the PC_WRITING flag completely and get rid of that one too.

Thanks, I applied patches #1-9 and #11, #10 needs small corrections and will
be applied once they are addressed (#12 is fine but since it depends on #11
it has also to wait a bit more).

> By the way, I have an Iomega ZIP 100 drive somewhere in my hardware pile and
> will do some testing with the "new" :) driver just in case.

This would be great. :)

Cheers,
Bart
