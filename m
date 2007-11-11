From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: cd/dvd inaccessible in 2.6.24-rc2
Date: Sat, 10 Nov 2007 16:13:01 -0800
Message-ID: <20071110161301.4d50676f.akpm@linux-foundation.org>
References: <1194668831.3436.14.camel@Athas>
	<20071110144923.beb7bbae.akpm@linux-foundation.org>
	<20071110230553.1a935ec6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20071110230553.1a935ec6@the-village.bc.nu>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Will Trives <will@trivescon.com.au>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, 10 Nov 2007 23:05:53 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > > ata9.00: qc timeout (cmd 0xa0)
> > > ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > > ata9.00: cmd a0/00:00:00:02:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 2
> > > in
> > >          res 51/54:03:00:02:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
> > > ata9.00: status: { DRDY ERR }
> 
> Could be an IRQ/ACPI regression, and in fact to me it looks more like
> that, than an IDE one.

Drat.  Seems that once we break that sort of thing we never fix it again.

> Probably worth trying the various IRQ routing
> options and seeing if they help.

Yup.

Please, if you have time, bisect it down to the offending commit?

There's info at http://www.kernel.org/doc/local/git-quick.html which should
help.

Thanks.
