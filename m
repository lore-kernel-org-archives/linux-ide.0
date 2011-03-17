From: Tobias Karnat <tobias.karnat@googlemail.com>
Subject: Re: New MSI support in sata_sil24 still broken in 2.6.33-rc3
Date: Thu, 17 Mar 2011 19:07:05 +0100
Message-ID: <1300385225.13692.29.camel@Tobias-Karnat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38584 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab1CQSHM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2011 14:07:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>, Yinghai Lu <yinghai@kernel.org>, Robert Hancock <hancockrwd@gmail.com>, Torsten Kaiser <just.for.lkml@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Leon,

I have the same problem with the sata_sil24 driver,
using SiI 3132 and enabling msi causes an nmi.

http://marc.info/?l=linux-ide&m=129138342901236&w=2

Can't there be a workaround for this errata?

The sata_sil24 interrupt is shared on my system with
an cx88 tv card which often produces an irq storm.

-Tobias

