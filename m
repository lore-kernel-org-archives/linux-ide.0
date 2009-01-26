From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 19:41:21 +0000
Message-ID: <20090126194121.02d80733@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
	<20090126190801.7d198246@lxorguk.ukuu.org.uk>
	<497E0EF3.2000201@ru.mvista.com>
	<497E101C.9040008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60456 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751731AbZAZTqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 14:46:36 -0500
In-Reply-To: <497E101C.9040008@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

> >    Improvements should be mixed with fixes.
> 
>     Should not be, I meant to type.

In this case it makes complete sense to do the work as one. I can
pointlessly split it into two patches so you can generate twice as many
complaints if it amuses you.

Alan
