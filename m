From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk	upon
 panic
Date: Thu, 27 Jan 2011 10:56:39 -0800
Message-ID: <987664A83D2D224EAE907B061CE93D53019438F230@orsmsx505.amr.corp.intel.com>
References: <AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
 <20110126124954.GC24527@laptop>
 <987664A83D2D224EAE907B061CE93D53019438EABF@orsmsx505.amr.corp.intel.com>
 <20110126231620.GA14807@redhat.com>
 <987664A83D2D224EAE907B061CE93D53019438EB02@orsmsx505.amr.corp.intel.com>
 <20110126233033.GB14807@redhat.com>
 <987664A83D2D224EAE907B061CE93D53019438EBB6@orsmsx505.amr.corp.intel.com>
 <4D40F7F1.3020509@zytor.com> <20110127120039.GD20279@elte.hu>
 <4D4197CB.9070201@zytor.com> <20110127162429.GB26437@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110127162429.GB26437@elte.hu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@redhat.com>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, "Hohndel, Dirk" <dirk.hohndel@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?iso-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, James Bottomley <James.Bottomley@suse.de>, Mark Lord <kernel@teksavvy.com>, Jeff Garzik <jgarzik@pobox.com>, Eric Biederman <ebiederm@xmission.com>, Vivek
List-Id: linux-ide@vger.kernel.org

> Yeah, i've done it countless times and it's very painful indeed - but the 
> alternative "losing context" would be even worse to me. Can we do both - i.e. have 
> the barcode on the screen alongside the oops itself? (although at that point they'll 
> be taking screen real estate from each other - degrading the information in *both* 
> venues.)
>
> Keyboard 'oops scrolling' driver with 'flip to barcode output' key? :-)

If we can make the screen scroll, or guarantee that a hot key will switch to
the barcode view, then those look like good solutions. Sharing space on a
non-scrollable view sounds like a poor choice. Perhaps better to have a
command line option to say which to provide (default = text).

-Tony
