From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 09:52:33 -0700
Message-ID: <200510170952.34174.jbarnes@virtuousgeek.org>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750854AbVJQQwu@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
List-Id: linux-ide@vger.kernel.org

On Monday, October 17, 2005 8:14 am, Linus Torvalds wrote:
>    So it appears that your dependence on quirk_intel_ide_combined() is
>    fundamentally broken for the "m" case _anyway_.

Correct.  The quirk itself is a fragile hack.


> Anyway, the second thing means that the whole configuration is
> somewhat broken, but on the whole, why not this _much_ more trivial
> patch?
>
> It's still broken, exactly because it depends on the modules being
> defined when compiling the whole kernel, but hey, we probably have
> other cases like that.
>
> My suggestion being that we should make it unconditional, but maybe
> that breaks the case where we don't actually load the SATA module?

It does, since it prevents one of the ports from being bound by the 
legacy IDE driver.  But the whole thing is rather hackish to begin with, 
and I prefer this hack to the existing code (in fact, Andrew already 
queued up a patch from me in -mm that looks just like yours).

Ultimately, when libata gets ATAPI support, I think we just have to 
declare libata and legacy IDE to be incompatible for combined mode 
devices and remove the quirk.  Then whichever driver loads first will 
get the whole device, as it should.

Jesse
