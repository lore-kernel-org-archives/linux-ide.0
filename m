From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Mon, 08 Jan 2007 13:00:28 +0900
Message-ID: <45A1C1DC.5050807@gmail.com>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org> <45A1AC6E.40704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:6733 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030482AbXAHEAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Jan 2007 23:00:35 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7900812wxd
        for <linux-ide@vger.kernel.org>; Sun, 07 Jan 2007 20:00:34 -0800 (PST)
In-Reply-To: <45A1AC6E.40704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> 'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
>> spread yet leaving no easy way to access ATAPI IDENTIFY data.
>> Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Are you certain this works for both big-endian and little-endian?
> 
> A quick "it works" test by somebody on sata_svw (ppc64) or another
> big-endian platform would be nice.

I think it does.  What the code does is identical to what drivers/ide
does.  Anyways, it doesn't really matter, I think we should drop this
patch (3/3 only, that is).  The reason why I implemented this was to get
ATAPI ID data using 'hdparm -i' but as Mark Lord pointed out, 'hdparm
-I' can do IDENTIFY PACKET DEVICE if the kernel is fixed.  I think
that's the way to go.

Thanks.

-- 
tejun
