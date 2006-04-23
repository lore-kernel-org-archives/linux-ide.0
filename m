From: "Wesley Lim" <wesleylim@gmail.com>
Subject: Does libata queue SMART commands?
Date: Sun, 23 Apr 2006 05:29:50 -0700
Message-ID: <a8b98fc60604230529s7e410a79j3d05f56beb28063a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:50660 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751386AbWDWM3u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Apr 2006 08:29:50 -0400
Received: by wproxy.gmail.com with SMTP id i7so889186wra
        for <linux-ide@vger.kernel.org>; Sun, 23 Apr 2006 05:29:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Is it now (>2.6.16) safe to issue SMART commands to SATA drives? I
read an old email about it that it wasn't queued and could cause
corruption. However, I couldn't find a notice that that issue had been
resolved. Has it?

Thanks,
Wesley
