From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug report
Date: Tue, 21 Aug 2012 00:16:35 +0100
Message-ID: <20120821001635.5e9e2afc@pyramind.ukuu.org.uk>
References: <CAL=PgHMH=5A5rLaO=RvYYA8MmcKEt1zay7f2=SS83RYayVVh+w@mail.gmail.com>
	<5032BD97.7070701@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54380 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2HTXL4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2012 19:11:56 -0400
In-Reply-To: <5032BD97.7070701@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: "mr.shroom" <mr.shroom@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 20 Aug 2012 15:43:35 -0700
Randy Dunlap <rdunlap@xenotime.net> wrote:

> (cc-ing linux-ide mailing list)

Classic "no IRQ being delivered" - looks like a platform IRQ routing
problem
