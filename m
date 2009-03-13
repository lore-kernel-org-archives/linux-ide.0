From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is
 active for GenIIe
Date: Fri, 13 Mar 2009 09:04:58 -0400
Message-ID: <49BA59FA.1020205@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <49B918F7.2060401@rtr.ca> <49B91B86.7070309@rtr.ca> <200903130907.15965.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:40235 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758316AbZCMNFF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Mar 2009 09:05:05 -0400
In-Reply-To: <200903130907.15965.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
> On Thursday 12 March 2009, Mark Lord wrote:
>> And after you answer that, then does this revised patch work?
>> If not, then perhaps you could try and figure out why,
>> since I just don't have your hardware available to me here.
> 
> I've just tested (on top of .29-rc8) the new development version of the 
> driver you sent me privately, which essentially contains this patch, and 
> it worked perfectly!
> 
> In the final patch, please add my:
> Reported-by: Frans Pop <elendil@planet.nl>
> Tested-by: Frans Pop <elendil@planet.nl>
> 
> Thanks Mark.
..

Super.  Could do one more test, perhaps:
Does it also still work (turn off, turn on) with this
slight change to the copy you were testing there?

Thanks!

--- old/drivers/ata/sata_mv.c	2009-03-12 10:23:41.000000000 -0400
+++ new/drivers/ata/sata_mv.c	2009-03-13 09:03:47.000000000 -0400
@@ -1455,9 +1455,8 @@
 		struct ata_port *this_ap = host->ports[port];
 		struct mv_port_priv *pp = this_ap->private_data;
 
-		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN)
-			if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
-				return;
+		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
+			return;
 	}
 
 	hpriv->hp_flags &= ~MV_HP_QUIRK_LED_BLINK_EN;
