From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: SiS 180 pata
Date: Mon, 05 Jul 2004 23:24:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1089062694.2868.20.camel@uk3.local>
References: <200407051253.47003.ivololeribar@yahoo.it>
	 <200407051603.48708.ivololeribar@yahoo.it>
	 <1089059471.2868.9.camel@uk3.local>
	 <200407052305.29015.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:1153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262101AbUGEVY5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2004 17:24:57 -0400
In-Reply-To: <200407052305.29015.ivololeribar@yahoo.it>
List-Id: linux-ide@vger.kernel.org
To: Nicola <ivololeribar@yahoo.it>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello Nicola,

please provide the complete output of lspci -vvxxx, not only the the
device 1039:0180. I want to see, if there is a different IDE-Adapter
to SIS5513/18 and SiS180.
If not, the pata ports may be the slaves on SIS180.

regards
Uwe

> Here we are:
> 
> 00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS]: Unknown device 


