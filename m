From: Dan Porat <dan.porat@gmail.com>
Subject: NCQ high speed data integrity issues
Date: Tue, 15 Dec 2009 21:29:38 +0200
Message-ID: <93b143da0912151129obdf3613q558295b320e4db65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:49162 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933514AbZLOT3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 14:29:40 -0500
Received: by fxm21 with SMTP id 21so227553fxm.21
        for <linux-ide@vger.kernel.org>; Tue, 15 Dec 2009 11:29:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am running into data integrity issues while running sgp_dd ver 1.20
against any sg device while running 31 threads.
kernel 2.6.28 Ubuntu.
When running it in slow speed (20 MB/s) all runs well.
When pushing it towards the 50MB/s , Data integrity issues appear.

When running it against sd devices - no integrity issues , but bpt is
not determined and changes .

Any idea how to fix the sg data integrity issues?

Thanks

Dan Porat
