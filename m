From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: make hardreset return -EAGAIN
 on success
Date: Fri, 25 Apr 2008 00:48:13 -0400
Message-ID: <4811628D.20605@garzik.org>
References: <480EA97D.8080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46577 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131AbYDYEs1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:48:27 -0400
In-Reply-To: <480EA97D.8080704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: marc.c.dionne@gmail.com, Petr Vandrovec <vandrove@vc.cvut.cz>, Roland Dreier <rdreier@cisco.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> sata_nv hardreset can't classify but was left out while unifying
> follow-up SRST request mechanism[1].  This caused detection failures
> on those controllers.  Fix it.
> 
> Reported and bisected by Roland Dreier, Petr Vandrovec and Marc
> Dionne.  Thanks guys.
> 
> [1] 305d2a1ab137d11d573319c315748a87060fe82d
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Roland Dreier <rdreier@cisco.com>
> Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
> Cc: Marc Dionne <marc.c.dionne@gmail.com>
> ---
> It actually was a single fall out I missed.  This is the proper fix
> and verfied on ck804.
> 
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index 109b074..858f706 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -1591,13 +1591,16 @@ static void nv_mcp55_thaw(struct ata_port *ap)
> static int nv_hardreset(struct ata_link *link, unsigned int *class,
>             unsigned long deadline)
> {
> -    unsigned int dummy;
> +    int rc;
> 
>     /* SATA hardreset fails to retrieve proper device signature on
> -     * some controllers.  Don't classify on hardreset.  For more
> -     * info, see http://bugzilla.kernel.org/show_bug.cgi?id=3352
> +     * some controllers.  Request follow up SRST.  For more info,
> +     * see http://bugzilla.kernel.org/show_bug.cgi?id=3352
>      */
> -    return sata_sff_hardreset(link, &dummy, deadline);
> +    rc = sata_sff_hardreset(link, class, deadline);
> +    if (rc)
> +        return rc;
> +    return -EAGAIN;
> }

applied


