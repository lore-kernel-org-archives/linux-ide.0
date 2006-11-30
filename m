From: "Matthias Urlichs" <matthias@urlichs.de>
Subject: Re: [COORDINATE] INIC-1620TA/1622TA2/1623TA2 SATA controllers from
 initio
Date: Thu, 30 Nov 2006 18:09:56 +0000 (UTC)
Message-ID: <ekn6pj$9dt$1@sea.gmane.org>
References: <43D646C2.6040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:667 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030988AbWK3SZu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 13:25:50 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gpqam-0007b2-M7
	for linux-ide@vger.kernel.org; Thu, 30 Nov 2006 19:25:04 +0100
Received: from smurf.noris.de ([192.109.102.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 19:25:04 +0100
Received: from matthias by smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 19:25:04 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 25 Jan 2006 00:24:50 +0900, Tejun Heo wrote:

> I've just bought this brand-new/quite affordable INIC-1622TA2 
> controller.  AFAIK, there's no driver yet. 

Any progress? I acquired two of those beasts today and *really* would like
to get them up&running ASAP. :-/

There seems to be a driver for Linux 2.4 at
http://www.sunix.com.tw/it/en/down/driver/SATA/SATA2100/Linux%202.4.zip
which might be helpful in writing a 2.6 driver.

> http://initio.com/products/sata.htm

The documentation on that page doesn't mention the 1622 any more, only the
1623. Does anybody still have the "old" data sheet?

Which of the sata_*.c drivers would be a good sample code / starting point
for writing a new driver?

Thanks,
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The worst men often give the best advice.
					-- Bailey

