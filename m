From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk	upon
 panic
Date: Tue, 25 Jan 2011 17:10:49 -0500
Message-ID: <4D3F4A69.7090702@teksavvy.com>
References: <20110125134748.GA10051@laptop> <20110125140948.GA26762@elte.hu> <20110125153649.GA11386@laptop> <1295971355.4955.104.camel@mulgrave.site> <20110125170522.GA16285@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:16313 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753113Ab1AYWKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 17:10:53 -0500
In-Reply-To: <20110125170522.GA16285@laptop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, Dirk.Hohndel@intel.com, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>

On 11-01-25 12:05 PM, Ahmed S. Darwish wrote:
>
> My current x86 laptop includes the very common ATA PIIX controller. 


ata_piix is just about ideal for this sort of thing.

Except, don't use the BIOS to write the logs,
but rather code/use a very simple set of polling-PIO
functions to talk directly through the PIIX to the drive.

Really really simple code to do that, and it would likely
work with anything ata-piix, and most other non-AHCI chipsets too.

Not perfect, but probably good enough for a lot of scenarios.
The old hd.c driver shows how to read/write a sector at a time,
and that kind of code is easily converted to simply poll for completion.

Cheers
