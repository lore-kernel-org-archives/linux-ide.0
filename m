From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: workaround DRQ=1 ERR=1 for ATAPI tape drives
Date: Wed, 14 Nov 2007 11:00:46 +0900
Message-ID: <473A56CE.4080804@gmail.com>
References: <471C6C44.2030607@gmail.com>	<471CEDD4.5040201@garzik.org>	<471D25D0.9020702@rtr.ca>	<47397784.9070205@tw.ibm.com>	<47397CC0.1070401@tw.ibm.com>	<4739AB5B.7000703@rtr.ca>	<20071113151459.086ffcae@the-village.bc.nu>	<4739DDDD.7060305@rtr.ca> <20071113181257.24ab95dd@the-village.bc.nu> <4739EB53.5010206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:19080 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534AbXKNCAx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 21:00:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so21452rvb
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 18:00:53 -0800 (PST)
In-Reply-To: <4739EB53.5010206@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertl@mail.com, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> ERR should stay set until the next command has been written to the device.
> So we could try and be clever to ignore ERR after PACKET, before CDB, only
> if it was set by previous command.
> 
> Sounds a bit complex.
> 
> Just (unconditionally for tape) ignoring it between PACKET and CDB might
> be simpler.

/me agrees.  Albert, can you re-spin the patch?  Thanks.

-- 
tejun
