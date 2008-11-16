From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.28-rc3: WARN_ON(ap->nr_active_links) in ata_eh_finish() with
 pata_ali DMA CD-ROM
Date: Mon, 17 Nov 2008 00:29:39 +0900
Message-ID: <49203C63.4070803@kernel.org>
References: <200811042128.10356.arvidjaar@mail.ru> <49194B8F.80104@kernel.org> <200811161559.08981.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43214 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbYKPP33 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 10:29:29 -0500
In-Reply-To: <200811161559.08981.arvidjaar@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello,

Andrey Borzenkov wrote:
> On Tuesday 11 November 2008, Tejun Heo wrote:
>> Andrey Borzenkov wrote:
> rc5 is the first release ever that correctly falls back to PIO from DMA
> on ATAPI connected to pata_ali. Wow! Thank you!

Hmm... this should have worked on 2.6.27 too.  How did it fail on
2.6.27?

pata_ali ATAPI dma problem is sad.  I have the hardware and the ide
driver works fine and I still can't figure out what's wrong.  :-(

-- 
tejun
