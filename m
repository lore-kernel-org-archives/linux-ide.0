From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/6] sata_sil: replace sil_3112_m15w board id with sil_3112
Date: Sun, 05 Mar 2006 02:40:12 -0500
Message-ID: <440A95DC.6040708@pobox.com>
References: <11415422321160-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19403 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752008AbWCEHkQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:40:16 -0500
In-Reply-To: <11415422321160-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> All 3112's have m15w.  Replace sil_3112_m15w with sil_3112 and flag
> sil_3112 with SIL_FLAG_MOD15WRITE.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

applied 1, 3, 4, 6


