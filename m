From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 12:01:07 +0000
Message-ID: <20090126120107.20345a75@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<20090125105045.65021406@lxorguk.ukuu.org.uk>
	<497DA356.2090206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56023 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750974AbZAZME2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 07:04:28 -0500
In-Reply-To: <497DA356.2090206@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

> why we have to check for ATA revision prior to that -- unless we're 
> trying to guard against pre ATA-3 values other than 0 or 0xFFFF.

Which we are. At the point we first use this function we are poking
blindly at a device we have not done any other analysis of.

Alan
