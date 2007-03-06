From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 08/30] libata: cable detection fixes
Date: Tue, 06 Mar 2007 06:57:45 -0500
Message-ID: <45ED5739.1060206@garzik.org>
References: <200703061037.l26AbuCk019481@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53707 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965876AbXCFL5r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:57:47 -0500
In-Reply-To: <200703061037.l26AbuCk019481@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> 2.6.21-rc has horrible problems with libata and PATA cable types (and
> thus speeds). This occurs because Tejun fixed a pile of other bugs and
> we now do cable detect enforcement for drive side detection properly.
> 
> Unfortunately we don't do the process around cable detection right. Tejun
> identified the problem and pointed to the right Annex in the spec, this patch
> implements the needed changes.
> 
> The basic requirement is that we have to identify the slave before the
> master.
> 
> The patch switches the identify order so that we can do the drive side
> detection correctly.
> 
> Secondly we add a ->cable_detect() method called after the identify
> sequence which allows a host to do host side detection at this point
> should it wish, or to modify the results of the drive side identify.
> 
> This separate ->cable_detect method also cleans up a lot of code because
> many drivers have their own error_handler methods which really just set
> the cable type.
> 
> If there is no ->cable_detect method the cable type is left alone so a
> driver setting it earlier (eg because it has the SATA flags set or
> because it uses the old error_handler approach) will still do the right
> thing (or at least the same thing) as before.
> 
> This patch simply adds the cable_detect method and helpers it doesn't use
> them but other follow up patches will (ie Adrian please don't submit
> patches to unexport them ;))
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |   59 ++++++++++++++++++++++++++++++++++++
>  include/linux/libata.h    |    7 ++++
>  2 files changed, 66 insertions(+)

applied to #upstream, after fixing the patch description to reflect the 
loss of half of the original patch's functionality


