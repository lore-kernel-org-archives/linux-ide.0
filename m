From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Wed, 08 Aug 2007 11:21:08 +0900
Message-ID: <46B92894.8060502@gmail.com>
References: <20070807054250.GQ13674@htj.dyndns.org>	<20070807162529.1781b21c@the-village.bc.nu>	<46B89177.2040209@gmail.com> <20070807175844.6818ffc9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:59370 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567AbXHHCWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 22:22:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so22206rvb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 19:22:17 -0700 (PDT)
In-Reply-To: <20070807175844.6818ffc9@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

Alan Cox wrote:
>>> I'd rather know what is going on here. A drive can legitimately
>>> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
>> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no
> 
> Ok the report in that thread is different. The offending Maxtor simply
> aborts the read_native_max_ext

I'll resend sans ata_id_has_hpa() change.  Does that sound okay?  I
don't really think we can do anything other than blacklisting it.

-- 
tejun
