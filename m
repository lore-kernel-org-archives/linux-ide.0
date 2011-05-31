From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Mon, 30 May 2011 22:04:58 -0400
Message-ID: <4DE44CCA.20608@teksavvy.com>
References: <20110423005610.GC1576@mtj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C775549E4@gretna.indigovision.com> <20110425162242.GB30828@mtj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554BDC@gretna.indigovision.com> <20110426135027.GI878@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com> <20110426155229.GM878@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554C91@gretna.indigovision.com> <20110430140109.GJ29280@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com> <20110525094127.GF10146@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C7770967B@gretna.indigovision.com> <4DDD823F.5090904@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C7777DD92@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:53082 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751662Ab1EaCFB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2011 22:05:01 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C7777DD92@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-05-30 09:07 AM, Bruce Stenning wrote:
>>> Mark, did you get a chance to clean up the sata_mv spinlock addition in
>>> mv_set_main_irq_mask?
>>
>> Not yet.  I've been waiting to hear back from you as to
>> whether they visibly fix anything or not.
> 
> Having now tested with Tejun's two patches and without the spinlock in
> mv_set_main_irq_mask for a reasonable time, the hotplug seems to be very
> reliable.  So I think it's probably best to leave the spinlock out and
> continue to observe the behaviour with further testing.

Peachy.  I'll have another look at some point -- I think I thought
the spinlock was still needed for ATAPI under some conditions.
Gotta look closer to make sure.

Thanks.
