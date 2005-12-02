From: "0602@eq.cz" <0602@eq.cz>
Subject: Re: [PATCH] ata_piix: ignore all zero PCS value on ICH5's
Date: Fri, 02 Dec 2005 13:40:06 +0100
Message-ID: <439040A6.2030609@eq.cz>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com> <438FA924.1090005@pobox.com> <438FB8B5.8070505@gmail.com> <20051202032605.GA15528@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cesky-hosting.cz ([81.0.238.178]:24280 "EHLO
	mail.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S1750717AbVLBMkE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 07:40:04 -0500
In-Reply-To: <20051202032605.GA15528@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jean-Fran?ois Stenuit <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
[...]
> Hi, Jean-Francois (sorry, cannot type that character) and 0602.
> 
> Can you guys please verify that this patch works?  This patch is
> supposed to do the same thing as my previous patch with
> override_PCS=1.
[...]

Works for me (10 successful subsequent reboots).

Regards,

r.
