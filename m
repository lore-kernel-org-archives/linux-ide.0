From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Tue, 9 Dec 2003 21:14:47 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312092114.47241.bzolnier@elka.pw.edu.pl>
References: <20031203204445.GA26987@gtf.org> <3FD612E2.90607@atl.lmco.com> <200312091954.28224.marchand@kde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2703 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266084AbTLIUNL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Dec 2003 15:13:11 -0500
In-Reply-To: <200312091954.28224.marchand@kde.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Mickael Marchand <marchand@kde.org>
Cc: Aron Rubin <arubin@atl.lmco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


On Tuesday 09 of December 2003 19:54, Mickael Marchand wrote:

> the attached patch makes _both_ drivers work (whereas the previous one made
> only the libata one working)

Great!  Now I know it is really working.

I've already corrected your previous patch and included it in -bart1 patch:
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/ide-siimage-sil3114.patch

Yes, I forgot to send you corrected patch, sorry. :-)

--bart

