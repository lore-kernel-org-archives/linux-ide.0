From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE driver
Date: Fri, 3 Oct 2008 19:00:54 +0200
Message-ID: <200810031900.55214.bzolnier@gmail.com>
References: <20080922122853.GA15210@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:31658 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbYJCRne (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Oct 2008 13:43:34 -0400
Received: by gv-out-0910.google.com with SMTP id e6so296255gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 03 Oct 2008 10:43:33 -0700 (PDT)
In-Reply-To: <48DFFC62.9050300@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

On Sunday 28 September 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Ralf Baechle wrote:
> 
> > The Swarm IDE driver uses a release method which is defined in the driver
> > itself thus potentially oopsable.  The simple fix would be to just leak
> > the device but this patch goes the full length and moves the entire
> > handling of the platform device in the platform code and retains only
> > the platform driver code in drivers/ide/mips/swarm.c.
> >
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

wow, v2 happened really quickly :)

> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

[ I removed no longer needed BLK_DEV_IDE_SWARM from ide/Kconfig while at it ]
