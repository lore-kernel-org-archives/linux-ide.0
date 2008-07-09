From: Tejun Heo <htejun@gmail.com>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk Extreme
 III 8GB
Date: Wed, 09 Jul 2008 13:10:02 +0900
Message-ID: <48743A1A.2010304@gmail.com>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>	<20080528222740.GB20893@isilmar.linta.de>	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>	<20080607223716.7d142072.komurojun-mbn@nifty.com>	<20080611072029.GB28692@comet.dominikbrodowski.net>	<20080614120055.ad8fbee0.komurojun-mbn@nifty.com>	<48537149.4040102@garzik.org>	<20080614213612.96873c25.komurojun-mbn@nifty.com>	<4855D8E2.10409@gmail.com>	<20080616221145.e3b069b9.komurojun-mbn@nifty.com>	<485669A0.6000404@gmail.com>	<20080617212345.c452d8c5.komurojun-mbn@nifty.com>	<20080706103752.13935ffd.komurojun-mbn@nifty.com>	<4870D46C.7000604@gmail.com> <20080707214253.2406f81a.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:9557 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYGIEKH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2008 00:10:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2775671wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 08 Jul 2008 21:10:07 -0700 (PDT)
In-Reply-To: <20080707214253.2406f81a.komurojun-mbn@nifty.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-pcmcia <linux-pcmcia@lists.infradead.org>, linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, jgarzik@redhat.com, rjw@sisk.pl

Hello,

Komuro wrote:
>> How come ap->lock can get set to bogus address?  Can you please printk
>> &host->lock and ap->lock after ata_host_alloc() without the patch?
> 
> Here is the output of printk.
> Strangely, without the patch, the pata_pcmcia problem happens again.

Ah... super strange.  Can you please try to swap memory sticks around
and see whether anything changes to rule out bad memory?  Another
possibility is DMA corrupting the memory and printk makes the timing
different and dodges the bullet.  Does putting msleep(100) in the
pata_pcmcia init_one make any difference?

Thanks.

-- 
tejun
