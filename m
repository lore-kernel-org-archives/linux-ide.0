From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Wed, 8 Aug 2007 10:35:03 +0100
Message-ID: <20070808103503.2eb6303a@the-village.bc.nu>
References: <20070807054250.GQ13674@htj.dyndns.org>
	<20070807162529.1781b21c@the-village.bc.nu>
	<46B89177.2040209@gmail.com>
	<20070807175844.6818ffc9@the-village.bc.nu>
	<46B92894.8060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45172 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbXHHJ21 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 05:28:27 -0400
In-Reply-To: <46B92894.8060502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

On Wed, 08 Aug 2007 11:21:08 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> >>> I'd rather know what is going on here. A drive can legitimately
> >>> support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
> >> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no
> > 
> > Ok the report in that thread is different. The offending Maxtor simply
> > aborts the read_native_max_ext
> 
> I'll resend sans ata_id_has_hpa() change.  Does that sound okay?  I
> don't really think we can do anything other than blacklisting it.

Other than finding someone who can test it with a different controller
(especially SI3112 and old-ide) I agree
