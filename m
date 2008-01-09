From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: implement libata.force_cbl parameter
Date: Wed, 09 Jan 2008 10:46:03 +0900
Message-ID: <4784275B.8050506@gmail.com>
References: <4783786A.6040608@gmail.com>	<20080108144004.30a18457@lxorguk.ukuu.org.uk>	<4784213F.4070203@gmail.com> <20080109013728.3b213cfb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:22435 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYAIBqO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 20:46:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so83995wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 17:46:14 -0800 (PST)
In-Reply-To: <20080109013728.3b213cfb@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> This only forces PATA controllers to certain cable type.  It's a last
>> resort method for installation or live media - just enough to get things
>> going.
> 
> In which case we only need to be able to force UDMA33 or less ?

Cable detection goes wrong and 40c is detected as 80c.  However, we got
(un)lucky and all PIO and short transfers succeed however when large
UDMA transfer starts, the drive detects transmission error and
unfortunately does the right thing - reports transmission error via
check sense.  libata EH currently doesn't analyze sense data and
simplify passes it to sr.  sr knows transmission failure occurred but
there isn't much it can do.

-- 
tejun
