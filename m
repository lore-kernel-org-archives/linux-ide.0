From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 13:03:43 -0400
Message-ID: <4353D96F.90805@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <200510170952.34174.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750954AbVJQRDt@vger.kernel.org>
In-Reply-To: <200510170952.34174.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
List-Id: linux-ide@vger.kernel.org

Jesse Barnes wrote:
> It does, since it prevents one of the ports from being bound by the 
> legacy IDE driver.  But the whole thing is rather hackish to begin with, 
> and I prefer this hack to the existing code (in fact, Andrew already 
> queued up a patch from me in -mm that looks just like yours).
> 
> Ultimately, when libata gets ATAPI support, I think we just have to 
> declare libata and legacy IDE to be incompatible for combined mode 
> devices and remove the quirk.  Then whichever driver loads first will 
> get the whole device, as it should.

I would love to remove the quirk completely!

Unfortunately combined mode is a runtime BIOS configuration, and there 
is also the lockup issue I mentioned in another email.

	Jeff
