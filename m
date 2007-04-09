From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata#upstream] sata_promise: fix error decode regression
Date: Mon, 09 Apr 2007 18:16:25 +0900
Message-ID: <461A0469.4020905@gmail.com>
References: <200704090854.l398sQM9019670@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:6459 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbXDIJQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 05:16:31 -0400
Received: by nz-out-0506.google.com with SMTP id s1so983156nze
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2007 02:16:30 -0700 (PDT)
In-Reply-To: <200704090854.l398sQM9019670@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> On Mon, 09 Apr 2007 16:52:53 +0900, Tejun Heo wrote:
>> Mikael Pettersson wrote:
>>> Promise ATA ports should always be reset by pdc_reset_port()
>>> when errors are detected, but the recent error reason decoding
>>> update to sata_promise replaced that reset with a freeze.
>>>
>>> This patch changes the error detection to do a reset again.
>>> This makes the error decoding update safer, as it now only
>>> adds error decoding without changing any other behaviour.
>>>
>>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
>> Not necessarily NAK'ing but I think it's better to do things like that
>> in EH thread not in the interrupt handler.  Isn't freezing enough in the
>> interrupt handler?
> 
> You're right that the reset should be in the EH code.
> But it isn't right now (the resets done there are generic
> ones, not the Promise-specific one the HW really wants),
> so the error decoding change caused a regression that
> needs to be fixed.
> 
> I intend to change the interrupt handler to just freeze and
> add a Promise-specific reset to EH in a separate patch.

Great, then.  No objection from me.

-- 
tejun
