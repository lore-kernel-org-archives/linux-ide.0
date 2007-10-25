From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [IDE] Fix build bug
Date: Thu, 25 Oct 2007 23:52:31 +0200
Message-ID: <200710252352.32141.bzolnier@gmail.com>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20071025141305.GA11698@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-ide@vger.kernel.org

On Thursday 25 October 2007, Sam Ravnborg wrote:
> On Thu, Oct 25, 2007 at 02:53:34PM +0100, Ralf Baechle wrote:
> >   CC      drivers/ide/pci/generic.o
> > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > +section type conflict
> > 
> > This sort of build error is becoming a regular issue.  Either all or non
> > of the elements that go into a particular section of a compilation unit
> > need to be const.  Or an error may result such as in this case if
> > CONFIG_HOTPLUG is unset.
> So we can avoid this if we invent a __constinitdata tag that uses
> a new section?

I asked similar question on LKML few days ago together with the list of
potentially problematic places:

	http://article.gmane.org/gmane.linux.kernel/594427

Now I see that the list is only partially complete since __initdata and co.
may be also hidden in things like __setup() etc.

Thanks,
Bart
