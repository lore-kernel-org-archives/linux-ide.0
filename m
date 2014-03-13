From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v17 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
Date: Thu, 13 Mar 2014 18:01:52 +0100
Message-ID: <2321534.cVUPvrOVDn@amdc1032>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <1394655573-32645-3-git-send-email-lho@apm.com>
 <1394655573-32645-4-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19872 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbaCMRCI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2014 13:02:08 -0400
In-reply-to: <1394655573-32645-4-git-send-email-lho@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Loc Ho <lho@apm.com>
Cc: olof@lixom.net, tj@kernel.org, arnd@arndb.de, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Tuan Phan <tphan@apm.com>, Suman Tripathi <stripathi@apm.com>

On Wednesday, March 12, 2014 02:19:32 PM Loc Ho wrote:
> This patch adds support for the APM X-Gene SoC AHCI SATA host controller
> driver. It requires the corresponding APM X-Gene SoC PHY driver. This
> initial version only supports Gen3 speed.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for fixing all the remaining issues.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

