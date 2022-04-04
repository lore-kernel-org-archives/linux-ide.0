Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A32DC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  4 Apr 2022 01:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358373AbiDDBMs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Apr 2022 21:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiDDBMr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Apr 2022 21:12:47 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D5433343
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 18:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649034652; x=1680570652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mEnXkc2aXmWFQmJNXsTtqNXWzplpMwoyDFJjQew2C84=;
  b=fd02nYneESa1+yVU4doYPtuBkfdrpQliwBJznnTLLEPiOS+E/fRq5ahd
   VeyZ8ucIZpM8VAfL4rjsdbUbOLx7s1CBvwc8hm+BhdOT3VKDOVofDhAVv
   4Lt5MkRXL23h7668HxtCJhV+Tvzq1Gs9nuzSEUpwX8ZA22xdz0HmjP+sO
   XS7BNEZHG4B6D1lLGIfIuCltarWyPaMpcb/SfesIsUiG+XxY8wg2mAEkR
   idYkb81LaVL19ejcb7aFF/xqQtLhVdK6wE3CAB5dicHSg37BUNIuHSDfe
   nwH2o49xsicPplALFlCso+FbhFdA30kQ/G/w9yYOwwXhdRoGNW50OofaY
   g==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="201826504"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 09:10:51 +0800
IronPort-SDR: nrVkO9grB6VedSGo37CK1l1f4YJLaIOzIcs7RoUQOwN7YZrFceJwksjiPx3CZ/Z6EfsAza2d2J
 4s+lTUUSCUDyUJagosX2OdOPnle7O+0liDh5hRUW4UucM6puG2ozFvgfsjwJQy+iZKAwem+8ed
 pfPwO3gDXsNsU9/BCTAi+TdKywcN7ySVeOzPaZLjRg1J6DZG6jHPdIB7jgHGnH+tpBCVy5Rtn7
 Eb7hvCy37W8v8RRMWDwwxP+AIdkvINlKgzN/q12oVI4apEocgTWTEJoDnjDECFKEu6S1eP4M+9
 QoXICKp3EIgz4iMu6kCVVGVw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 17:41:36 -0700
IronPort-SDR: /SoT87jdgBdzLQUSNcBFwrRJZKVdBA+X+84MOm+LuDHtfGG2qCVkAGTTitObmUbz+XvApaLL3i
 CKiXFZ3jlgLU+vLTLjo0IRCh2JR6f47IIXPpcIBSlHucyPe7gkmrjq9J7lV2T1ZxxnTO//AK56
 ePRwsNQbf9mLkx0R8cGB87TeK0RZhzRSiFIuiSLPGqRNM0t4JTRvMgTYlxlYYe/CifnSJ4n1rb
 x0s3/JMS6QYAVDTV/yJMtsWcjMQHQRzXeMKTS8MtnLZE+m2FrYlxAuDdrBxXFPhvtjvfGibU35
 cqo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 18:10:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KWt4r0Sjdz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 18:10:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649034651; x=1651626652; bh=mEnXkc2aXmWFQmJNXsTtqNXWzplpMwoyDFJ
        jQew2C84=; b=TO98bMVxe5IFMu7hsYPvsDau4JQ9KxmdfBuCo2m9jawBKVpiAEu
        ZcPkrwMsXYy7S/Kb6/+CFLUw7HvJYkpAypiH9T42AfDgMjOKF1Jx2rYsuYNkd2tT
        Xre5O/nW5VVD/9qzc8S5c3HQLWXhfR1xWjLZ5APWYHWiNXwG2HlNzjKxdAzpZV5R
        XLrgjKyScxtEZS8uQiaIv825+IsZJG7BxwsHC7TwxjWVkHl9kjdFy8GewkNZP3J3
        YnchC424sIKIk2aX8/Z1zbm39vEHH/uPanQE1LvZkcdUXFCv0OtkeIi4Vh86NknD
        w0+0C+nbOtJ2Ar2NZEWqgfxN7qDLeIjMKgw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xXk7ZWQOzCEl for <linux-ide@vger.kernel.org>;
        Sun,  3 Apr 2022 18:10:51 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KWt4q0kGCz1Rvlx;
        Sun,  3 Apr 2022 18:10:50 -0700 (PDT)
Message-ID: <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
Date:   Mon, 4 Apr 2022 10:10:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
 <20220303034912.3615390-2-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220303034912.3615390-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/3/22 12:49, Mario Limonciello wrote:
> As the default low power policy applies to more chipsets and drives, it's
> important to make sure that drives actually support the policy that a user
> selected in their kernel configuration.
> 
> If the drive doesn't support slumber, don't let the default policies
> dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
> disk.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Mario,

Can you resend a rebased version of this, on top of libata for-5.19 branch ?

> ---
> Changes from v1->v2:
> * Move deeper into codepaths
> * Reset to MED_POWER rather than ignore
>   drivers/ata/libata-sata.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 071158c0c44c..0dc03888c62b 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -13,6 +13,7 @@
>   #include <scsi/scsi_device.h>
>   #include <linux/libata.h>
>   
> +#include "ahci.h"
>   #include "libata.h"
>   #include "libata-transport.h"
>   
> @@ -368,10 +369,20 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   		      bool spm_wakeup)
>   {
>   	struct ata_eh_context *ehc = &link->eh_context;
> +	struct ata_port *ap = link->ap;
> +	struct ahci_host_priv *hpriv;
>   	bool woken_up = false;
>   	u32 scontrol;
>   	int rc;
>   
> +	hpriv = ap->host->private_data;
> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
> +	  !(hpriv->cap & HOST_CAP_SSC)) {
> +		dev_warn(ap->host->dev,
> +			"This drive doesn't support slumber; restting policy to MED_POWER\n");

Typo here: s/restting/resetting. Also, s/doesn't/does not.

> +		policy = ATA_LPM_MED_POWER;

Here, shouldn't we use the default policy defined by 
CONFIG_SATA_LPM_POLICY ?

> +	}
> +
>   	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
>   	if (rc)
>   		return rc;


-- 
Damien Le Moal
Western Digital Research
