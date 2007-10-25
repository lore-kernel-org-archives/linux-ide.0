From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [IDE] Fix build bug
Date: Thu, 25 Oct 2007 15:13:13 +0100
Message-ID: <20071025141313.GA23536@linux-mips.org>
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:44267 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbXJYON0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 10:13:26 -0400
Received: from localhost.localdomain ([127.0.0.1]:28606 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022664AbXJYONZ (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Thu, 25 Oct 2007 15:13:25 +0100
Content-Disposition: inline
In-Reply-To: <20071025141305.GA11698@uranus.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

On Thu, Oct 25, 2007 at 04:13:05PM +0200, Sam Ravnborg wrote:

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
> I ask mainly to understand this error - not that I am that found
> of the idea.

Yes.

  Ralf
