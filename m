From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Wed, 31 Oct 2007 17:58:12 +0000
Message-ID: <20071031175812.7dc9cc8f@the-village.bc.nu>
References: <884696.96067.qm@web54404.mail.yahoo.com>
	<1193830965.2347.66.camel@turtle-25895.iol.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:46033 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752528AbXJaR4e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Oct 2007 13:56:34 -0400
In-Reply-To: <1193830965.2347.66.camel@turtle-25895.iol.ie>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Declan Moriarty <declan.moriarty@iol.ie>
Cc: Vlad Codrea <vladc6@yahoo.com>, linux-ide <linux-ide@vger.kernel.org>

> 	kjournald starting Commit interval 5 seconds
> 	VFS: Mounted root (ext3 filesystem) readonly
> 	Freeing unused kernel memory: 168k freed
> (keyboard still echoed onscreen, disk parked)
> 
> Adding init=/bin/bash is no better.

So its the user space which is broken. Make sure the user space has the
right /dev etc - and is for the right CPU - a 200MHz pentium means you
need i386 or i586 binaries. i686/athlon binaries would produce the effect
you report.

Alan
