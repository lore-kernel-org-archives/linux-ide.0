From: Kushal Koolwal <kushalkoolwal@gmail.com>
Subject: Re: libata: ATA exception error messages in pata_sch module (CONFIG_PATA_SCH)
Date: Fri, 4 Mar 2011 11:23:58 -0800
Message-ID: <AANLkTi=dEm3ZjATNCJ_Q43y8EFy5fFpXbgAzBus=E3S5@mail.gmail.com>
References: <AANLkTikD3NOA7=zOLRaft8TL=sTgPSCHNNKgTP3AfYWD@mail.gmail.com>
	<4D6D9684.505@gmail.com>
	<AANLkTikpg2d47rAO=FatTe-53Ju4u+YBXt8VKmani8TN@mail.gmail.com>
	<AANLkTimyVVZA3-pKyKUTyqTENRi1w2DXHcmAyg-J_8ok@mail.gmail.com>
	<20110302111251.09d0f1ca@lxorguk.ukuu.org.uk>
	<AANLkTimRqGkyC=Fqk=ekr3KDCauL92XwMZpj9A9aE0Gc@mail.gmail.com>
	<20110304131515.3de216ca@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35676 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759729Ab1CDTX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 14:23:59 -0500
Received: by iyb26 with SMTP id 26so2176642iyb.19
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2011 11:23:59 -0800 (PST)
In-Reply-To: <20110304131515.3de216ca@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, linux-ide@vger.kernel.org

> It won't help in your case as far as I can see because you don't have
> subvendor/subdevice identifiers set just the Intel default ones.
If that is something that can be set by the BIOS (firmware) then it
should not be a problem as I do have access to firmware person for
this system.

> You could try dmidecode I guess, but if one isn't right the other is
> often also missing or incomplete.
Again, I can provide you the exact SMB1 and SMB2 structure information
(System Mfg and System Name) that will be reported by the BIOS to the
Linux kernel. In fact I confirmed that the updated BIOS version for
this system will have the SMB1 and SMB2 fields set in the BIOS to
identify the system for Linux kernel.

Will that help?
