From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Sun, 25 Jan 2009 10:52:50 +0000
Message-ID: <20090125105250.6f309335@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39003 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752076AbZAYKwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 05:52:44 -0500
In-Reply-To: <497B9EE4.8010807@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

>    Jeff, Bart, I've changed my mind about recasting this patch as Alan 
> has requested, as I do consider it correct now. The version check should 
> be unnecessary since I'm adding the validity bits check (hte fact that 
> ata_id_major_complex() is quite cumbesome way of checking the minumum 
> revision # -- this can be done with a single comparison instead of the 
> bit scan)

If you want to just do a specific check yes. I agree there it would make
some sense to have a ata_has_version(ATA_VER_BITFOO); that was a single
inline & check for ATA3+

Alan
