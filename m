From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Fri, 5 Nov 2004 21:17:03 +0100
Message-ID: <58cb370e04110512175fc2ded9@mail.gmail.com>
References: <20041103200059.GC17672@colo.lackof.org>
	 <58cb370e04110312215ee851e4@mail.gmail.com>
	 <20041103213351.GB23415@colo.lackof.org>
	 <58cb370e041103140121017ea1@mail.gmail.com>
	 <20041103232356.GD23415@colo.lackof.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:28078 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261187AbUKEUSP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 15:18:15 -0500
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.196])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id iA5KI7q7032388
	for <linux-ide@vger.kernel.org>; Fri, 5 Nov 2004 12:18:07 -0800
Received: by rproxy.gmail.com with SMTP id a36so109521rnf
        for <linux-ide@vger.kernel.org>; Fri, 05 Nov 2004 12:17:03 -0800 (PST)
In-Reply-To: <20041103232356.GD23415@colo.lackof.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: matthew@wil.cx, linux-ide@vger.kernel.org

applied

I had to cover init_iops_ns87415 by CONFIG_SUPERIO to fix:

drivers/ide/pci/ns87415.c:95: warning: `superio_ide_init_iops' defined
but not used

I also marked init_iops_ns87415 with __devinit
