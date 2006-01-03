From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Tue, 03 Jan 2006 12:43:48 -0500
Message-ID: <43BAB7D4.4050204@pobox.com>
References: <20060103164319.GA402@havoc.gtf.org>	 <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com> <1136309555.22598.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64656 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932385AbWACRoE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 12:44:04 -0500
In-Reply-To: <1136309555.22598.10.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-01-03 at 17:51 +0100, Bartlomiej Zolnierkiewicz wrote:
> 
>>>+ * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
>>>+ * for the early chip drivers.
>>
>>pata_oldpiix and pata_mpiix are not in the mainline
> 
> 
> They are probably ready for mainline and since Linux currently has no
> support for either it might be nice to get them in. Anything specific
> they need polishing for Jeff ?

Not really.  If there's no support in mainline, I'm ok with pushing them 
upstream...  provided that they have been tested and verified to work on 
at least one machine?  :)

	Jeff



