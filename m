From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Fri, 10 Sep 2004 17:32:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094830352.13450.21.camel@thomas.tec.linutronix.de>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
	 <4141BFDF.1050200@inet6.fr>
	 <1094828803.13450.4.camel@thomas.tec.linutronix.de>
	 <4141C8C6.1030307@inet6.fr>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64923
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267494AbUIJPjr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Sep 2004 11:39:47 -0400
In-Reply-To: <4141C8C6.1030307@inet6.fr>
List-Id: linux-ide@vger.kernel.org
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

On Fri, 2004-09-10 at 17:31, Lionel Bouton wrote:

> I see it's not really a cutting-edge design (2002). Apparently nobody 
> seemed to care about Linux IDE performance before :-|

The chipset was often used in Notebooks. I just checked one of them and
it has both the 5513 fake bits set, so I never noticed. :) 
I think most developers were following the recommended settings in the
manual, but some obviously did not.

tglx


