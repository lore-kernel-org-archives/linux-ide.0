From: Roland Dreier <roland@topspin.com>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
Date: Wed, 23 Feb 2005 14:01:44 -0800
Message-ID: <528y5faqbb.fsf@topspin.com>
References: <421CE018.5030007@pobox.com>
	<200502232345.23666.adobriyan@mail.ru> <421CF575.20801@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from umhlanga.stratnet.net ([12.162.17.40]:26181 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261626AbVBWWBs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 17:01:48 -0500
In-Reply-To: <421CF575.20801@arcor.de> (Prakash Punnoor's message of "Wed,
 23 Feb 2005 22:28:21 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>

    Prakash> If I am not totally mistaken this is not gcc4 friendly
    Prakash> code. (lvalue thing...)

Actually you misread the code slightly.  It's a little subtle, but
code like

		*(__le32 *)prd = cpu_to_le32(len);

is not using a cast as an lvalue.  It's dereferencing a cast and as
such is totally correct, idiomatic and clean C.

 - Roland
