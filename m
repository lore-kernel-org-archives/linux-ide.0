From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 16:29:13 -0500
Message-ID: <20041221212911.GA16383@tuxdriver.com>
References: <20041221202407.GD2725@artsapartment.org> <41C88F73.2090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:6919 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261857AbULUV23 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2004 16:28:29 -0500
Content-Disposition: inline
In-Reply-To: <41C88F73.2090606@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Art Haas <ahaas@airmail.net>, Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

On Tue, Dec 21, 2004 at 04:02:43PM -0500, Jeff Garzik wrote:
> Art Haas wrote:

> >This patch adds C99 initializers to the file. It can clearly wait until
 
> The unpatched version is far more readable and maintainable.

I dunno...other than the whitespace issue before the first "}",
I like the patch.

I think the new-style struct initializers have the advantage of
associating names with parameters, rather than relying on declaration
order to match a structure definition living elsewhere.

YMMV, of course...

John
-- 
John W. Linville
linville@tuxdriver.com
