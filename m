Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD6C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  1 Jun 2022 06:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiFAGkX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiFAGkV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2022 02:40:21 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C2941B4
        for <linux-ide@vger.kernel.org>; Tue, 31 May 2022 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654065619; x=1685601619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9wLBC1Rr0CXfT2DGDqXF9i/snXuwmwlPkyy6lwIjJFg=;
  b=Tr3vGYhdfzNJq5pk6inxJKr3H8exVrV+gCkfJBdCGnv21mSlOl7n1GaC
   mSizooYAz8vMYIb20K4EDy5b61Qanu17sCmANHWDdOSqD1ZoKp3e9/olt
   GjiRExC6nV+CQgmqycBoA4HBXF40Bl6t2icn/u/4th4DO78SJoUUv12v/
   Jf0Tmc+5Ngmw5ypP7ro9QtGC4pIu4Tc/uUBXho9/1opWgXbgSx6MUkus6
   hGZSklqPNZASEJcKVIMNZ2vAxT7v3oRV8cxpIXk+X/H/XaBKPGVSJ9XtF
   ZhCUJDcNF0uZ9AJIYt5IfAWGXFEDsf7f2Kd82HV3KgQmsruhCCkLVKv4t
   g==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="206823314"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 14:40:19 +0800
IronPort-SDR: APVcxv10+cozbaQLKf0wttZIH0yaGMgfPWeulFLbV/rLlY9XeJbL2w2+JZLeqf0/L04bIFbVJc
 arlsHP7/5l8/4cNik2MFeSZw1Q1J5UExVSH0IVmgEpEBtacpGWSUiToipFjuk+QXu+LBBFthl5
 wLE0zJ5bbDgxBx373vMZttAlBiWEJfDFCU5aAgv3drGRr3AaoBsgfv3SKCalTdi045pXsAdciR
 l6qIKeN5qQhlFePfvcUOsQw5gxIn/38stHwWDTDpkpZWbVuUtc/aqDWhwcqNYH7zNDnC9B6oCD
 bF/+zbYbaLLb2tDVtvB63arA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2022 22:59:33 -0700
IronPort-SDR: pfxbHA7f3tLMZtQgzYJS33eYz2uYAAnCVynRDHZa9BXxe/T/QO0O5Nxq2gy/PX6/KFLNiYV3o2
 vdzPYZT6fhOPR+V1KJx2g4veCC0DmDPuMlhwAu42UAY/l7TbVHmzwPnIUigBIRF64iwD1gfXI0
 nEh4fkYBjEtXhf/VTbqV7enlpzUWzEVGIev1OYhdY+EX/p6MkS8zlBSM4XUGOwpNsfnOLXtd1w
 XWKCXNJ7Rt86sUS6Y8Mwog8XtDAOFQJ69pCW0VhTIVpQgayuzlO1CpjoIVUadJOZve0A8mC65Y
 iIA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2022 23:40:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LCffC48Pgz1SVnx
        for <linux-ide@vger.kernel.org>; Tue, 31 May 2022 23:40:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654065619; x=1656657620; bh=9wLBC1Rr0CXfT2DGDqXF9i/snXuwmwlPkyy
        6lwIjJFg=; b=La/86JzzPkNF9jaRLlUczKv6sY64XwWRqJRxx5YLDU73EZeOpil
        5/6Yl6FLk9QZcASgCKwjN/rzHoOS2nl/sWxl6zt0bzzt8UOZ6Z8baEqzzlIPpIe5
        9B6Oe8WAMHud83tFYOQHA6330Hk6RpKcXv9fYdYhrTFhbDyxo94b4c74brF33HB3
        5HQ+ccGR54giGHXFHgHhTC1OjGzzrHIJb6eKOHF0bsCcWCiFf14TA5E0GEzlvqX2
        nE3HS7SYVZs/bD2fGfCPkkNHVvVON7Hyc5LH/74JVv/ecK/E49uyXX5Va/sQ2izL
        wI5wzJSKeFpHO8HfwH/hwhHZL70ZMp2NfRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Xvt3eV7_ezR for <linux-ide@vger.kernel.org>;
        Tue, 31 May 2022 23:40:19 -0700 (PDT)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LCffB1qb0z1Rvlc;
        Tue, 31 May 2022 23:40:18 -0700 (PDT)
Message-ID: <f66e1c54-a334-328f-10dc-e4aa760e23c6@opensource.wdc.com>
Date:   Wed, 1 Jun 2022 15:40:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] libata: drop 'sas_last_tag'
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, John Garry <john.garry@huawei.com>
References: <20220525114942.92934-1-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220525114942.92934-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/25/22 20:49, Hannes Reinecke wrote:
> Unused now.
> 
> Fixes: 4f1a22ee7b57 ("libata: Improve ATA queued command allocation")
> 
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  include/linux/libata.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 732de9014626..0f2a59c9c735 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -822,7 +822,6 @@ struct ata_port {
>  	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
>  	u64			qc_active;
>  	int			nr_active_links; /* #links with active qcs */
> -	unsigned int		sas_last_tag;	/* track next tag hw expects */
>  
>  	struct ata_link		link;		/* host default link */
>  	struct ata_link		*slave_link;	/* see ata_slave_link_init() */

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
