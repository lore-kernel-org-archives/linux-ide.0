From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: ignore all zero PCS value on ICH5's
Date: Thu, 09 Feb 2006 04:23:51 -0500
Message-ID: <43EB0A27.7080700@pobox.com>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com> <438FB8B5.8070505@gmail.com> <20051202032605.GA15528@htj.dyndns.org> <43DC510A.1090101@pobox.com> <43E01691.9040600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:26014 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030314AbWBIJYB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 04:24:01 -0500
In-Reply-To: <43E01691.9040600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jean-Fran?ois Stenuit <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, "0602@eq.cz" <0602@eq.cz>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> How about making it a driver option?  ata_piix.ignore_PCS maybe?

I'm OK with that.

	Jeff



