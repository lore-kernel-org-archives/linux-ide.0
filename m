From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: ATA exception error messages in pata_sch module
 (CONFIG_PATA_SCH)
Date: Fri, 4 Mar 2011 13:15:15 +0000
Message-ID: <20110304131515.3de216ca@lxorguk.ukuu.org.uk>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
	<4D6D9684.505@gmail.com>
	<AANLkTikpg2d47rAO=FatTe-53Ju4u+YBXt8VKmani8TN@mail.gmail.com>
	<AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
	<20110302111251.09d0f1ca@lxorguk.ukuu.org.uk>
	<AANLkTimRqGkyC=Fqk=ekr3KDCauL92XwMZpj9A9aE0Gc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48497 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758463Ab1CDNPT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 08:15:19 -0500
In-Reply-To: <AANLkTimRqGkyC=Fqk=ekr3KDCauL92XwMZpj9A9aE0Gc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kushal Koolwal <kushalkoolwal@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

On Thu, 3 Mar 2011 16:18:14 -0800
Kushal Koolwal <kushalkoolwal@gmail.com> wrote:

> > SCH is going to be on the motherboard so for systems where the detect
> > fails it's probably easiest to take the PIIX approach and spot them by
> > svid/sdid on the PCI device.
> 
> As suggested by Alan, what would it take to implement this in the SCH
> driver? Filing this report at bugzilla?

It won't help in your case as far as I can see because you don't have
subvendor/subdevice identifiers set just the Intel default ones. That
means there isn't an immediate PCI way to tell your system from others.

You could try dmidecode I guess, but if one isn't right the other is
often also missing or incomplete.
