From: Atila <atila.alr@dpf.gov.br>
Subject: Faulty drive data recovery
Date: Wed, 24 Nov 2010 12:04:15 -0200
Message-ID: <4CED1B5F.8000700@dpf.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhost1.dpf.gov.br ([200.169.41.12]:34778 "EHLO
	mailhost1.dpf.gov.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab0KXOOw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2010 09:14:52 -0500
Received: from [192.168.2.159] (unknown [10.51.4.190])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by expresso.dpf.gov.br (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Wed, 24 Nov 2010 12:04:17 -0200 (BRST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

HI, I'm trying to recover data from a damaged hard disk, which has
plenty of bad sectors, but also has many good ones. The problem is that
when a bad sector is found, the drive keeps trying to read it, instead
of giving up and just move on, so the average data read rate is around
5Kb/s. With such rates, it will take more than an year to finish. Since
I'm using gnu ddrescue (which logs bad sectors, so one can try then
again later), my goal is not waste time with errors, leaving the retries
to a second round.
So, my first attempt was to drastically lower the timeouts in
libata-eh.c. It seems to have improved a little, but I'm not having more
than 12Kb/s.
Is there any way to minimize retries and make errors finish faster?

Atila Romero
