From: Kushal Koolwal <kushalkoolwal@gmail.com>
Subject: Re: libata: ATA exception error messages in pata_sch module (CONFIG_PATA_SCH)
Date: Thu, 3 Mar 2011 16:18:14 -0800
Message-ID: <AANLkTimRqGkyC=Fqk=ekr3KDCauL92XwMZpj9A9aE0Gc@mail.gmail.com>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
	<4D6D9684.505@gmail.com>
	<AANLkTikpg2d47rAO=FatTe-53Ju4u+YBXt8VKmani8TN@mail.gmail.com>
	<AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
	<20110302111251.09d0f1ca@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37644 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab1CDASP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Mar 2011 19:18:15 -0500
Received: by iyb26 with SMTP id 26so1443852iyb.19
        for <linux-ide@vger.kernel.org>; Thu, 03 Mar 2011 16:18:14 -0800 (PST)
In-Reply-To: <20110302111251.09d0f1ca@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

> SCH is going to be on the motherboard so for systems where the detect
> fails it's probably easiest to take the PIIX approach and spot them by
> svid/sdid on the PCI device.

As suggested by Alan, what would it take to implement this in the SCH
driver? Filing this report at bugzilla?

I would gladly provide any further information of the system on which
I am seeing these messages.
