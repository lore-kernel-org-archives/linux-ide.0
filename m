From: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.33-rc2 pata_macio fails to detect PMac G3 CD-drive
Date: Tue, 12 Jan 2010 09:35:26 +0900
Message-ID: <4B4BC3CE.8010102@kernel.org>
References: <19254.17766.674348.933702@pilspetsen.it.uu.se>	 <1263186759.724.132.camel@pasglop>  <4B4ACCDD.8040803@kernel.org> <1263202866.724.134.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47933 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753352Ab0ALAd1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2010 19:33:27 -0500
In-Reply-To: <1263202866.724.134.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hello,

On 01/11/2010 06:41 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2010-01-11 at 16:01 +0900, Tejun Heo wrote:
>> It would be best if the controller has an IRQ pending bit and IRQ can
>> be cleared as spurious on those bogus interrupts.  The reason why SFF
>> IDE interface is so prone to IRQ storm is because there's no way the
>> driver can tell whether the controller is raising interrupt or not.
>> Does the controller have a way to clear IRQ other than reading the
>> status reg?
> 
> Nope. Those old Apple controllers have neither a pending bit nor a
> clear, I think the disk interrupt is wired pretty much directly to
> the PIC.

Eh.... I really hate this part of IDE.  :-(

> I can't tell for sure about Mikael's precise case because I can't
> reproduce it, but in the past, I've seen the CD drive act up similarily
> when touching NIEN on a wallstreet powerbook (same controller, though
> for some reason it doesn't act up for me right now) and reading the
> status reg wasn't clearing the IRQ neither.
> 
> I suspect those guys have the IRQ in some kind of floating state after
> the HW reset and don't get it "right" until they get the first taskfile
> to kick them into some kind of shape...

I think the only solution then is to disable the IRQ from the PIC.
We'll probably need to generalize there a bit as it seems there are
odd cases where we fall into IRQ storm but for now I think adding
special case code with sufficient comment should do it.

Thanks.

-- 
tejun
