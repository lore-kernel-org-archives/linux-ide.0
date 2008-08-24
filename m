From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.26.*] boot problem (ahci/irq related?)
Date: Sun, 24 Aug 2008 23:27:25 +0200
Message-ID: <200808242327.26863.rjw@sisk.pl>
References: <8db1092f0808111312x3baf819bxbb05030c05693065@mail.gmail.com> <200808221210.59560.rjw@sisk.pl> <8db1092f0808220350wc56af7di5c5e1c2eb2421249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756777AbYHXVYB@vger.kernel.org>
In-Reply-To: <8db1092f0808220350wc56af7di5c5e1c2eb2421249@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yinghai Lu <yhlu.kernel@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, andi@firstfloor.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-ide@vger.kernel.org

On Friday, 22 of August 2008, Maciej Rutecki wrote:
> 2008/8/22 Rafael J. Wysocki <rjw@sisk.pl>:
> 
> >> http://unixy.pl/maciek/download/kernel/2.6.27-rc3/dmesg-2.6.27-rc3.txt
> >
> > This doesn't look like the same configuration as in the picture you
> > sent previously.  In particular, the ICH7 lines are missing.
> >
> > Thanks,
> > Rafael
> >
> 
> I'm sorry, I boot wrong kernel. This is correct:
> http://unixy.pl/maciek/download/kernel/dupa/dmesg-2.6.26-rc2-initcall_debug.txt

Thanks.

This shows that the crash happens most probably in ide_scan_pcibus(),
before the probing of interfaces.

Rafael
