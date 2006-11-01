From: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Subject: Re: sata_promise issue with SATA 300 TX4 (PDC40718)
Date: Wed, 01 Nov 2006 18:25:58 +0100
Message-ID: <4548D8A6.1020405@gmx.de>
References: <200610291310.01120.tbaumgartner@swissonline.ch> <4544EEC5.2020808@gmx.de> <200611011321.26568.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:4071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1946568AbWKAR0F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 12:26:05 -0500
In-Reply-To: <200611011321.26568.tbaumgartner@swissonline.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Theo Baumgartner schrieb:
> Several times i heard a sound like the disk head is banging against
> the case. Got me very paranoic about disk failure. Why should a brand new disk
> make such a noise? Is this still related to these failures/messages/whatever the 
> kernel now giving out in Mbyte chunks (yes log is realy growing rapidly)?
>   
I never heard such a noise on my harddisk (Maxtor 6L200M0). You should 
check SMART status of your drive, if there are problems on the harddisk 
it will surely show up in the SMART attributes or even the SMART log (if 
it's in the log, it's time to backup your harddrive and replace it).

P.S. Perhaps the acoustic management is set to loud (check with hdparm 
or similar program).

Ansgar Knappheide
