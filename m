From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA PMP support in 2.6.24-rc3?
Date: Tue, 08 Jan 2008 21:27:34 +0900
Message-ID: <47836C36.4040701@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com> <474E2F5E.1010509@23palmer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070406060605090006070604"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:41579 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYAHM1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 07:27:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so7455167rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 04:27:40 -0800 (PST)
In-Reply-To: <474E2F5E.1010509@23palmer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Evans <tom@23palmer.net>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406060605090006070604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tom Evans wrote:
> 
> I'm also seeing this with 2.6.23-rc3 on my Alpha system - sata_sil24 and
> a SiliconImage PMP.

Gaston, Tom, can you guys please apply the attached patch on top of
2.6.24-rc7 and see whether the problem goes away.

Thanks.

-- 
tejun

--------------070406060605090006070604
Content-Type: text/x-patch;
 name="limit-link-to-1.5Gbps.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="limit-link-to-1.5Gbps.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4753a18..8dcf08f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6726,6 +6726,7 @@ int sata_link_init_spd(struct ata_link *link)
 	spd = (scontrol >> 4) & 0xf;
 	if (spd)
 		link->hw_sata_spd_limit &= (1 << spd) - 1;
+	link->hw_sata_spd_limit = 1;
 
 	link->sata_spd_limit = link->hw_sata_spd_limit;
 

--------------070406060605090006070604--
