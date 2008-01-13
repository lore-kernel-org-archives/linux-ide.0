From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 0/12] ide-floppy redux v2.5
Date: Sun, 13 Jan 2008 21:18:13 +0100
Message-ID: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp108.plus.mail.re1.yahoo.com ([69.147.102.71]:32339 "HELO
	smtp108.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753924AbYAMUWT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 15:22:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

Hi Bart,

here are the remaining patches which had issues to be worked out. I decided
to keep the Flexible Disk Page and Capacity Descriptor in
idefloppy_floppy_t for the sake of the two printk calls for which they are
used. Otherwise, we'll be changing long-known driver behavior and this won't
be acceptable. I'll audit the driver to see whether rq_data_dir() can replace
the PC_WRITING flag completely and get rid of that one too.

By the way, I have an Iomega ZIP 100 drive somewhere in my hardware pile and
will do some testing with the "new" :) driver just in case.

