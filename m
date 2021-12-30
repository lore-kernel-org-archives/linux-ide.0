Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2110C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Dec 2021 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhL3FTl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 00:19:41 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:19940 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231228AbhL3FTl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 00:19:41 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPc5m500Bz1RvTh
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2021 21:19:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640841580; x=1643433581; bh=DzgOwLObNz/YDTAUztJU6D749GlEm5/XR3X
        wMm6hXvc=; b=sHqiladJgS5n7/lkWo2pbLhjZfd/kiTd75fkLc/oxwzbQ74fY3O
        7mWKyH++c0CrIwbgW8R8ye03qaxWMJ/7vAwyYnJrhLTbGRM0VCIUebm+A2uh69Yz
        9Al9niINueMwNaSOcb65NF6TyP6e/2LAdnLLr3izK7fbXlQ2bEm+jeC31fcs+G/8
        5Ez62u94Iu9/56Ie4qH2e28YKIcnteD/BBqkejL7+1hX156JIkGULMw7SH0XYE1+
        +FidC7OliFeN0XpO6YhvQ9SoYE2/Yhevd93cLPjMivZiAgVCBadoLQx0Bp9Z7IMf
        I1VAKGzohgDYEv0RRUiES0EIWhhhKAqCbgg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p2-1tBsY0ur3 for <linux-ide@vger.kernel.org>;
        Wed, 29 Dec 2021 21:19:40 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPc5l4FXrz1RtVG;
        Wed, 29 Dec 2021 21:19:39 -0800 (PST)
Message-ID: <e22c1fc6-b707-a6f0-74bf-d911adec4a5b@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 14:19:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv3 00/68] libata: rework logging, take II
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/21/21 16:20, Hannes Reinecke wrote:
> Hi all,
> 
> after some prodding from individual persons I've resurrected my
> patchset to put libata logging on a even keel, and use structured
> logging for everything.
> So this patch does away with DPRINTK, ATA_DEBUG or ata_msg_XXX()
> calls, and moves everything over to structured logging
> (ie the dev_XXX() calls).
> Additionally I've added tracepoints to trace command flow,
> error handling, host state machine etc.
> 
> So everything is looking far saner now.
> 
> As usual, comments and reviews are welcome.
> 
> I know that the device names suck. Blame Tejun.

I applied this series, temporarily, to the branch for-5.17-logging, with
the fixes I commented about.

After some light testing, seems OK, but need to hammer this a little more.

My main concern is the change in patch 12: using the dev_xxx() macros
directly changes the messages from being all prefixed with "ataX.X" to
different flavors (devX.X, linkX.X, portX.X, etc). While I do like the
code simplification, this makes reading dmesg to track how a device is
behaving very hard.

Defining dev_fmt() everywhere the ata_{port,link,dev}_XXX functions are
used would solve this, but that is annoying as almost all drivers would
need to define that. Looking at the dev_XXX() macros, I do not see an
easy solution. Any idea ?

Note: If you resend a new version, please base it off for-5.17-logging.

Cheers !

> 
> Changes to the original submission:
> - Converted all printk() and pr_XXX() calls, too
> - Included reviews from Damien
> - Included reviews from Sergey
> 
> Changes to v2:
> - Rebase to ata/for-5.17
> - Include reviews from Sergey
> 
> Hannes Reinecke (68):
>   libata: remove pointless debugging messages
>   libata: whitespace cleanup
>   libata: Add ata_port_classify() helper
>   libata: move ata_dump_id() to dynamic debugging
>   libata: sanitize ATA_HORKAGE_DUMP_ID
>   libata: add reset tracepoints
>   libata: add qc_prep tracepoint
>   libata: tracepoints for bus-master DMA
>   libata-sff: tracepoints for HSM state machine
>   libata-scsi: drop DPRINTK calls for cdb translation
>   libata: add tracepoints for ATA error handling
>   libata: move ata_{port,link,dev}_dbg to standard dev_XXX() macros
>   libata: revamp ata_get_cmd_descript()
>   libata: move DPRINTK to ata debugging
>   sata_mv: kill 'port' argument in mv_dump_all_regs()
>   sata_mv: replace DPRINTK with dynamic debugging
>   pata_octeon_cf: remove DPRINTK() macro in interrupt context
>   pdc_adma: Remove DPRINTK call
>   sata_fsl: move DPRINTK to ata debugging
>   sata_rcar: replace DPRINTK() with ata_port_dbg()
>   sata_qstor: replace DPRINTK() with ata_port_dbg()
>   pata_pdc2027x: Replace PDPRINTK() with standard ata logging
>   libata: remove pointless VPRINTK() calls
>   ahci: Drop pointless VPRINTK() calls and convert the remaining ones
>   pdc_adma: Drop pointless VPRINTK() calls and remove disabled NCQ
>     debugging
>   pata_octeon_cf: Drop pointless VPRINTK() calls and convert the
>     remaining one
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
>   pata_atp867x: convert printk() calls
>   pata_cmd640: convert printk() calls
>   pata_cmd64x: convert printk() calls
>   pata_cs5520: convert printk() calls
>   pata_cs5536: convert printk() calls
>   pata_cypress: convert printk() calls
>   pata_it821x: convert printk() calls
>   pata_marvell: convert printk() calls
>   pata_rz1000: convert printk() calls
>   pata_serverworks: convert printk() calls
>   pata_sil680: convert printk() calls
>   sata_sx4: convert printk() calls
>   sata_mv: convert remaining printk() to structured logging
>   pata_hpt37x: convert pr_XXX() calls
>   pata_octeon_cf: Replace pr_XXX() calls with structured logging
>   pata_hpt3x2n: convert pr_XXX() calls
>   sata_gemini: convert pr_err() calls
>   pata_hpt366: convert pr_warn() calls
>   libata-scsi: rework ata_dump_status to avoid using pr_cont()
>   sata_dwc_460ex: drop DEBUG_NCQ
>   sata_dwc_460ex: remove 'check_status' argument
>   sata_dwc_460ex: Remove debug compile options
> 
>  drivers/ata/Kconfig             |  12 -
>  drivers/ata/acard-ahci.c        |   4 -
>  drivers/ata/ahci.c              |  13 +-
>  drivers/ata/ahci_qoriq.c        |   4 -
>  drivers/ata/ahci_xgene.c        |   4 -
>  drivers/ata/ata_piix.c          |  11 +-
>  drivers/ata/libahci.c           |  33 +--
>  drivers/ata/libata-acpi.c       |  69 +++---
>  drivers/ata/libata-core.c       | 225 ++++-------------
>  drivers/ata/libata-eh.c         |  72 +++---
>  drivers/ata/libata-pmp.c        |   8 -
>  drivers/ata/libata-sata.c       |   5 -
>  drivers/ata/libata-scsi.c       | 111 ++-------
>  drivers/ata/libata-sff.c        |  88 +++----
>  drivers/ata/libata-trace.c      |  47 ++++
>  drivers/ata/libata-transport.c  |  45 +++-
>  drivers/ata/libata.h            |   5 +-
>  drivers/ata/pata_arasan_cf.c    |   3 +
>  drivers/ata/pata_atp867x.c      |  29 +--
>  drivers/ata/pata_cmd640.c       |   2 +-
>  drivers/ata/pata_cmd64x.c       |   4 +-
>  drivers/ata/pata_cs5520.c       |   4 +-
>  drivers/ata/pata_cs5536.c       |   4 +-
>  drivers/ata/pata_cypress.c      |   2 +-
>  drivers/ata/pata_ep93xx.c       |   1 -
>  drivers/ata/pata_hpt366.c       |   5 +-
>  drivers/ata/pata_hpt37x.c       |  20 +-
>  drivers/ata/pata_hpt3x2n.c      |  12 +-
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
>  drivers/ata/sata_dwc_460ex.c    | 120 ++-------
>  drivers/ata/sata_fsl.c          | 165 +++++--------
>  drivers/ata/sata_gemini.c       |   4 +-
>  drivers/ata/sata_inic162x.c     |   4 +-
>  drivers/ata/sata_mv.c           | 130 +++++-----
>  drivers/ata/sata_nv.c           |  54 ++---
>  drivers/ata/sata_promise.c      |  31 +--
>  drivers/ata/sata_qstor.c        |  15 +-
>  drivers/ata/sata_rcar.c         |  26 +-
>  drivers/ata/sata_sil.c          |   1 -
>  drivers/ata/sata_sil24.c        |   5 +-
>  drivers/ata/sata_sx4.c          | 148 ++++--------
>  include/linux/libata.h          |  99 ++------
>  include/trace/events/libata.h   | 416 +++++++++++++++++++++++++++++++-
>  53 files changed, 1050 insertions(+), 1251 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
