From: "Paul Gimpelj" <pgimpelj@sympatico.ca>
Subject: Re: {linux-ide] ide errors redhat 9.0 install
Date: Fri, 11 Jun 2004 15:32:26 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <00b301c44fea$ead73350$13f9e2d1@zoom>
References: <1086616777.3649.10.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tomts22.bellnexxia.net ([209.226.175.184]:1182 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264397AbUFKXyp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Jun 2004 19:54:45 -0400
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Thanks Pat LaVarre.

I have the book undocumented pc.

I just installed xp over 98 and immediately it started to send out syn
packets over the internet.
I found it was msblaster.exe worm. I did an ida on it and  i t appears to
jump down deep into the hardware layer. and revectors the dma, irq, ports
etc.
I am very suprised that in a secure operating system like xp that this is
possible.
I don't know how i got it, perhaps from email or so called rpc buffer overun
.
But I would like to prevent it happening again. .

these links are very helpful.  for this and device drivers , ide,  for
linux.
thanks.

regards,
paul




----- Original Message -----
From: "Pat LaVarre" <p.lavarre@ieee.org>
To: <linux-ide@vger.kernel.org>
Sent: Monday, June 07, 2004 9:59 AM
Subject: Re: {linux-ide] ide errors redhat 9.0 install


> > List:       linux-ide
> > Subject:    {linux-ide]  ide errors redhat 9.0 install
> > From:       "Paul Gimpelj" <pgi...()sym...>
> > Date:       2004-06-04 3:59:37
> > ...
> > open source documentation on ... bus mastering ...
>
> When I last googled in 2004-03, I found:
>
> /* Design references include these Three sets:
>  *
>  * 1) ATAPI CDB's:
>  *
>  *      bleeding edge: (mmc 5 not yet available)
>  *      last stable: http://www.t10.org/ftp/t10/drafts/mmc4/mmc4r02g.pdf
>  *      oldest original: http://www.bswd.com/sff8020i.pdf
>  *
>  * 2) ATAPI I/O:
>  *
>  *      last stable: http://www.t13.org/docs2002/d1410r3b.pdf (ATA/PI
6.3b)
>  *      oldest original: (again sff 8020i, see above)
>  *
>  * 3) PC I/O:
>  *
>  *      http://developer.intel.com/design/chipsets/datashts/
>  *      http://www.ctyme.com/intr/int.htm
>  *      http://lxr.linux.no/source/include/linux/pci_ids.h
>  *
http://www.google.com/search?q=intel+corporation+pci.exe+version+2.2
>  *
>  *      Intel ICH5 25251601.pdf
>  *
>  *      "Undocumented PC"
>  *      http://www.amazon.com/exec/obidos/ASIN/0201622777
>  *
>  *              "Chapter 7" "Interrupt Vector Table"
>  *                      esp. IRQ 2 9 14 15
>  *
>  *              "Chapter 17" "Interrupt Control and NMI"
>  *
>  *      "PCI System Architecture", Third Edition, 1995 MindShare
>  *      http://www.amazon.com/exec/obidos/ASIN/0201409933
>  *      http://www.amazon.com/exec/obidos/ASIN/0201309742
>  *
>  *      !!FIXME: Find doc to say PIC IRR falls when INTRQ falls.
>  */
>
> Pat LaVarre
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

