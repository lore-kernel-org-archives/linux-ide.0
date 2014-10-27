From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] ata: sata_rcar: Disable DIPM mode for r8a7790 ES1
Date: Mon, 27 Oct 2014 09:14:46 +0900
Message-ID: <20141027001446.GB25692@verge.net.au>
References: <1414116319-16813-1-git-send-email-horms+renesas@verge.net.au>
 <544A2E37.6090206@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33607 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaJ0AOz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Oct 2014 20:14:55 -0400
Content-Disposition: inline
In-Reply-To: <544A2E37.6090206@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 02:47:19PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/24/2014 6:05 AM, Simon Horman wrote:
> 
> >Unlike other SATA R-Car r8a7790 controllers the r8a7790 ES1 SATA R-Car
> >controller needs to be run with DIPM disabled.
> 
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >---
> >v2
> >* Handle ES1 in sata_rcar_init_controller()
> >---
> >  Documentation/devicetree/bindings/ata/sata_rcar.txt |  3 ++-
> >  drivers/ata/sata_rcar.c                             | 11 +++++++++++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> [...]
> >diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> >index 61eb6d7..b398513 100644
> >--- a/drivers/ata/sata_rcar.c
> >+++ b/drivers/ata/sata_rcar.c
> [...]
> >@@ -763,6 +764,10 @@ static void sata_rcar_setup_port(struct ata_host *host)
> >  	ap->udma_mask	= ATA_UDMA6;
> >  	ap->flags	|= ATA_FLAG_SATA;
> >
> >+	if (priv->type == RCAR_R8A7790_ES1_SATA) {
> >+		ap->flags	|= ATA_FLAG_NO_DIPM;
> >+	}
> >+
> 
>    Please, please drop {}. I think checkpatch.pl should complain about them...

Thanks, done.
