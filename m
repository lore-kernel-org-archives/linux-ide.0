From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA causes IDE corruption on Shuttle AK32L mobo (VIA KT266A),
	kernel 2.4.1[89]
Date: 29 Nov 2002 21:24:38 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1038605078.14232.9.camel@irongate.swansea.linux.org.uk>
References: <1038600903.2074.2.camel@fox>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1038600903.2074.2.camel@fox>
List-Id: linux-ide@vger.kernel.org
To: Jim Halfpenny <jimvin@lineone.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri, 2002-11-29 at 20:15, Jim Halfpenny wrote:
> I have seen the behaviour using the stock 2.4.18 kernel from Mandrake
> 8.2. and the 2.4.19 kernel from Mandrake 9.0:
> Linux version 2.4.19-16mdk (quintela@bi.mandrakesoft.com) (gcc version
> 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Sep 20 18:15:05 CEST 2002

Vendor kernel reports generally ahould go to the vendor, because the
vendor kernels are often quite different from the base one.

> There are no log entries in /var/log/messages or /var/log/syslog when
> these faulty writes take place to indicate that there are any problems
> but copying a large file and checking it's md5sum shows it to be
> damaged.

UDMA data transfers are verified by hardware end to end. UDMA showing up
memory problems is not unknown, but thats only one possibility.

