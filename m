From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS 180 pata
Date: Mon, 05 Jul 2004 23:52:50 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1089064370.2868.30.camel@uk3.local>
References: <200407051253.47003.ivololeribar@yahoo.it>
	 <200407052305.29015.ivololeribar@yahoo.it>
	 <1089062694.2868.20.camel@uk3.local>
	 <200407052330.11813.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:60079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261426AbUGEVwx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2004 17:52:53 -0400
In-Reply-To: <200407052330.11813.ivololeribar@yahoo.it>
List-Id: linux-ide@vger.kernel.org
To: Nicola <ivololeribar@yahoo.it>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Nicola,

i have not found any different IDE-Hardware from SIS5513/18 and SiS180
in the lspci output. So i assume the additional PATA-ports requires a
special programming in the SiS180 Code. 
I hope that Jeff can helps. He has provided the PATA emulation in
sata_sis.c

regards 
Uwe


