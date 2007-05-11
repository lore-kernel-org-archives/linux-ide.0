From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data xfer
 functions
Date: Fri, 11 May 2007 19:42:45 +0200
Message-ID: <4644AB15.5030107@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com>	<20070508134540.509f4704@the-village.bc.nu>	<464073B1.80303@gmail.com>	<4644192A.8090809@tw.ibm.com>	<46441CA9.4030109@tw.ibm.com>	<46447FB5.3040306@gmail.com>	<46449067.70107@tw.ibm.com>	<4644A282.4030008@gmail.com> <20070511183855.65b045bc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:57663 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757700AbXEKRn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 13:43:58 -0400
Received: by py-out-1112.google.com with SMTP id a29so861182pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 10:43:58 -0700 (PDT)
In-Reply-To: <20070511183855.65b045bc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> That would be the cleanest way to do it but I'm not sure whether all
>> controllers can live with that.  If I understand correctly, Some
>> controllers just have to have the whole transfer done atomically.  I
>> think Alan knows much better about this.  Alan?
> 
> Those controllers already do a local IRQ disable in their private
> ->data_xfer method so ought to be ok.

I think what Albert is suggesting is...

	if (last_sector) {
		for (i = 0; i < WORDS_IN_SECTORS - 1; i++)
			ops->data_xfer(word);
		/* HERE */
		spin_lock_irq(ap->lock);
		ops->data_xfer(last word);
		ap->pflags &= ~WQ_IN_PROGRESS_STAY_AWAY_IRQHNDL;
		spin_unlock_irq(ap->lock);
	}

So, it basically splits the last sector into two transfers and nothing
prevents the machine from taking an interrupt at HERE.

Am I understanding it correctly Albert?

-- 
tejun
