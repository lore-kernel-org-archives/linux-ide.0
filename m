Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A3C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  4 Apr 2022 01:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiDDBCH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Apr 2022 21:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiDDBCH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Apr 2022 21:02:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDB2A732
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649034010; x=1680570010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RLiABV9bYmVV0n4z0hDjho6qXABomGPUy/L9FgK9Zf4=;
  b=Z7ZiR3Bk2uX1gXUrpAijQJXDYHRSoE27he/DPi6alqo5rTpAALFHQN5L
   O+oYLvLLPV8qryEcN7f031E5vmNcieRdvVasepdwfXEDmfTwrqhDWIoDm
   USBnhpIjXtJMmkVSybwbkqg2zzT9mM8fkCyLf8rhakB/PsQHr60E1xJPn
   dBp4/8K82+iWFjvnFCmthwuwP6woqUF/74Qo+lRMYOiy3t6VuQn7HwXAw
   dYgUTaK6Ce9E6VkoZm84AvdloL89OzY7x6XILR1S+KexLU94IB/MZ9rb0
   FZa1IR+Rql0PDKMAjTWZhw1QbFkIhyQBT3tPWT+HVs4CFeG0yiJoqZ/bx
   w==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="308940815"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 09:00:09 +0800
IronPort-SDR: S/GSNhyQK81cZvPE5j7nMT/37IUJg8TyBKMLGmo0uYD1foSulvz9uCOmVyrvbt6TsoauNT+tAm
 Cp9SqFNQBaT9NEyDsJ0oL6VaXvbYnEK2j8MqyGDfME6hblTu3qBbtcWmzyo3wcy58QuIuJwBO4
 6h0tNpwkZ2Yp/2Y6X3RKqF141fTxCXPc4QQMiTv2Jreo72uPYb7BfdVw5bOWxuVT0QdUZxkRiW
 jFZXOYYFIp1O4+/39s+JS5Ry60in3hkmTG3VFWl4F/X9t2cHT2qOemXGysgtiAe2CXOCyErEko
 dToFiLxILGgkHoIdt+jDwLsm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 17:30:54 -0700
IronPort-SDR: uydIaTPX7dyTW2U+sL3n2aDgA/4RopQhX1eKjUbjCp+2yb8K65mv5/0SobChoI1uiAbmD05NbE
 /Brve0JA96rpYBwgIz84+GSXazeGShq5EA39HGhJsR6MEX6lYmL3XZGea3uvQUbsx/UNhK9cuW
 N4oGSbUBrVn5NzvIcjmkOjj+3ETNI/L6Ja758zbla2bkMxCWZ9cVsRTXKLoa0dMHzkxee5IXkt
 +LMhqkS8yFJSmjg5PcmqTPH1oTIBvdhxZB+Gi+X28LH9SwZKmfXlH8n3NihdKyVGscy+yk/30V
 Jb0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 18:00:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KWsrT23Clz1SHwl
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 18:00:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649034008; x=1651626009; bh=RLiABV9bYmVV0n4z0hDjho6qXABomGPUy/L
        9FgK9Zf4=; b=tWk4i3bE6O4qc8CpEeoDKqEt2JbLE4/N8ddo/i09bKkAxbcCZGo
        uFeIQR4ACkwnE8DDCOzKkSF9BCZnBfG5HU9Mho9oQkqdRnB/c4AKzcWHHPB18nIY
        dSGtM5aywwPg2jWf5vnZuvd7VouGceYt/EGal/p5S3iwdP3ZSLh2ZIiEaH6WjBsV
        IjloyYfJq9UXzbIbgmjwGCfS+UiPmuQ/Sk3yHVOfFkZ4ygs017+15HKwG0389Onz
        N1wKF7xCuGnOfpttW7Vih1+7psPoXszN2CKiZCYYPZy1L8R3Fo424C6FCylgHYS+
        r6j6ygxO8nabp8kOFI9QBKaeevj/xfihqTw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4jgfoGf3fWrS for <linux-ide@vger.kernel.org>;
        Sun,  3 Apr 2022 18:00:08 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KWsrS0dLnz1Rvlx;
        Sun,  3 Apr 2022 18:00:07 -0700 (PDT)
Message-ID: <701738f9-c895-4970-0851-41c898f13461@opensource.wdc.com>
Date:   Mon, 4 Apr 2022 10:00:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, linux-ide@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/20/22 05:11, Christian Lamparter wrote:
> the driver uses libata's "tag" values from in various arrays.
> Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
> the value of the SATA_DWC_QCMD_MAX needs to account for that.
> 
> Otherwise ATA_TAG_INTERNAL usage cause similar crashes like
> this as reported by Tice Rex on the OpenWrt Forum and
> reproduced (with symbols) here:
> 
> | BUG: Kernel NULL pointer dereference at 0x00000000
> | Faulting instruction address: 0xc03ed4b8
> | Oops: Kernel access of bad area, sig: 11 [#1]
> | BE PAGE_SIZE=4K PowerPC 44x Platform
> | CPU: 0 PID: 362 Comm: scsi_eh_1 Not tainted 5.4.163 #0
> | NIP:  c03ed4b8 LR: c03d27e8 CTR: c03ed36c
> | REGS: cfa59950 TRAP: 0300   Not tainted  (5.4.163)
> | MSR:  00021000 <CE,ME>  CR: 42000222  XER: 00000000
> | DEAR: 00000000 ESR: 00000000
> | GPR00: c03d27e8 cfa59a08 cfa55fe0 00000000 0fa46bc0 [...]
> | [..]
> | NIP [c03ed4b8] sata_dwc_qc_issue+0x14c/0x254
> | LR [c03d27e8] ata_qc_issue+0x1c8/0x2dc
> | Call Trace:
> | [cfa59a08] [c003f4e0] __cancel_work_timer+0x124/0x194 (unreliable)
> | [cfa59a78] [c03d27e8] ata_qc_issue+0x1c8/0x2dc
> | [cfa59a98] [c03d2b3c] ata_exec_internal_sg+0x240/0x524
> | [cfa59b08] [c03d2e98] ata_exec_internal+0x78/0xe0
> | [cfa59b58] [c03d30fc] ata_read_log_page.part.38+0x1dc/0x204
> | [cfa59bc8] [c03d324c] ata_identify_page_supported+0x68/0x130
> | [...]
> 
> This is because sata_dwc_dma_xfer_complete() NULLs the
> dma_pending's next neighbour "chan" (a *dma_chan struct) in
> this '32' case right here (line ~735):
>> hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
> 
> Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
> the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
> causes the crash.
> 
> With this patch, SATA_DWC_QCMD_MAX is now set to ATA_MAX_QUEUE + 1.
> This avoids the OOB. But please note, there was a worthwhile discussion
> on what ATA_TAG_INTERNAL and ATA_MAX_QUEUE is. And why there should not
> be a "fake" 33 command-long queue size.
> 
> Ideally, the dw driver should account for the ATA_TAG_INTERNAL.
> In Damien Le Moal's words: "... having looked at the driver, it
> is a bigger change than just faking a 33rd "tag" that is in fact
> not a command tag at all."
> 
> Fixes: 28361c403683c ("libata: add extra internal command")
> Cc: stable@kernel.org # 4.18+
> BugLink: https://github.com/openwrt/openwrt/issues/9505
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Applied to for-5.18-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research
