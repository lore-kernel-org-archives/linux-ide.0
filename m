From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: ahci_sunxi: disable resources on driver removal
Date: Mon, 17 Mar 2014 14:16:16 +0100
Message-ID: <1541332.S2AMpmTS9V@amdc1032>
References: <4639408.hubNkUp5Oa@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:23614 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbaCQNQd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2014 09:16:33 -0400
In-reply-to: <4639408.hubNkUp5Oa@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Oliver Schinagl <oliver@schinagl.nl>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Monday, March 17, 2014 02:05:15 PM Bartlomiej Zolnierkiewicz wrote:
> Add custom ->host_stop method to disable resources on driver removal.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

After looking some more into ahci_platform.c it seems that this patch
is not needed, sorry for the noise.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

