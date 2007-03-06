From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 04/30] ACPI driver support for pata
Date: Tue, 06 Mar 2007 21:54:50 +0900
Message-ID: <45ED649A.20207@gmail.com>
References: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:40590 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933875AbXCFMyx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 07:54:53 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1892796wxd
        for <linux-ide@vger.kernel.org>; Tue, 06 Mar 2007 04:54:52 -0800 (PST)
In-Reply-To: <200703061037.l26AbrtB019463@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, lenb@kernel.org

Hello,

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> - Add a driver for motherboard ACPI method devices
> 
> - Link it after normal drivers so ACPI is not preferred
> 
> - Hook the AMD driver to prefer ACPI for the Nvidia devices if ACPI is
>   active
> 
> - While we are at it fix up the simplex clear the AMD driver.
> 
> Depends upon the set_mode -> do_set_mode wrapper patch
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Can't find the original posting, so replying here.  Alan, Jeff, can you
guys hold a bit with pata_acpi?  I think it's better to implement
helpers in libata-acpi and use them as necessary in sata_nv rather than
using separate pata_acpi driver (we can definitely implement pata_acpi
using the helpers).  It will reduce general confusion and allow
combining acpi cable detection with specialized device handling (e.g.
ACPI cable detection combined with ADMA command operation).

libata-acpi also needs quite some amount of other improvements.  I'll
post prototype code and things to discuss about later this week.

Thanks.

-- 
tejun
