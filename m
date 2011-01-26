From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH -next 2/2][RFC] x86: Saveoops: Reserve low memory and
	register code
Date: Wed, 26 Jan 2011 11:04:19 +0200
Message-ID: <20110126090419.GA24527@laptop>
References: <20110125134748.GA10051@laptop> <20110125135326.GC10051@laptop> <4D3F0896.4050006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:54656 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab1AZJEZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jan 2011 04:04:25 -0500
Content-Disposition: inline
In-Reply-To: <4D3F0896.4050006@zytor.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, Dirk.Hohndel@intel.com, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, James Bottomley <James.Bottomley@suse.de>, Mark Lord <kernel@teksavvy.com>, Jeff Garzik <jgarzik@pobox.com>

On Tue, Jan 25, 2011 at 09:29:58AM -0800, H. Peter Anvin wrote:
> 
> However, I'm quite nervous about this -- this patch has *plenty* of real
> possibility of wrecking data.
> 

Yes, it does.

Keep in mind though that now I'm just prototyping different solutions to
a problem I'm facing. I fully understand that in no way this patch is
going to be merged in its current state.

I'll send another email summarizing the criticism and proposing different
paths in a moment.

thanks,

-- 
Darwish
http://darwish.07.googlepages.com
