Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14BC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 01:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhLIBVG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:21:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5864 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbhLIBVF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 20:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639012653; x=1670548653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OQYoEOAsqrtVNImUDmLDxfi5nUYY74eFh616n36T+Xk=;
  b=PXKdrhpMDlC/ZaK2D9TXC5Sr2ptfMsRQj7HXuxxjo9jTLo/OCAwcw8YJ
   JHFC/cdHo2YTFrwXMYl94hA07CsybPR8ez6l1DCED62RW3fx+qGt6rRuD
   tDGHd5z3DLWmAzh2l9rd6fL4LmDw9tKI+uIjPLWVUDw26IFA4jQzBlC0Q
   /zrSuxI43pWLGBjcPc3SXsPQR4vgVrAZquUJwMeu4gBTqTJ6u6DxeDukb
   8EVMIhyzx2bmjPC/tjxflvd5j9r1LcCVEq4oIGR5evdIMFsWF5qCS4vNM
   uxinjVeSb6NKgAdCAunWBYJU+QEOPGjuCFl3LMDVqnWVQxoONHSaWqlQ8
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="186773716"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 09:17:32 +0800
IronPort-SDR: PHHABL98fu8mGr69nq4JwhsFFEtg4GMOkg5YHjtouOKYBe+YUWU/keSXFrF4+Hi/6IgMZSLb1N
 DM4tBh79VT2KIvNB5io2pVj6zBUYKUrnjc030UTxGP/wyUrwYz0gxVuWJbwUFQhiphRoTIQ8N6
 Vr7N0Tu4/ZbXUAQw6HE6snRFzuDY/73K3eP9kGq0pKzhrhSQepceUtmIdvOQHT6BuRpDzopDL0
 YtnJPIk31Q99ubkQ1R/5ILf8IT0iLIyL8mnHc7uIJpBJFCLybDGCD9ZDlKJiaXaH6PRR1YIpBw
 73zZLfnETkl+C0/JhV9zmkZD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:50:35 -0800
IronPort-SDR: zTLB8VNddKNpvPjSTnaGf6X7vLHOPjOLEY78S8y10FmQ/v2FY11NYn/7pBSFVkYtsiZ8TQp+EJ
 DZFezK6DX+Bg3bTlLtx5Bqehd1dYu4yoBEMuLqaZvYCEKmsB7PL2Kh3QPC7RoESA6BjOI/OD5Q
 HQ3jnO9sYfQ62SvI4iz0U41wX1ccj6pltTkMdzH2sQP+HWYYfGmEaV+0yG2zx2ZRg07Mg83vRU
 MyJIFSW4TWS1xFp0U4ScKjY/Ey2x6zoZPgmumvD2zyc32cyleohu9w2D6yKCrAtqR0fK+mlGag
 17c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 17:17:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8bk4373Pz1Rvlf
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 17:17:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639012651; x=1641604652; bh=OQYoEOAsqrtVNImUDmLDxfi5nUYY74eFh61
        6n36T+Xk=; b=HGI1wT1lBOCVsZYfVLjuTsmB0wbmRGY2qsSjX8wdL9tPxNegpAp
        8FMYTtxdHSXm1HJqcr7oli3MMnWyIppFDvUoa+dbYMZS7O8qUYVrwmR0t53A4fnT
        bQxGksLnjeXOKecVw4XyelQltXfZ8ocagoaJlvDs6gRctg9X72iRyYT+I06h7vAr
        2xglm1qT8gr8lepEroMKUXdRiCORj557n1ePIytmv69+KtCAB/qxJPehn1vo4HL4
        6+b9TQjh1ppLv0JYuBktO2iKBFPQupc5xg0zxQDVqeoued/gcTPW923yLLXv2jGR
        BZLvRcCE+G4Jkek5XMz873PALDkKU5KuhVg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aUPx1LxE4BaU for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 17:17:31 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8bk343rTz1RtVG;
        Wed,  8 Dec 2021 17:17:31 -0800 (PST)
Message-ID: <b570f665-7604-f24e-5714-92b448399469@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 10:17:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 00/73] libata: rework logging, take II
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211208163255.114660-1-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:31, Hannes Reinecke wrote:
> Hi all,
> 
> after some prodding from individual persons I've resurrected my
> patchset to put libata logging on a even keel, and use structured
> logging for everything.
> So this patch does away with DPRINTK, ATA_DEBUG or ata_msg_XXX() calls,
> and moves everything over to structured logging (ie the dev_XXX()
> calls).
> Additionally I've added more tracepoints to trace command flow
> and EH, HSM, and other related things.
> 
> So everything is looking far saner now.
> 
> As usual, comments and reviews are welcome.

Hannes,

Thanks for cleaning this up. I commented only on patches where I saw problems.
No comments == LGTM.

> 
> I know that the device names suck. Blame Tejun.
> 
> Hannes Reinecke (73):
>   libata: remove pointless debugging messages
>   libata: Add ata_port_classify() helper
>   libata: move ata_dump_id() to dynamic debugging
>   libata: sanitize ATA_HORKAGE_DUMP_ID
>   sata_mv: replace DPRINTK with 'pci_dump' module parameter
>   sata_mv: kill 'port' argument in mv_dump_all_regs()
>   libata: add reset tracepoints
>   libata: drop DPRINTK() calls in reset
>   libata: tracepoints for bus-master DMA
>   libata: drop debugging statements for bus-master DMA
>   pata_octeon_cf: add bmdma tracepoints and drop DPRINTK() calls
>   pata_arasan_cf: use generic tracepoints
>   sata_dwc_460ex: use generic tracepoints
>   sata_nv: use generic tracepoints
>   libata-sff: tracepoints for HSM state machine
>   libata-sff: add tracepoints for ata_sff_flush_pio_task()
>   libata-scsi: drop DPRINTK calls for cdb translation
>   libata: add tracepoints for ATA error handling
>   libata: drop DPRINTK() calls during ATA error handling
>   libata-eh: remove DPRINTK() calls for request sense
>   libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
>   libata: add qc_prep tracepoint
>   libata: move DPRINTK to ata debugging
>   pata_octeon_cf: remove DPRINTK() macro in interrupt context
>   pdc_adma: Remove DPRINTK call
>   sata_fsl: move DPRINTK to ata debugging
>   sata_rcar: replace DPRINTK() with ata_port_dbg()
>   sata_qstor: replace DPRINTK() with ata_port_dbg()
>   pata_pdc2027x: Replace PDPRINTK() with standard ata logging
>   libata: remove pointless VPRINTK() calls
>   ahci: Drop pointless VPRINTK() calls and convert the remaining ones
>   pdc_adma: Drop pointless VPRINTK() calls and convert the remaining
>     ones
>   pata_octeon_cf: Drop pointless VPRINTK() calls and convert the
>     remaining ones
>   pata_via: Drop pointless VPRINTK() calls
>   sata_promise: Drop pointless VPRINTK() calls and convert the remaining
>     ones
>   sata_qstor: Drop pointless VPRINTK() calls
>   sata_rcar: Drop pointless VPRINTK() calls
>   sata_inic162x: Drop pointless VPRINTK() calls
>   sata_mv: Drop pointless VPRINTK() call and convert the remaining one
>   sata_nv: drop pointless VPRINTK() calls and convert remaining ones
>   sata_fsl: convert VPRINTK() calls to ata_port_dbg()
>   sata_sil: Drop pointless VPRINTK() calls
>   sata_sx4: Drop pointless VPRINTK() calls and convert the remaining
>     ones
>   sata_sx4: add module parameter 'dimm_test'
>   libata: drop ata_msg_error() and ata_msg_intr()
>   libata: drop ata_msg_ctl()
>   libata: drop ata_msg_malloc()
>   libata: drop ata_msg_warn()
>   libata: drop ata_msg_probe()
>   libata: drop ata_msg_info()
>   libata: drop ata_msg_drv()
>   libata: remove 'new' ata message handling
>   libata: remove debug compilation switches
>   pata_atp867x: convert blank printk() calls
>   pata_cmd640: convert blank printk() calls
>   pata_cmd64x: convert blank printk() calls
>   pata_cs5520: convert blank printk() calls
>   pata_cs5536: convert blank printk() calls
>   pata_cypressx: convert blank printk() calls
>   pata_it821x: convert blank printk() calls
>   pata_marvell: convert blank printk() calls
>   pata_rz1000: convert blank printk() calls
>   pata_serverworks: convert blank printk() calls
>   pata_sil680: convert blank printk() calls
>   pdc_adma: remove disabled debugging messages
>   sata_sx4: convert blank printk() calls
>   sata_mv: convert remaining printk() to structured logging
>   pata_hpt37x: convert pr_XXX() calls
>   pata_octeon_cf: Replace pr_XXX() calls with structured logging
>   pata_hpt3x2n: convert pr_XXX() calls
>   pata_hpt3x2n: convert pr_err() calls
>   pata_hpt366: convert pr_warn() calls
>   libata-scsi: rework ata_dump_status to avoid using pr_cont()
> 
>  drivers/ata/acard-ahci.c        |   4 -
>  drivers/ata/ahci.c              |  13 +-
>  drivers/ata/ahci_qoriq.c        |   4 -
>  drivers/ata/ahci_xgene.c        |   4 -
>  drivers/ata/ata_piix.c          |   3 -
>  drivers/ata/libahci.c           |  33 +--
>  drivers/ata/libata-acpi.c       |  71 +++---
>  drivers/ata/libata-core.c       | 270 ++++++++--------------
>  drivers/ata/libata-eh.c         |  50 +++--
>  drivers/ata/libata-pmp.c        |   8 -
>  drivers/ata/libata-sata.c       |   5 -
>  drivers/ata/libata-scsi.c       | 111 ++-------
>  drivers/ata/libata-sff.c        |  86 +++----
>  drivers/ata/libata-trace.c      |  29 +++
>  drivers/ata/libata.h            |   1 -
>  drivers/ata/pata_arasan_cf.c    |   3 +
>  drivers/ata/pata_atp867x.c      |  29 +--
>  drivers/ata/pata_cmd640.c       |   2 +-
>  drivers/ata/pata_cmd64x.c       |   4 +-
>  drivers/ata/pata_cs5520.c       |   4 +-
>  drivers/ata/pata_cs5536.c       |   4 +-
>  drivers/ata/pata_cypress.c      |   2 +-
>  drivers/ata/pata_hpt366.c       |   4 +-
>  drivers/ata/pata_hpt37x.c       |  19 +-
>  drivers/ata/pata_hpt3x2n.c      |  11 +-
>  drivers/ata/pata_it821x.c       |  43 ++--
>  drivers/ata/pata_ixp4xx_cf.c    |   6 +-
>  drivers/ata/pata_marvell.c      |   9 +-
>  drivers/ata/pata_octeon_cf.c    |  48 +---
>  drivers/ata/pata_pdc2027x.c     |  71 +++---
>  drivers/ata/pata_pdc202xx_old.c |   2 -
>  drivers/ata/pata_rz1000.c       |   4 +-
>  drivers/ata/pata_serverworks.c  |   4 +-
>  drivers/ata/pata_sil680.c       |   9 +-
>  drivers/ata/pata_via.c          |  12 -
>  drivers/ata/pdc_adma.c          |  33 +--
>  drivers/ata/sata_dwc_460ex.c    |  71 +-----
>  drivers/ata/sata_fsl.c          | 165 ++++++--------
>  drivers/ata/sata_gemini.c       |   4 +-
>  drivers/ata/sata_inic162x.c     |   4 +-
>  drivers/ata/sata_mv.c           | 147 ++++++------
>  drivers/ata/sata_nv.c           |  53 ++---
>  drivers/ata/sata_promise.c      |  31 +--
>  drivers/ata/sata_qstor.c        |  15 +-
>  drivers/ata/sata_rcar.c         |  25 +--
>  drivers/ata/sata_sil.c          |   1 -
>  drivers/ata/sata_sil24.c        |   5 +-
>  drivers/ata/sata_sx4.c          | 148 +++++-------
>  include/linux/libata.h          |  99 ++------
>  include/trace/events/libata.h   | 387 +++++++++++++++++++++++++++++++-
>  50 files changed, 992 insertions(+), 1178 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
