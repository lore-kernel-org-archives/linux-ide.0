From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Subject: Re: unable to set udma >= 3 on ich5 on 2.6.11
Date: Thu, 23 Jun 2005 09:49:51 -0300
Message-ID: <564d96fb050623054973250233@mail.gmail.com>
References: <564d96fb05062005064283caaf@mail.gmail.com>
	 <pan.2005.06.21.17.50.40.495619@ree.hu>
	 <200506212251.27168.rafael.espindola@gmail.com>
	 <pan.2005.06.23.04.48.47.954791@ree.hu>
Reply-To: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:18225 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262416AbVFWMty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jun 2005 08:49:54 -0400
Received: by wproxy.gmail.com with SMTP id 68so444707wra
        for <linux-ide@vger.kernel.org>; Thu, 23 Jun 2005 05:49:52 -0700 (PDT)
In-Reply-To: <pan.2005.06.23.04.48.47.954791@ree.hu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Balazs Ree <ree@ree.hu>
Cc: linux-ide@vger.kernel.org

> To me it seems that there are two implementations of the 80cc ribbon
> detection in the kernel - one is the "standard" and the other one is the
> one that some drives actually implement? Or how is that? Maybe it would be
> good to make the default setting to "true" in the kernel config or rather
> just put some more emphasized hint about this in some docs where people
> bump into it more easily? It is true that the help text of the config
> parameter tells exactly what to do, but otherwise I spent a long time
> investigating this problem before finding the "obvious", and I guess I'm
> not alone.
> 
No. You aren't alone. If all chipsets supported by the same driver
(piix.c for example) use the same algorithm then the there could be
two variation of eighty_ninty_three and each driver could use the
correct one. If this is not the case, a Documentation/UDMA.txt with a
black list would be wonderfull.

Rafael
