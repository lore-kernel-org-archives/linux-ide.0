From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH libata#upstream] sata_promise: fix error decode regression
Date: Mon, 9 Apr 2007 10:54:26 +0200 (MEST)
Message-ID: <200704090854.l398sQM9019670@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:54701 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbXDIIyj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Apr 2007 04:54:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Mon, 09 Apr 2007 16:52:53 +0900, Tejun Heo wrote:
>Mikael Pettersson wrote:
>> Promise ATA ports should always be reset by pdc_reset_port()
>> when errors are detected, but the recent error reason decoding
>> update to sata_promise replaced that reset with a freeze.
>> 
>> This patch changes the error detection to do a reset again.
>> This makes the error decoding update safer, as it now only
>> adds error decoding without changing any other behaviour.
>> 
>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
>
>Not necessarily NAK'ing but I think it's better to do things like that
>in EH thread not in the interrupt handler.  Isn't freezing enough in the
>interrupt handler?

You're right that the reset should be in the EH code.
But it isn't right now (the resets done there are generic
ones, not the Promise-specific one the HW really wants),
so the error decoding change caused a regression that
needs to be fixed.

I intend to change the interrupt handler to just freeze and
add a Promise-specific reset to EH in a separate patch.

/Mikael
