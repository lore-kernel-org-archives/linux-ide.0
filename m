From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: mask off DET when restoring SControl
 for detach
Date: Tue, 04 Nov 2008 01:11:11 -0500
Message-ID: <490FE77F.8020600@garzik.org>
References: <490ED1FB.9080505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45554 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbYKDGLO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:11:14 -0500
In-Reply-To: <490ED1FB.9080505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> libata restores SControl on detach; however, trying to restore
> non-zero DET can cause undeterministic behavior including PMP device
> going offline till power cycling.  Mask off DET when restoring
> SControl.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/ata/libata-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: work/drivers/ata/libata-core.c
> ===================================================================
> --- work.orig/drivers/ata/libata-core.c
> +++ work/drivers/ata/libata-core.c
> @@ -5936,7 +5936,7 @@ static void ata_port_detach(struct ata_p
>  	 * to us.  Restore SControl and disable all existing devices.
>  	 */
>  	__ata_port_for_each_link(link, ap) {
> -		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol);
> +		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol & 0xff0);
>  		ata_link_for_each_dev(dev, link)
>  			ata_dev_disable(dev);

applied


