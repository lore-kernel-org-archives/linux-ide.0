From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Tue, 6 Mar 2007 17:08:48 +0000
Message-ID: <20070306170848.4c4f2608@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
	<20070305015036.GH3441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070305015036.GH3441@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mathieu =?UTF-8?B?QsOpcmFyZA==?= <Mathieu.Berard@crans.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Tejun Heo <htejun@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, Olivier Mondoloni <darkcore71@yahoo.fr>, Thomas Renninger <trenn@suse.de>, Robert Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Subject    : libata: PATA UDMA/100 configured as UDMA/33
> References : http://lkml.org/lkml/2007/2/20/294
>              http://www.mail-archive.com/linux-ide@vger.kernel.org/msg04115.html
> Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
> Handled-By : Tejun Heo <htejun@gmail.com>
> Status     : problem is being discussed

Patch went to Jeff, hopefully it is now fixed. Bigger rework is heading
into -mm but not appropriate or neccessary for 2.6.21

