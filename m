From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] remove dead PC9800 IDE support
Date: Mon, 3 May 2004 16:32:20 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040503163220.437c2921.rddunlap@osdl.org>
References: <200405040135.14688.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:63450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264168AbUECXjx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 May 2004 19:39:53 -0400
In-Reply-To: <200405040135.14688.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 4 May 2004 01:35:14 +0200 Bartlomiej Zolnierkiewicz wrote:

| 
| It was added in 2.5.66 but PC9800 subarch is still non-buildable.
| Also this is one big hack and only half-merged.
| 

It's fairly simple to make it buildable, but it's still a hack
that no one seems to want to support, so I agree, kill it.

Can we kill the rest of it too?

--
~Randy
