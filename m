From: Tejun Heo <tj@kernel.org>
Subject: Re: [smartmontools-support] SATA drive reset/disable events on ICH7
 ata_piix when polling SMART info
Date: Mon, 08 Feb 2010 11:40:58 +0900
Message-ID: <4B6F79BA.6010003@kernel.org>
References: <4B6C2635.105@buttersideup.com> <alpine.DEB.2.00.1002050911500.7774@p34.internal.lan> <4B6C2BC8.7000609@buttersideup.com> <4B6C91F3.5090809@teksavvy.com> <4B6CE473.7060901@kernel.org> <4B6D8A12.70200@buttersideup.com> <4B6DA74C.2040007@teksavvy.com> <4B6DEBA7.2030505@buttersideup.com> <4B6E46DA.9040308@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37096 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414Ab0BHCfA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Feb 2010 21:35:00 -0500
In-Reply-To: <4B6E46DA.9040308@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tim Small <tim@buttersideup.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, "smartmontools-support@lists.sourceforge.net" <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

Hello,

On 02/07/2010 01:51 PM, Mark Lord wrote:
> Tim Small wrote:
>> Mark Lord wrote:
>>> My theory on the problem when I first had it here, was that doing
>>> a FLUSH_CACHE[_EXT] before any PIO command (eg. SMART) should prevent
>>> the problem.  This was never explored further (by me or others).
>>>
>>
>> Would using "option libata force=pio4" be a simple way to start to test
>> this hypothesis?
> ..
> 
> Yup.  If the hypothesis is FALSE, then you'll still see trouble.
> Otherwise, it *might* be correct.  ;)

But that would be a big *might*.  The effect of PIO is a bit too
drastic to indicate postivity (as opposed to ruling out stuff).

Anyways, yeap, no harm in trying.

-- 
tejun
