From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Very old IDE hard drive (240 MB) detected as 1.1 TB
Date: Sat, 14 Feb 2009 15:31:17 +0000 (GMT)
Message-ID: <alpine.LFD.1.10.0902141526310.651@ftp.linux-mips.org>
References: <200902131428.40212.hanno@hboeck.de> <499584FC.2050104@gmail.com> <200902141352.24277.hanno@hboeck.de> <4996C563.9090900@ru.mvista.com> <4996D443.4060103@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([213.58.128.207]:35261 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZBNPba (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 10:31:30 -0500
Received: from localhost.localdomain ([127.0.0.1]:39592 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S21365670AbZBNPbS (ORCPT <rfc822;linux-ide@vger.kernel.org>
	+ 1 other); Sat, 14 Feb 2009 15:31:18 +0000
In-Reply-To: <4996D443.4060103@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, =?ISO-8859-15?Q?Hanno_B=F6ck?= <hanno@hboeck.de>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>

On Sat, 14 Feb 2009, Mark Lord wrote:

> >   It has the current capacity in words 57-58 swapped:
> > 
> > /dev/sdb:
> > 0c5a 037f 0000 000a 8723 0275 0037 0030
> > 000a 0000 2020 2020 2020 2020 2020 424d
> > 3948 4d31 5020 2020 0003 0040 0004 302e
> > 3336 2020 2020 436f 6e6e 6572 2050 6572
> > 6970 6865 7261 6c73 2032 3430 4d42 202d
> > 2043 5033 3032 3534 2020 2020 2020 8010
> > 0000 0001 0000 0200 0202 0001 037f 000a
> > 0037 0007 82da 0000 0000 0000 0000 0000
> > 
> > 
> >   It must be 82da 0007, not 0007 82da.
> >   IIRC, the IDE core doesn't trust the value reported in these words 
> ..
> 
> That's right.  I wrote the IDE code that way
> *specifically* due to a (different) Conner drive
> I had here at the time.

 It happened for some Maxtor drives too.  The reason is the ATA-1 spec was 
not explicit about how words 57 and 58 were meant to be ordered and some 
manufacturers interpreted it one and some the other way.  It looks like 
libata needs to be fixed.

  Maciej
