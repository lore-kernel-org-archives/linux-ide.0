From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
 panic
Date: Tue, 25 Jan 2011 14:04:15 -0500
Message-ID: <4D3F1EAF.1080609@garzik.org>
References: <20110125134748.GA10051@laptop> <20110125140948.GA26762@elte.hu> <20110125153649.GA11386@laptop> <AANLkTikHe8Bq1f-nv8hiAeY7rs7t5MWTvEUSYT81py4S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43556 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab1AYTEW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 14:04:22 -0500
In-Reply-To: <AANLkTikHe8Bq1f-nv8hiAeY7rs7t5MWTvEUSYT81py4S@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, Dirk.Hohndel@intel.com, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>

On 01/25/2011 12:32 PM, Tony Luck wrote:
> One more "is this bit of the BIOS code safe" concern that I have is that
> you'll be using the "write" path of the INT 0x13 code ... which isn't the
> path that is tested by booting ... it *ought* to be OK - but untested paths
> in BIOS seem to be broken paths all too often.


Not really...  as others have noted, we reprogram the controller in a 
different mode, once the kernel starts.

	Jeff


