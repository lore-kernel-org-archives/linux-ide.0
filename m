From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] fix wrong __init usage in IDE PCI drivers
Date: Sat, 15 Jan 2005 02:37:36 +0100
Message-ID: <58cb370e05011417376956cfcb@mail.gmail.com>
References: <20050109131959.GA20622@lst.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:38057 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262114AbVAOBiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2005 20:38:24 -0500
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id j0F1c6IJ005917
	for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 17:38:07 -0800
Received: by wproxy.gmail.com with SMTP id 67so710691wri
        for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 17:37:37 -0800 (PST)
In-Reply-To: <20050109131959.GA20622@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Sun, 9 Jan 2005 14:19:59 +0100, Christoph Hellwig <hch@lst.de> wrote:
> PCI probe routines (and funcions called by them) must use __devinit
> as they can be called from PCI hotplug operations.
> 
> While most of the drivers touched in the patch are for hardware that's
> soldered on mainboards we now have a fake PCI HP driver that allows
> hot remove / replug for them which they need to handle.

Ugh... I really hate (lack of) flexibility of CONFIG_HOTPLUG...

Shouldn't we have __fakedev{init,exit} ?
