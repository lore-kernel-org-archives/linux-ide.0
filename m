From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Basics of per controller fixup
Date: Fri, 05 Nov 2004 23:26:46 +0000
Message-ID: <1099697205.5564.74.camel@localhost.localdomain>
References: <1099672171.5630.42.camel@localhost.localdomain>
	 <200411052300.17155.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:33477 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261221AbUKFA3i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:29:38 -0500
In-Reply-To: <200411052300.17155.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Gwe, 2004-11-05 at 22:00, Bartlomiej Zolnierkiewicz wrote:
> * does delkin_cb need it?

Yes

> * shouldn't this fixup be applied for CF devices?

Our CF detection isnt good enough and it also occurs for CF adapters
that are crap and hold an IBM microdrive (non CF)

> * arch specific drivers shouldn't need this fixup
>   (they can claim no slave decoding to IDE layer)

Who knows. I'd hope not


