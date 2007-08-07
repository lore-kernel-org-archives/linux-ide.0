From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 7 Aug 2007 22:09:10 +0200
Message-ID: <8db1092f0708071309h5cf6f68bo80b44d9a2fbeabeb@mail.gmail.com>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no>
	 <fa.mg6p0itaOQUo/t8deCaYpyqj6Nk@ifi.uio.no>
	 <fa.RxWYL8z8KktgL8LGZ/cTB2nI1Yc@ifi.uio.no>
	 <fa.AyyCtZ2yLjC5noHPHtmzn4ffhhE@ifi.uio.no>
	 <fa.SuAjism+m0z0haqCRVjkc2S978o@ifi.uio.no>
	 <fa.QgWcLG2hfRb92g4blN61qYfRjlQ@ifi.uio.no> <46B7AF53.1040307@shaw.ca>
	 <46B8140E.3000509@gmail.com> <1186497925.8780.78.camel@queen.suse.de>
	 <1186514618.5622.9.camel@nx6310>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1186514618.5622.9.camel@nx6310>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Michael Sedkowski <sedmich@gmail.com>
Cc: trenn@suse.de, Tejun Heo <htejun@gmail.com>, Robert Hancock <hancockr@shaw.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

2007/8/7, Michael Sedkowski <sedmich@gmail.com>:
> I did some additional checking today...
> On kernels prior to 2.6.22 line, the bug exists and manifests itself
> exactly the same way. However, when I removed the "-h" flag
> from /etc/init.d/halt, the drive spins down only once on "Power down"
> message and there is no sign of the bug and the emergency unload count
> remains constant. I've verified this on kernels 2.6.21.6; 2.6.20.4;
> 2.6.18-4-686-Etch.
> The obvious conclusion is that something must have changed it the 2.6.22
> kernels, so that removing the "-h" has no effect.
> I dunno if my observations are of any value, but I thought You should
> know...

I confirm this. First 2.6.21-rcx works OK (if I remember).  In
2.6.22(.1) remove -h option doesn't help - only warning message
dissapear, and double spin down also exists in suspend to disk.

The same laptop, bios, Debian etc.

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
