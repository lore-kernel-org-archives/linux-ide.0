Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E04C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 07:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiFHHdS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiFHGzJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 02:55:09 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE20A1A43C3
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654670667; x=1686206667;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=AtDDailhAlzqMBCfh/PdNUGr6Yp+6Gj0emriqNmWLQI=;
  b=P6d0gD0i6ncbChQvn0p8+3gIWNqkIKB0Djvf+b43aiJpk6Vs6re47GQy
   Q6f2zDevWJcgH+qhMLwz7tkbsU3URjzJFKQ2zQvMcmTU7XdguFLfQ4lO1
   +51ZfJxT4DcBs6x6i1CrEqtVqT+V6yx3ACH0VqM95egdZoW/rYuG9ieay
   UsvZsft36VPqnLcHhoArKTjWznApDHrTce2SgwWomiLkHdp37NDMKvPg4
   fmJ7bp1hFRj7JVwBglKddOPcZVC854sbJnkP0VNChLrTFU1GVEOIANhoi
   aVmcllFkJou5YuDpBZOlCcHt8cp7WTnyrB6ty56xyoLlAMCt+qsZqCJLp
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="201296904"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 14:44:26 +0800
IronPort-SDR: smPQG4wUWratASrdmPMwe8r/GNzsge1itjH1D1TBeGQNbDhCRSMQIkVNGapn75NUL3v/KlPfGU
 2vArH3DYW2RvUA5dckOci4wII327rkaZ48mJSNH2qj4XnGm67qTIk2J16f6EjCtc6esT8wSiTL
 s7YtuwgUTwe2craDvWUGZEMBBOnzY6pOdK/Do4neYwC+fY+mgiSf9PkdJdrhrw/mZT149Q/2pb
 UaEZBjI/lFZ0wMEP9Avb4flDdGVeb4EEQeos2jvtYrXog6rZLCOrX62TQaSEAl4ia5hNHWu1cG
 CJaa1S0Y74MyPSQPQEhI5Nyg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:07:40 -0700
IronPort-SDR: 2d9cPJcCBSssW1YojeQJP+kMfC/UvQWgOh5Lhr5TCc/gBU0lP8fMTsvarHqkLtEMwTT8vqoi5J
 PocVwwnez8JwlTEcrSmZcM4ftJcvmlUfCqiLs+umD9wcwBMyxFF1AdaLy24UF6yGpfj37WCE5t
 PrpfDt7TasTIZ+aor8p/AWodIZVQDGn458vl1x+dxszAOSRk4FwVYxE3aZ9eUy6HofAbUIi8bu
 7M9F7sTfwN+iF651+DAmP/1Adcp0UNJN0TvMa4H2XSU8K8A5U8FOzkmq6dLccUqnyzRvcmSDsh
 7JU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:44:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHyPj71jpz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:44:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654670665; x=1657262666; bh=AtDDailhAlzqMBCfh/PdNUGr6Yp+6Gj0emr
        iqNmWLQI=; b=ehhLT8Kar9oqBDMpmqglR4VS8oW7QEjXOvJ7f1ArpavZPNS1kKs
        B75VxHleDw3qyLEzuDY5YsmTVuU8ZlXXaHLpR8bBl6hAZcr2BWSJ84UU0U+474he
        XYvCzxiQUHP6KeGvW2aF/1Ctx/2WF4FnwFQqtVis2bR/FgqIx2jVtttKpom6H5PX
        5FxAHDoxCneLT/HQEPy9blorX0YxKUBMUNjb+p6aWUqzAykdVpHJHVEoNhiSVqx3
        qgzYhy73GyEyzM2k2EwEt1taoZMMPbK5fKmVlTW1cMHHrHHx7/fLEI4IUP5DPdCA
        6Gx2CKuNm6ubfMyNo6mJ3gYiu/LGIhyKATA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zLLLdi9gB0RH for <linux-ide@vger.kernel.org>;
        Tue,  7 Jun 2022 23:44:25 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHyPh538jz1Rvlc;
        Tue,  7 Jun 2022 23:44:24 -0700 (PDT)
Message-ID: <f4b5fd32-0182-53d4-ca6b-a1f11abbcba8@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 15:44:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] Make PATA transfer mode masks always being 32-bit
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220508204139.4961-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220508204139.4961-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/9/22 05:41, Sergey Shtylyov wrote:
> The PATA transfer mode masks (direct and packed) in libata are sometimes
> declared as *unsigned int* and sometimes as *unsigned long* (which is a
> 64-bit type on 64-bit architectures), while the packed mask really only
> uses 20 bits and the PIO/MWDMA/UDMA masks use up to 8 bits. Switching to
> the uniform 32-bit masks saves siginificant amount of the object code...
> 
> Sergey Shtylyov (3):
>   ata: make packed transfer mode masks *unsigned int*
>   ata: make ata_device::{pio|mwdma|udma}_mask *unsigned int*
>   ata: make ata_port_info::{pio|mwdma|udma}_mask *unsigned int*
> 
>  drivers/ata/libata-acpi.c      |  8 +++---
>  drivers/ata/libata-core.c      | 38 +++++++++++++-------------
>  drivers/ata/pata_acpi.c        |  2 +-
>  drivers/ata/pata_ali.c         |  2 +-
>  drivers/ata/pata_amd.c         | 14 +++++-----
>  drivers/ata/pata_hpt366.c      |  2 +-
>  drivers/ata/pata_hpt37x.c      |  6 ++---
>  drivers/ata/pata_hpt3x2n.c     |  2 +-
>  drivers/ata/pata_pdc2027x.c    |  4 +--
>  drivers/ata/pata_serverworks.c |  4 +--
>  drivers/ata/pata_sis.c         |  2 +-
>  drivers/ata/pata_via.c         |  2 +-
>  include/linux/libata.h         | 49 +++++++++++++++++-----------------
>  13 files changed, 67 insertions(+), 68 deletions(-)
> 

Are you going to resend this as a single patch ?

-- 
Damien Le Moal
Western Digital Research
