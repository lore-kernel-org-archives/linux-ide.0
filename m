From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 11:05:49 +0100
Message-ID: <20121023110549.06f9c2e8@pyramind.ukuu.org.uk>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
	<20121020120047.GC17563@liondog.tnic>
	<50841CFC.2030802@talktalk.net>
	<20121021165756.GA20642@liondog.tnic>
	<50856AA8.1000607@talktalk.net>
	<20121022202734.GA16169@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49948 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678Ab2JWKBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2012 06:01:16 -0400
In-Reply-To: <20121022202734.GA16169@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: phillip.wood@dunelm.org.uk, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

> So yes, blacklisting it and verifying that your system still operates
> normally would be something to do. If it does, you could also build a
> kernel with pata_acpi disabled (that is, provided you build your own
> kernels).

The crash is still a bug. It needs chasing down.

Alan
