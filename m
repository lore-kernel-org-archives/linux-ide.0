From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk	upon
 panic
Date: Wed, 26 Jan 2011 15:07:44 -0800
Message-ID: <987664A83D2D224EAE907B061CE93D53019438EABF@orsmsx505.amr.corp.intel.com>
References: <20110125134748.GA10051@laptop>
 <AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
 <20110126124954.GC24527@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:8197 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab1AZXHs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jan 2011 18:07:48 -0500
In-Reply-To: <20110126124954.GC24527@laptop>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, "Hohndel, Dirk" <dirk.hohndel@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?iso-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, James Bottomley <James.Bottomley@suse.de>, Mark Lord <kernel@teksavvy.com>, Jeff Garzik <jgarzik@pobox.com>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

>- The latest approach (proposed by Linus) is to forget the disk: jump to
>  real-mode, but display the kernel log in a fancy format (with scroll
>  ups and downs) instead.

A while ago (first Plumbers conference?) someone was talking about
using a 2-d barcode to display the tail of the kernel log & oops
register data - with the plan that you could capture the image with
a cell phone camera, and then get all the oops data without worrying
about transcription errors as you wrote down & re-typed all the hex.

Anyone know what happened to that plan?

-Tony


