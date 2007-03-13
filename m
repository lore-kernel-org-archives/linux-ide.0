From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [3/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 21:12:17 +0100
Message-ID: <b637ec0b0703131312p22ee137fjc4911db07d8fa54a@mail.gmail.com>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
	 <20070313125006.GT18731@stusta.de>
	 <20070313140323.6ee03eee@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070313140323.6ee03eee@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Brik <no.hope@gmail.com>, Andi Kleen <ak@muc.de>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Randy Dunlap <randy.dunlap@oracle.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, Ray Lee <ray-lk@madrabbit.org>, Colchao <colchaodemola@gmail.com>, =?UTF-8?Q?Mathieu_B=C3=A9rard?= <Mathieu.Berard@crans.org>, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Plamen Petrov <plamen.petrov@tk.ru.acad.bg>, Laurent Riffard <laurent.riffard@free.fr>
List-Id: linux-ide@vger.kernel.org

On 3/13/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Subject    : libata: PATA UDMA/100 configured as UDMA/33
> > References : http://lkml.org/lkml/2007/2/20/294
> >              http://www.mail-archive.com/linux-ide@vger.kernel.org/msg04115.html
> >              http://bugzilla.kernel.org/show_bug.cgi?id=8133
> >              http://bugzilla.kernel.org/show_bug.cgi?id=8164
> > Submitter  : Fabio Comolli <fabio.comolli@gmail.com>
> >              Plamen Petrov <plamen.petrov@tk.ru.acad.bg>
> >              Laurent Riffard <laurent.riffard@free.fr>
> > Handled-By : Tejun Heo <htejun@gmail.com>
> > Status     : patch available
>
> Some cases should be fixed now but probably not all (eg the Nvidia one)
>

This regression is still present in 2.6.21-rc3-g8b9909de (pulled from
Linus' tree less than one hour ago).

Fabio
