From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 0/17] ide-tape: remove pipeline functionality-v3
Date: Mon, 17 Mar 2008 07:41:13 +0100
Message-ID: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.224]:30023 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYCQGlh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2008 02:41:37 -0400
Received: by hu-out-0506.google.com with SMTP id 19so3301583hue.21
        for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 23:41:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Hi Bart,

here's the rest of the pipeline removal series. What's left is to rewrite the
whole allocation logic around tape->merge_stage and all the other small buffers
so that we can get at least some sanity into the driver before working on it
any further :).

 Documentation/ide/ide-tape.txt |  211 ++++---------
 drivers/ide/ide-tape.c         |  689 ++--------------------------------------
 2 files changed, 99 insertions(+), 801 deletions(-)
