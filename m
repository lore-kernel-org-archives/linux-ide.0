Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F476C43334
	for <linux-ide@archiver.kernel.org>; Fri,  3 Jun 2022 01:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiFCBbO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Jun 2022 21:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbiFCBa4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2022 21:30:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6303B002
        for <linux-ide@vger.kernel.org>; Thu,  2 Jun 2022 18:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654219820; x=1685755820;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=02VpAnCfqzi7odbGgq08OOJ0oK0HghFe2lymWFBlMpw=;
  b=KP+r9P6BbFKRqOKy/0niZEAOkHWALSdwqqBUtdGSTgQ7AeEet5SIs5/D
   LzmdHbzAnSC2SHO6bjlU2t5thdIpm7UUnP1N/bcvfrW8B5LYMWeWqXbVl
   YB4XQpqqbHtrbl6iHys8mgvmDR/5d+2XBMfErzuOAX3/Kqi3QsXW0iXUn
   FhIzTDIaV3j3ZENAUFzZZ7bK5In2Ja0zThke8Qf8CD1N4oxuoBZPAeJd+
   MQtjerp8MiADv1RhIN1D+YZtftA4Ey9ZsiYi9bEYzNEVa6n8KfvT/V7f3
   tXpHvBz0B24S5togLiL2P6Ud/vHroZWFAjjKed5sjA8LTzW2+gSqvs7x5
   w==;
X-IronPort-AV: E=Sophos;i="5.91,273,1647273600"; 
   d="scan'208";a="202156609"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 09:30:07 +0800
IronPort-SDR: D5m4GpKV4Xf5PuwvTxJStwpT8ZCNnvfAcbPeVxOXxCZkl/LqKDQ85K7358ryEvmRrJbdzLC5Pv
 DdkGX8Op1YWLlLLAbo5gueTwQIfg0c7nj3wAPtuRxG3tR0tXXFyWo3T2V8N4zd8JIg4um0h5g4
 RA++majRJ1Pz7I8afFj1VGEwGL8GGyHlxS0ctKrbF7a7r2tj13nITbTcil+EFWQ2oVN8kcjzoV
 EfvGF54QthM3LmBPVmiRYgWdUe6+V6u+LbHo6q7rOwkx59vFeiLqdGlHxOJk3DMlqbB6hdV4p2
 Fz1zoHlAQdFmJDEK9YX8Bx4g
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 17:49:16 -0700
IronPort-SDR: bu/GASvEliL/uDiIZUZoN2G5cv1IYDMiAkzCEuJ3JqwMPA/q5yuRyG+NyKdOPoqiVjtLBz11jW
 iB8hqpaKG2zpcYF1pj1FkPleym89wddPRpcJVNrRGSQ2hrmCWaflGhbrKIwBOz4znEkXwAG5Up
 37b+6/+tluIMYzXlUoqO2olVMW9m+tHjaRRG2BLr21mYBoE/PfQIvHBLoMercK4uTOsqTTAYrh
 Y7l/c51OfjEERc9KSRyseEjuDrtHSAOqsaEtinyTn3e8hoR23LB0t+D5edERLGxkwLyMtjS+In
 ypk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2022 18:30:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LDlgN1fJ0z1SVnx
        for <linux-ide@vger.kernel.org>; Thu,  2 Jun 2022 18:30:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654219807; x=1656811808; bh=02VpAnCfqzi7odbGgq08OOJ0oK0HghFe2ly
        mWFBlMpw=; b=e+2rJU8iu/s7Xj+0YysrwP5WNB7UKwb2iuCyGlL5OwsQ2IVU53Q
        mbQiUL3jECaLeC8tmgW+O5YgzFMy1Rko77ps8EJ4zRenNC/9uNlXtMvv26UKnY1+
        AIstCwvSXkoU6zv8Z7EQAD0iMo8yLsRQsj4LhPll47QOG2zXhRhN5pvusovEuB1y
        TaB+knCg1N/OdQy50KkWG/uQdImHRzP/vJvUcaPvttLic4lS9wml4e3FavVj/Fsn
        F7kadGDjk6oIX9yTTBqAY7mAWaFlROPYh+HRWwCcH/sB5TMZGean5hfqDyqtIdOx
        SN7kviwRHHMxNFsQXeLi75U0/XyWIB6sz1w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jwIiCpfPs2ib for <linux-ide@vger.kernel.org>;
        Thu,  2 Jun 2022 18:30:07 -0700 (PDT)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LDlgL23jJz1Rvlc;
        Thu,  2 Jun 2022 18:30:06 -0700 (PDT)
Message-ID: <d3cc3cff-b483-b2dd-b6eb-131500b97d54@opensource.wdc.com>
Date:   Fri, 3 Jun 2022 10:30:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/3] ata,sd: Fix reading concurrent positioning ranges
Content-Language: en-US
To:     Tyler Erickson <tyler.erickson@seagate.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        muhammad.ahmad@seagate.com
References: <20220602225113.10218-1-tyler.erickson@seagate.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220602225113.10218-1-tyler.erickson@seagate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/3/22 07:51, Tyler Erickson wrote:
> This patch series fixes reading the concurrent positioning ranges.
> 
> The first patch fixes reading this in libata, where it was reading
> more data than a drive necessarily supports, resulting in a 
> command abort. 
> 
> The second patch fixes the SCSI translated data to put the VPD page
> length in the correct starting byte.
> 
> The third patch in sd, the fix is adding 4 instead of 3 for the header
> length. Using 3 will always result in an error and was likely used
> incorrectly as T10 specifications list all tables starting at byte 0,
> and byte 3 is the page length, which would mean there are 4 total
> bytes before the remaining data that contains the ranges and other
> information.
> 
> Tyler Erickson (3):
>   libata: fix reading concurrent positioning ranges log
>   libata: fix translation of concurrent positioning ranges
>   scsi: sd: Fix interpretation of VPD B9h length
> 
>  drivers/ata/libata-core.c | 21 +++++++++++++--------
>  drivers/ata/libata-scsi.c |  2 +-
>  drivers/scsi/sd.c         |  2 +-
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 700170bf6b4d773e328fa54ebb70ba444007c702

Looks all good to me. I tested this and really wonder how I did not catch
these mistakes earlier :)

Using a tcmu emulator for various concurrent positioning range configs to
test, I got a lockdep splat when unplugging the drive:

[  760.702859] ======================================================
[  760.702863] WARNING: possible circular locking dependency detected
[  760.702868] 5.18.0+ #1509 Not tainted
[  760.702875] ------------------------------------------------------
[...]
[  760.702966] the existing dependency chain (in reverse order) is:
[  760.702969]
[  760.702969] -> #1 (&q->sysfs_lock){+.+.}-{3:3}:
[  760.702982]        __mutex_lock+0x15b/0x1480
[  760.702998]        blk_ia_range_sysfs_show+0x41/0xc0
[  760.703010]        sysfs_kf_seq_show+0x1f2/0x360
[  760.703022]        seq_read_iter+0x40f/0x1130
[  760.703036]        new_sync_read+0x2d8/0x520
[  760.703049]        vfs_read+0x31a/0x450
[  760.703060]        ksys_read+0xf7/0x1d0
[  760.703070]        do_syscall_64+0x34/0x80
[  760.703081]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  760.703093]
[  760.703093] -> #0 (kn->active#385){++++}-{0:0}:
[  760.703108]        __lock_acquire+0x2ba6/0x6a20
[  760.703125]        lock_acquire+0x19f/0x510
[  760.703136]        __kernfs_remove+0x739/0x940
[  760.703145]        kernfs_remove_by_name_ns+0x90/0xe0
[  760.703154]        remove_files+0x8c/0x1a0
[  760.703165]        sysfs_remove_group+0x77/0x150
[  760.703175]        sysfs_remove_groups+0x4f/0x90
[  760.703186]        __kobject_del+0x7d/0x1b0
[  760.703196]        kobject_del+0x31/0x50
[  760.703203]        disk_unregister_independent_access_ranges+0x153/0x290
[  760.703214]        blk_unregister_queue+0x166/0x210
[  760.703226]        del_gendisk+0x2f8/0x7c0
[  760.703233]        sd_remove+0x5e/0xb0 [sd_mod]
[  760.703252]        device_release_driver_internal+0x3ad/0x750
[  760.703262]        bus_remove_device+0x2a6/0x570
[  760.703269]        device_del+0x48f/0xb50
[  760.703280]        __scsi_remove_device+0x21b/0x2b0 [scsi_mod]
[  760.703339]        scsi_remove_device+0x3a/0x50 [scsi_mod]
[  760.703391]        tcm_loop_port_unlink+0xca/0x160 [tcm_loop]
[  760.703407]        target_fabric_port_unlink+0xd5/0x120 [target_core_mod]
[  760.703494]        configfs_unlink+0x37f/0x7a0
[  760.703502]        vfs_unlink+0x295/0x800
[  760.703514]        do_unlinkat+0x2d9/0x560
[  760.703520]        __x64_sys_unlink+0xa5/0xf0
[  760.703528]        do_syscall_64+0x34/0x80
[  760.703537]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  760.703548]
[  760.703548] other info that might help us debug this:
[  760.703548]
[  760.703551]  Possible unsafe locking scenario:
[  760.703551]
[  760.703554]        CPU0                    CPU1
[  760.703556]        ----                    ----
[  760.703558]   lock(&q->sysfs_lock);
[  760.703565]                                lock(kn->active#385);
[  760.703573]                                lock(&q->sysfs_lock);
[  760.703579]   lock(kn->active#385);
[  760.703587]
[  760.703587]  *** DEADLOCK ***

This needs to be checked too, but that is not related to your fixes.

I will queue the libata patches for rc1 update.

Martin,

Do you want to take patch 3 or should I just take it ?

-- 
Damien Le Moal
Western Digital Research
