From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide:
 locking improvements)
Date: Mon, 13 Oct 2008 21:24:36 +0100
Message-ID: <20081013212436.2db6277f@lxorguk.ukuu.org.uk>
References: <678468.92529.qm@web57414.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48820 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760086AbYJMUYg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 16:24:36 -0400
In-Reply-To: <678468.92529.qm@web57414.mail.re1.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan.cunningham@yahoo.com
Cc: linux-ide@vger.kernel.org

> It seems that Bart, Boris and the other recent ide contributors care a lot about old hardware, which is great because the corporate-sponsored libata developers are paid to focus on new hardware.

***Parp***

sorry thats completely bogus: Libata supports more prehistoric pointless
ISA and VLB controllers than drivers/ide. Not that it matters as every
vendor I know of ships Libata and ships with the ISA/VLB stuff disabled 8)

Alan
