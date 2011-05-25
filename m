From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Wed, 25 May 2011 18:27:11 -0400
Message-ID: <4DDD823F.5090904@teksavvy.com>
References: <20110423005610.GC1576@mtj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C775549E4@gretna.indigovision.com> <20110425162242.GB30828@mtj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554BDC@gretna.indigovision.com> <20110426135027.GI878@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com> <20110426155229.GM878@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554C91@gretna.indigovision.com> <20110430140109.GJ29280@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com> <20110525094127.GF10146@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C7770967B@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:14246 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754275Ab1EYW1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2011 18:27:13 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C7770967B@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-05-25 09:36 AM, Bruce Stenning wrote:
>> This is a different issue.  libata EH plugs the port if reset fails
>> repeatedly.  This behavior was implemented to avoid causing continuous
>> resets on a port in case it has flaky PHY state reporting; however, it
>> seems to cause more trouble than fixing issues - ie. plugging in a
>> broken device may end up plugging the port even after the offending
>> device is removed until manual rescan or reboot.  I've been pondering
>> about changing the behavior like the following.
> 
> Thanks for the explanation, Tejun, and for sending those changes upstream.
> I shall incorporate these patches into my kernel and keep you informed as
> to how they behave.
> 
> Mark, did you get a chance to clean up the sata_mv spinlock addition in
> mv_set_main_irq_mask?

Not yet.  I've been waiting to hear back from you as to
whether they visibly fix anything or not.
