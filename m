From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -mm] IDE core: must_check fixes
Date: Wed, 12 Jul 2006 13:04:08 +0100
Message-ID: <1152705848.22943.27.camel@localhost.localdomain>
References: <20060711204555.3b12eba4.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32475 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751354AbWGLLqS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jul 2006 07:46:18 -0400
In-Reply-To: <20060711204555.3b12eba4.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>

Ar Maw, 2006-07-11 am 20:45 -0700, ysgrifennodd Randy.Dunlap:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Check all __must_check warnings in IDE core.

Most of those should be panic() calls. If they happen you don't want to
continue running with your storage system in a half defined stated. Its
far better you die before anything worse happens.


