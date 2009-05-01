From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [RFC PATCH 0/3] ide-atapi cleanups
Date: Fri,  1 May 2009 22:14:21 +0200
Message-ID: <1241208864-23421-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:57448 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbZEAUO3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 16:14:29 -0400
Received: by bwz7 with SMTP id 7so2475266bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 01 May 2009 13:14:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi Bart, hi Tejun,

here's a small conversion attempt to Tejun's struct request API change.
This is not ripe material yet and has more of a rfc nature so that we
could see more concretely how LLDDs might use and not abuse :) block
layer interfaces.

This is based ontop of

git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git block-unify-sector-and-data_len

and has been lightly tested with ide-floppy.

Thanks,
Boris.
