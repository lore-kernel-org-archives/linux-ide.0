From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22,
 kernel panic in 2.6.23
Date: Thu, 15 Nov 2007 10:06:23 +0900
Message-ID: <473B9B8F.9030905@gmail.com>
References: <200711121025.lACAPf3S017955@harpo.it.uu.se>	 <473840A2.5090909@gmail.com> <6f048fc10711140033x43358a8cxf5e9df8d4328d135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:9010 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbXKOBGc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 20:06:32 -0500
Received: by wa-out-1112.google.com with SMTP id v27so442502wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 17:06:32 -0800 (PST)
In-Reply-To: <6f048fc10711140033x43358a8cxf5e9df8d4328d135@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: I Stratford <i.d.stratford@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

I Stratford wrote:
> On Nov 12, 2007 4:01 AM, Tejun Heo <htejun@gmail.com> wrote:
> 
>> Mikael Pettersson wrote:
>>> First, a workaround for a HW erratum affecting 2nd-generation
>>> chips like the SATA300 TX4 was included in kernel 2.6.24-rc2.
>> ...
>> Alright, if it's fixable, no problem.  I just wanted to remind that
>> running the link at 3Gbps isn't worth if it continues to cause problems.
> 
> I appreciate the replies and ensuing discussion. I will test
> 2.6.24-rc2 as soon as possible and let you know the results. At that
> time I'll also have more runtime on the 1.5Gbps forced 2.622 and will
> be able to follow-up. Would you (Tejun, Mikael) prefer that I mail
> linux-ide or you directly? I checked for a linux-ide FAQ and didn't
> find one.. :)

Please cc all involved including linux-ide.

> Mikael :
>>> Secondly, Stratford's system is seriously overloaded:
>>> ...
>>> - problems began when two Promise 300 TX4 cards and
>>>   more disks were added
>>> On several occasions we've traced people's problems to
>>> overtaxed system components (cooling, PSU, PCI busses).
> 
> Tejun:
>> Agreed, I've seen my share of those issues.  Especially, SATA links seem
>> very dependent on power quality and very weird things happen when the
>> power isn't good enough.  Easy way to debug this is connect half of the
>> drives to a separate PSU and see what happens.
> 
> While I agree that the configuration is "seriously overloaded" (I
> believe I described it as "admittedly somewhat insane" ;D) I haven't
> experienced any port-resets or timeouts on my new TX4 300s, coming up
> on a week of runtime with the 1.5Gbps-only 2.6.22 patched kernel.
> Also, the problems did not generally extend to the two pre-existing
> TX4 150s on the same PCI bus, even when the TX4 300s were having
> problems. If hardware overheating/PCI overload/PSU problems were the
> cause, it seems like a very lucky coincidence that stepping the TX4
> 300s to 1.5Gbps mode also resolves it.  :D

One thing I can tell you is power problem shows itself in highly diverse
ways.  Failing 3Gbps while 1.5 works fine, some subset of disks /
controllers work fine while others don't.  You name it.

> The system's 23 drives are spread across 3 good quality power
> supplies. As indicated in my initial mail, I have swapped the PSU on
> the new drive with a new one, specifically a 430 watt cooler master
> PSU which by my kill-a-watt gives me ~250 watts of headroom even
> during spin-up. While my building power is notoriously lousy, I find a
> building-power or PSU-power-quality explanation somewhat unlikely,
> especially in light of the consistent performance of the two TX4 150s
> and the night-and-day performance of 1.5Gbps patched 2.6.22 vice
> unpatched 2.6.22 on the two TX4 300s.

That said, using one or more PSUs and swapping them is the best way to
rule those problems out.

-- 
tejun
