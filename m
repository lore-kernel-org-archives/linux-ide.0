From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 13:16:44 -0400
Message-ID: <4353DC7C.6090705@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <200510170952.34174.jbarnes@virtuousgeek.org> <4353D96F.90805@pobox.com> <200510171006.39206.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751066AbVJQRQx@vger.kernel.org>
In-Reply-To: <200510171006.39206.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
List-Id: linux-ide@vger.kernel.org

Jesse Barnes wrote:
> So sometimes the legacy IDE driver will lock up when it tries to drive 
> both ports in a combined configuration?  In that case, can't we just 

-sometimes- When it tries to drive the SATA port, it locks up.  My best 
guess is that this is due to the fact that SATA emulates IDE shadow 
registers in silicon, and the IDE driver does something weird that 
confused the silicon's IDE emulation logic.

Under SATA, the IDE shadow registers are nothing but a buffer.  Writing 
to the Command or Control registers causes this buffer to be batched 
into a SATA frame (a "FIS"), and sent to the device.


> disable the legacy IDE driver for these chips and force the use of the 
> libata version?

More than a little ugly:  The piix driver already excludes the SATA 
device (unless CONFIG_BLK_DEV_IDE_SATA is defined), so the driver that 
picks up the IDE is the non-PCI "generic IDE" legacy driver.

You would need to add code somewhere in a non-PCI driver to specifically 
exclude a few PCI devices.

Removing the quirk means users/distros would simply have to know to 
disable CONFIG_IDE completely.  Doable, but also guaranteed to generate 
bug reports.

	Jeff
