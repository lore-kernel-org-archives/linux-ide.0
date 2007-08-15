From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4] libata: implement BROKEN_HPA horkage and apply to
 affected drives
Date: Thu, 16 Aug 2007 03:21:19 +0900
Message-ID: <46C3441F.4010806@gmail.com>
References: <20070815180508.GD21623@htj.dyndns.org>	<20070815180721.GF21623@htj.dyndns.org> <20070815192257.126fa84b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:62146 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765327AbXHOSV0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:21:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so6262wah
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 11:21:26 -0700 (PDT)
In-Reply-To: <20070815192257.126fa84b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> +	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
>> +	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
>> +	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
> 
> 
> I'm still a little bothered that we haven't seen these reported with old
> IDE (unlike the off by one which was there once you knew where to look).
> Guess they've simply not shown up as they are all SATA

Dunno much about HDS but both WDCs are fairly new ones.  The reporter of
bug 8888 confirmed the problem on via and sil controllers, so it's
fairly certain that it's a drive firmware bug.  Weird.

-- 
tejun
