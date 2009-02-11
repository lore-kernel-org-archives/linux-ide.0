From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] ide: add ->dma_expiry method and remove ->dma_exec_cmd
 one
Date: Wed, 11 Feb 2009 20:30:21 +0300
Message-ID: <49930B2D.8090503@ru.mvista.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <20090209232012.32406.88338.sendpatchset@localhost.localdomain> <4991C4F3.2040404@ru.mvista.com> <200902111730.39460.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10269 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753942AbZBKRaD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 12:30:03 -0500
In-Reply-To: <200902111730.39460.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Bartlomiej Zolnierkiewicz wrote:

>>>* Rename dma_timer_expiry() to ide_dma_sff_expiry() and export it.

>>>* Add ->dma_expiry method

>>    This name doesn't seem to make much sense. Why not leave it dma_timer_expiry?

> Well, the name matches with hwif->expiry one + the downside of leaving it at
> dma_timer_expiry is a need to reformat all struct ide_dma_ops instances...

    How about just timer_expiry() then?

> Thanks,
> Bart

MBR, Sergei
