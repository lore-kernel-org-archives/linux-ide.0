From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] ide: add ->dma_expiry method and remove ->dma_exec_cmd
 one
Date: Tue, 17 Feb 2009 17:29:14 +0300
Message-ID: <499AC9BA.1080906@ru.mvista.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <200902111730.39460.bzolnier@gmail.com> <49930B2D.8090503@ru.mvista.com> <200902171516.34091.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:25041 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751856AbZBQO2x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2009 09:28:53 -0500
In-Reply-To: <200902171516.34091.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>Hello.

>>Bartlomiej Zolnierkiewicz wrote:

>>>>Bartlomiej Zolnierkiewicz wrote:

>>>>>* Rename dma_timer_expiry() to ide_dma_sff_expiry() and export it.

>>>>>* Add ->dma_expiry method

>>>>   This name doesn't seem to make much sense. Why not leave it dma_timer_expiry?

>>>Well, the name matches with hwif->expiry one + the downside of leaving it at
>>>dma_timer_expiry is a need to reformat all struct ide_dma_ops instances...

> On the 2nd look it doesn't seem to be a problem (I must have been looking at
> some odd case previously) -- I'll fix it up later.

    I vote for timer_expiry().

MBR, Sergei
