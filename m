From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC] m68k/bitops: Make bitmap data pointer of atomic ops volatile
Date: Tue, 7 Jun 2011 15:56:58 +0200
Message-ID: <201106071556.58381.arnd@arndb.de>
References: <1307390873-29687-1-git-send-email-geert@linux-m68k.org> <201106071322.29884.arnd@arndb.de> <20110607133500.GX29924@decadent.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50027 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab1FGN5D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2011 09:57:03 -0400
In-Reply-To: <20110607133500.GX29924@decadent.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org

On Tuesday 07 June 2011, Ben Hutchings wrote:
> On Tue, Jun 07, 2011 at 01:22:29PM +0200, Arnd Bergmann wrote:

> > I guess what happened is that some variables are traditionally marked
> > as volatile although they shouldn't be, and most architectures have
> > adapted their bitops to make the warnings go away. If you see more
> > warnings of that kind, it's probably fine to just do the same on m68k.
> > The volatile modifier doesn't really hurt in this case.
>  
> These operations are required to be atomic and therefore they
> must be suitable for use with volatile-qualified variables.

As I said, it's not wrong for them to have a volatile qualifier in the
argument list. However, there should also not be the need for the
qualifier in any of the callers, because the bitops only work if
all accesses to the data are done through bitops functions, and that
means that the qualifier on the variable is completely meaningless.

	Arnd
