From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 19:39:11 +0000
Message-ID: <20090126193911.1841618b@lxorguk.ukuu.org.uk>
References: <200901231615.38011.sshtylyov@ru.mvista.com>
	<497B9EE4.8010807@ru.mvista.com>
	<497E0548.80904@ru.mvista.com>
	<20090126190801.7d198246@lxorguk.ukuu.org.uk>
	<497E0EF3.2000201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41346 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752168AbZAZTjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 14:39:37 -0500
In-Reply-To: <497E0EF3.2000201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

On Mon, 26 Jan 2009 22:28:51 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote
> > secondary CFA test and posted a patch set to improve this, but which
> > removed the version checks.
> 
>     And did that completely correctly.

In your opinion but as I've pointed out that seems incorrect so simply
repeating ad-nauseum that your patch is correct isn't helpful.


> > This patch keeps the version checks but incorporates the other suggestions
> > Sergei made including a better ata version check for the usual case where
> > we want to know "is version >= x" rather than "what version do you
> > support".
> 
>     Improvements should be mixed with fixes.

They were.

Which is better than correcting things while intentionally adding flaws
by removing sanity checks.

>  Refer to the CF specs (google for cfspc<x_><y>.pdf) as to why it's wrong.

I've read the CF specs back to 1.1, and the ATA specs back to ATA-1.
Prior to ATA-3 you can't rely on the test in question.
