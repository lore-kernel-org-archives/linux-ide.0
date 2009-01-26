From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 21:22:12 +0000
Message-ID: <20090126212212.3d52781f@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
	<20090126190801.7d198246@lxorguk.ukuu.org.uk>
	<497E0EF3.2000201@ru.mvista.com>
	<497E101C.9040008@ru.mvista.com>
	<20090126194237.4897b6ce@lxorguk.ukuu.org.uk>
	<497E1550.1000501@ru.mvista.com>
	<20090126200143.733b0cec@lxorguk.ukuu.org.uk>
	<497E1DBB.80709@ru.mvista.com>
	<497E242C.3040307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40916 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751703AbZAZVWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 16:22:11 -0500
In-Reply-To: <497E242C.3040307@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

>     I'm sorry, that was totally off base. I've misread this whole paragraph in 
> haste. :-<
>     The rest of my evening was wasted, sigh.

If it got the CF code fixed it wasn't a waste.

Do I understand rightly that the agreed things to do are

- redo the version check patch using the signed check as you suggested
and remove the changes to the CFA check from it
- make the CFA code check word 80 == 0 as a sanity check
- apply your change to check the bit in the right command word for CFA

?

Alan
