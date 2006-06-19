From: Mark Lord <mlord@pobox.com>
Subject: Re: regarding conversion to new EH
Date: Mon, 19 Jun 2006 17:23:22 -0400
Message-ID: <449715CA.1030902@pobox.com>
References: <20060617113104.GC11755@htj.dyndns.org> <4493EF61.9060103@pobox.com> <449412FD.8030102@pobox.com> <4494BB5F.6030108@gmail.com> <44971421.1070206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:46061 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S964895AbWFSVX1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2006 17:23:27 -0400
In-Reply-To: <44971421.1070206@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> 
> My AMD64 test system, running 2.6.17, gets stuck in libata initialization
> for the pdc_adma cards -- looks like interrupts aren't working in the driver.
> 
> So now I'm building a 2.6.15 kernel, to run on the same machine that I
> originally used to test this driver (a P4 system), and we'll eventually
> find out what went wrong.   And maybe I can get these cards tested and
> shipped, too.  (never lose sight of the original goal!).

Okay, no problems on 2.6.15.7, so it must be something that changed
in libata/pdc_adma since then.  I'll start a 2.6.16.15 build now..

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

