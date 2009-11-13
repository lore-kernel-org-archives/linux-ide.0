From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Fri, 13 Nov 2009 23:17:35 +0100
Message-ID: <200911132317.35088.bzolnier@gmail.com>
References: <4AFCC0D4.9020708@gmail.com> <200911132039.06929.bzolnier@gmail.com> <20091113213007.774e75e3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:14235 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbZKMWSZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 17:18:25 -0500
In-Reply-To: <20091113213007.774e75e3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Friday 13 November 2009 22:30:07 Alan Cox wrote:

> > > > PATA_CMD64X: EXPERIMENTAL
> > > > - potential data corruption issues remains unfixed for CMD64[3,6]
> > > 
> > > Patch in testing, and unlike the old IDE one it doesn't cripple the
> > > controller but implements the proper workaround in full including
> > > permitting parallel PIO command streams. I'll push that back through
> > > stable once done.
> > 
> > This patch is way too complex and risky for -rc, let alone -stable.
> 
> How would you know - I've not posted it yet ? And btw I don't plan to

I prefer to not talk about "virtual" patches (especially since I'm still
waiting for HPA fixes promised in May) and the only patch so far was the one
from two weeks ago:

	http://article.gmane.org/gmane.linux.ide/43136

[ it has still unfixed problems.. ]

-- 
Bartlomiej Zolnierkiewicz
