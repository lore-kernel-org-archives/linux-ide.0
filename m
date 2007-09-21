From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 2
Date: Fri, 21 Sep 2007 12:19:00 +0900
Message-ID: <46F33824.6000707@gmail.com>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.236]:8851 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXIUDTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 23:19:08 -0400
Received: by qb-out-0506.google.com with SMTP id e11so531536qbe
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 20:19:08 -0700 (PDT)
In-Reply-To: <20070921031245.GA6628@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Matthew Garrett wrote:
> On Fri, Sep 21, 2007 at 12:08:07PM +0900, Tejun Heo wrote:
> 
>> Yeah, that's the intended behavior.  SATA PHY link can break from time
>> to time (have ever seen a SATA storage box going through ECC testing?
>> PHY goes offline as soon as you begin to hit it with some EM pulses) and
>> you don't really wanna lose your root partition over power fluctuation.
> 
> In this case we explicitly know that it's in response to a hotplug event 
> (well, either that or the firmware is on impressive crack). Would it be 
> possible to communicate that in order to avoid the revalidation?

No, I don't thinks so && I don't really think trusting firmware that
much is a good idea.  Also, it's much better to fix the problem in
general than just fixing it for the firmware case which will be much
less than the rest.

-- 
tejun
