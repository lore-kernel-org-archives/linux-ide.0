From: "Art Haas" <ahaas@airmail.net>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 15:30:13 -0600
Message-ID: <20041221213013.GE2725@artsapartment.org>
References: <20041221202407.GD2725@artsapartment.org> <41C88F73.2090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:25606 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261862AbULUVgP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Dec 2004 16:36:15 -0500
Received: from pppte02-088.ght.iadfw.net ([66.94.128.88] helo=pcdebian)
	by covert.iadfw.net with esmtp (Exim 4.24)
	id 1Cgrhk-0005EE-1K
	for linux-ide@vger.kernel.org; Tue, 21 Dec 2004 15:38:04 -0600
Content-Disposition: inline
In-Reply-To: <41C88F73.2090606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Tue, Dec 21, 2004 at 04:02:43PM -0500, Jeff Garzik wrote:
> Art Haas wrote:
> >Hi.
> >
> >This patch adds C99 initializers to the file. It can clearly wait until
> >after 2.6.10 is released if you want to send it to Linus.
> 
> The unpatched version is far more readable and maintainable.
> 

I thought the patch made the file a little more readable is it removed
the 'NULL' values and the lines don't wrap. Regardless, the patch is
not critical, just cosmetic.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
