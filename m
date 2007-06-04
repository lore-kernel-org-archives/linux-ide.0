From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Mon, 04 Jun 2007 22:24:50 +0200
Message-ID: <46647512.1000408@gmx.net>
References: <200705250948.52588.uwe.koziolek@gmx.net>	<20070525153230.325258e9@the-village.bc.nu>	<465D33DF.9040708@gmx.net> <20070604163022.1adf136f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751914AbXFDUYw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jun 2007 16:24:52 -0400
In-Reply-To: <20070604163022.1adf136f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux.ide" <linux-ide@vger.kernel.org>

How should I proceed. I can submit both patches:
>> - exclude SiS180 from enable bit checking or
>> - exclude MuTol ATA133 from enable bit checking with different
>> error_handler.
>>     
>
> Been away but - SiS180 wants excluding anyway according to all the docs,
> the MuToL does appear to be working correctly with enable bits and we've
> got no failure cases in old/new IDE so leave it alone (for now anyway)
>   
I have checked some SiS 5513 config spaces with ATA133 for the enable
bits. In all cases Alans
code would work. But I dont know why the necesary bits are set. May be
the hardware is different
to the documentation or the BIOS is setting these bits for compatibility
issue.

The change of the error handler for SiS180 is really needed. The change
of the errorhandler for
Pre ATA133 chips is not reasonable.  The change of the  errorhandler 
for  SiS5513  ATA133
controller is not mandatory.

My suggestion: exclude only the SiS180 from the enable bits.

But i want to have an ok , or a vote for the other variant.

Uwe





