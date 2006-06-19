From: Mark Lord <mlord@pobox.com>
Subject: Re: regarding conversion to new EH
Date: Mon, 19 Jun 2006 17:16:17 -0400
Message-ID: <44971421.1070206@pobox.com>
References: <20060617113104.GC11755@htj.dyndns.org> <4493EF61.9060103@pobox.com> <449412FD.8030102@pobox.com> <4494BB5F.6030108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:8680 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S964894AbWFSVQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2006 17:16:22 -0400
In-Reply-To: <4494BB5F.6030108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


Mark Lord wrote:
>> I'll see if I can find a PDC ADMA card, to verify.

Heh.. I was getting ready to package a pair of ADMA cards for Tejun just now,
and decided to test them first to ensure they were "good cards".

My AMD64 test system, running 2.6.17, gets stuck in libata initialization
for the cards -- looks like interrupts aren't working in the driver.

So now I'm building a 2.6.15 kernel, to run on the same machine that I
originally used to test this driver (a P4 system), and we'll eventually
find out what went wrong.   And maybe I can get these cards tested and
shipped, too.  (never lose sight of the original goal!).

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

