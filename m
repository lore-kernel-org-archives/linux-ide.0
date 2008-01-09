From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata: implement libata.force_cbl parameter
Date: Wed, 09 Jan 2008 14:07:10 +0900
Message-ID: <4784567E.1050600@gmail.com>
References: <4783786A.6040608@gmail.com>	<20080108144004.30a18457@lxorguk.ukuu.org.uk>	<4784213F.4070203@gmail.com>	<20080109013728.3b213cfb@lxorguk.ukuu.org.uk>	<4784275B.8050506@gmail.com> <20080109030502.54914b01@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:23721 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbYAIFHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 00:07:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so173225wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 21:07:16 -0800 (PST)
In-Reply-To: <20080109030502.54914b01@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>>> In which case we only need to be able to force UDMA33 or less ?
>> Cable detection goes wrong and 40c is detected as 80c.  However, we got
> 
> In which case we only (see first question). I don't see why we need to
> force anything but "max speed UDMA 33"

Ah.. yeah, right.  I somehow missed the negation in the question.
There's no need to force 80c usually.  The parameter might be as well
force_40c and only force 40c limit.

-- 
tejun
