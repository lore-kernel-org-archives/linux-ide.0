From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 17:01:37 -0500
Message-ID: <20041221220137.GA5399@havoc.gtf.org>
References: <20041221202407.GD2725@artsapartment.org> <41C88F73.2090606@pobox.com> <20041221133056.6a5a3259.akpm@osdl.org> <41C89ADE.1010403@pobox.com> <41C89C63.8090708@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([63.115.148.101]:4308 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261624AbULUWBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2004 17:01:38 -0500
Content-Disposition: inline
In-Reply-To: <41C89C63.8090708@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, ahaas@airmail.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Tue, Dec 21, 2004 at 01:57:55PM -0800, Randy.Dunlap wrote:
> But the real question to me (other than "will some old-style
> initializers be deprecated by gcc in the future?") is

Note that the code in question did not use initializers at all,
so that's an unrelated issue.

The code was, and remains, compliant to C99 standards.

	Jeff



