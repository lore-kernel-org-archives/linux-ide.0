From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Mon, 29 Oct 2007 11:20:48 +0000
Message-ID: <20071029112048.3b323276@the-village.bc.nu>
References: <949545.3641.qm@web54410.mail.yahoo.com>
	<1193655202.2506.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42629 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751141AbXJ2LSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 07:18:46 -0400
In-Reply-To: <1193655202.2506.27.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Declan Moriarty <declan.moriarty@iol.ie>
Cc: Vlad Codrea <vladc6@yahoo.com>, linux-ide <linux-ide@vger.kernel.org>

> I really doubt if libata alone would do much for me, as the disk and
> bios doesn't really want to know about ata at all. We're 1998 here,
> remember. ATA has to be disabled for this to read the disk at all.

1998 is well into the world of ATA (IDE is just a confusing othername)

>From your info there isn't enough to debug this. 

Boot the kernel with initcall_debug=1

and it will spew a list of each initializer as it calls it, you can then
see which is the last called and look it up in the symbol table
