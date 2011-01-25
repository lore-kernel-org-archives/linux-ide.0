From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
 panic
Date: Tue, 25 Jan 2011 09:33:18 -0800
Message-ID: <4D3F095E.9000004@zytor.com>
References: <20110125134748.GA10051@laptop> <20110125140948.GA26762@elte.hu> <20110125150834.GD27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59277 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab1AYRhC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Jan 2011 12:37:02 -0500
In-Reply-To: <20110125150834.GD27510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, Dirk.Hohndel@intel.com, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>

On 01/25/2011 07:08 AM, Tejun Heo wrote:
> 
> There are holes but writing to them without full knowledge of the
> configuration can be quite dangerous.  I don't think it would be
> possible to mass deploy it without manual configuration unless we
> specifically reserve (and maybe mark) it in the filesystem.
> 

Reserve and mark in the filesystem is relatively straightforward, except
for btrfs, which doesn't have support for reserved extents.  This is a
bit of a shortcoming in btrfs.

>> All in one, a very intriguing idea IMO, and the hardest bits
>> (lowlevel x86 transition) is all implemented already.

Lowlevel x86 transition is not at all the hardest part.  It's
detail-oriented but well defined (and, I might add, incompletely
implemented -- 64 bits only, not using facilities we already have); the
*hard* part, and I mean harder by orders of magnitude, is to get the
BIOS to behave sanely without an intervening reboot, *AND* not trash
your data, ever.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

