From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Tue, 26 Apr 2011 14:37:09 -0400
Message-ID: <4DB710D5.6060901@teksavvy.com>
References: <4D9CD275.9000002@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C749358D0@gretna.indigovision.com> <4D9FACC9.7020200@teksavvy.com> <C1438B59050E1B4C9482FF3266AD6BA32C772D9EB1@gretna.indigovision.com> <4DA45CA7.9040102@teksavvy.com> <4DA467FB.6020905@teksavvy.com> <20110423005610.GC1576@mtj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C775549E4@gretna.indigovision.com> <20110425162242.GB30828@mtj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554BDC@gretna.indigovision.com> <20110426135027.GI878@htj.dyndns.org> <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:37913 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016Ab1DZShM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Apr 2011 14:37:12 -0400
In-Reply-To: <C1438B59050E1B4C9482FF3266AD6BA32C77554C70@gretna.indigovision.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Stenning <b.stenning@indigovision.com>, Tejun Heo <htejun@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-04-26 11:41 AM, Bruce Stenning wrote:
> Tejun wrote:
>> Does the following patch resolve the problem?
>>
>> Thanks.
> 
> I have applied that patch, keeping Mark's mv_set_main_irq_mask spinlock patch
> in place.  I would not like to commit absolutely, for obvious reasons, but I
> have abused the port considerably and have not been able to coax it into
> locking up.

I'm thinking perhaps I should dust off that spinlock patch
and send something more proper like that upstream.

With that mask register shared among the ports, it is really
hard to keep track of when we're locked and when not.
So having a lock just for the shared part of the chip
has got to be a less error-prone way to do it.

I'll pull down a recent -git to patch against first.

Cheers
