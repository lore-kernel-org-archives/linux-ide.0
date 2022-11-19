Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CEC4332F
	for <linux-ide@archiver.kernel.org>; Sat, 19 Nov 2022 01:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKSBff (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKSBfR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2022 20:35:17 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484C16C886
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2022 16:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668818376; x=1700354376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pzpgRv9tngr9UQHhkFDZuwKc7HE+y+YtgTMgNd6mE5A=;
  b=qbPAoFEHP7KfpLBptgG1pxQWwbUs8Le/pwiElQoUWg28zOMw55yM8hHd
   RaK+uAylYQ3Ds9dE/tTjaEXVN7GrRnyieaeP3uod87bc9xrSOLeK5VXdW
   /YcUEXUa7uEVIfYgItZWLx76dCXmUBDudEH4ISXW+yfWI8mYOo38AMX8x
   eldZeGsKEIc/4myITK68bus1EbXQ4KXoDXCmFDE0b4qlnJfUsDtV0MB2L
   QYhpO69ujlHB4WoHCmn1xZHBM8jfUZUJS+DzJxC7tmLZKFL/c/Cod8WbG
   JY3i13R/W7ThQ8t4m7evoSpfAN8Pdl06BXS3nDoxciR+kxAx/sVwmkDy9
   g==;
X-IronPort-AV: E=Sophos;i="5.96,175,1665417600"; 
   d="scan'208";a="216652352"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2022 08:39:35 +0800
IronPort-SDR: SUup2zhdFxf8v203l3h64tsHcO4xNRb9C/fvHgAkAP2w0nocFWBT6jzVph1UC0eh9jga21jtdk
 3v+7neCa/j0MvZpk1nbasoM/thM83y6fFRhPo/bc5K/j4YoxIJZanUGsBzZx+AcUG2l6P+rc0M
 CKmCCkVoQ3IxguLAWpq33K0u0Mk9pRM2jPx29zOjONFTChxPj0FUvJnEssAaF6B1vIBU4f9RuR
 yFlhRkIEgx0hYQdD6129cVjvXaqBuz6h5cbaHZgiAfKu9egaAYd6eXK62JKfOlJE3rWqbMnjAO
 ZcA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 15:52:43 -0800
IronPort-SDR: RERieZnhPyb2YqQgimU8ibP8ADgEiH3ahJG8bjEMQ2yvEok8Y8rxegynj7eiLSjivlcHE/1iJC
 WmwClbjlqeBTS+g2m+avExzqw9gv2BjXbhCoq9KBNWzQspNTKFO+1k+6Nt0bslxQrBqznfwyr9
 Cx/xuUNAim3BMkDmxJs8ft7Wi3JujNG01Ln9guYS2S2KUSTLBqTOkq1RC3wYG3MopKzGNa5nGW
 LcK4QFiIsTpW6sAHzVN9MhqvFGdZp7YI17EcKHCmh1diwk+GK02TrYaKRt2RQca2CbzRKTQUc0
 o5w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 16:39:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NDZY2568qz1RvTr
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2022 16:39:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668818374; x=1671410375; bh=pzpgRv9tngr9UQHhkFDZuwKc7HE+y+YtgTM
        gNd6mE5A=; b=jvsvYJvCmJnwgGumoDfdFhdvYLtc0Zw9LIx9Fq9XM9zSMTzr7vF
        c78v4P+rqrAzoTV1cNC+SM/GPnoX2cRZJo1lQtn4/2qLcVwrWxAypOx29YtzhWgO
        fn1vb52ehnHKqCXuQusVCyE9dUdlQq0PslPJp03BLICIplDAqVfBAqUQTQUN/4t8
        qOgxKOhzNtG5Rtird7TV7LpK3JnMwfmFU09RKc/C7u757WWIC2Sq50y1WQCM4GyR
        XSifVWHKKDDDIljbUjSlSW/uA4jHqueyWGpiv1dewAIBrfXSpE2bmb4SOB0T4fjE
        0qw2Vc+kzu165Lpzf6/Pa47tzGavUXAZPjA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cgZWY4mDk74e for <linux-ide@vger.kernel.org>;
        Fri, 18 Nov 2022 16:39:34 -0800 (PST)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NDZY16MZ3z1RvLy;
        Fri, 18 Nov 2022 16:39:33 -0800 (PST)
Message-ID: <860f4009-95cf-a9b0-41c0-d7c5b0d65484@opensource.wdc.com>
Date:   Sat, 19 Nov 2022 09:39:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] ata: libata: fix commands incorrectly not getting
 retried during NCQ error
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221114172200.1475962-1-niklas.cassel@wdc.com>
 <3f2f4518-1cfa-8872-3f5c-049a2c92aa99@opensource.wdc.com>
 <Y3dTZviXX8x/YJb9@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y3dTZviXX8x/YJb9@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/18/22 18:41, Niklas Cassel wrote:
> On Fri, Nov 18, 2022 at 01:40:17PM +0900, Damien Le Moal wrote:
>> On 11/15/22 02:21, Niklas Cassel wrote:
>>> A NCQ error means that the device has aborted processing of all active
>>> commands.
>>> To get the single NCQ command that caused the NCQ error, host software has
>>> to read the NCQ error log, which also takes the device out of error state.
>>>
>>> When the device encounters a NCQ error, we receive an error interrupt from
>>> the HBA, and call ata_do_link_abort() to mark all outstanding commands on
>>> the link as ATA_QCFLAG_FAILED (which means that these commands are owned
>>> by libata EH), and then call ata_qc_complete() on them.
>>>
>>> ata_qc_complete() will call fill_result_tf() for all commands marked as
>>> ATA_QCFLAG_FAILED.
>>>
>>> The taskfile is simply the latest status/error as seen from the device's
>>> perspective. The taskfile will have ATA_ERR set in the status field and
>>> ATA_ABORTED set in the error field.
>>>
>>> When we fill the current taskfile values for all outstanding commands,
>>> that means that qc->result_tf will have ATA_ERR set for all commands
>>> owned by libata EH.
>>>
>>> When ata_eh_link_autopsy() later analyzes all commands owned by libata EH,
>>> it will call ata_eh_analyze_tf(), which will check if qc->result_tf has
>>> ATA_ERR set, if it does, it will set qc->err_mask (which marks the command
>>> as an error).
>>>
>>> When ata_eh_finish() later calls __ata_qc_complete() on all commands owned
>>> by libata EH, it will call qc->complete_fn() (ata_scsi_qc_complete()),
>>> ata_scsi_qc_complete() will call ata_gen_ata_sense() to generate sense
>>> data if qc->err_mask is set.
>>>
>>> This means that we will generate sense data for commands that should not
>>> have any sense data set. Having sense data set for the non-failed commands
>>> will cause SCSI to finish these commands instead of retrying them.
>>>
>>> While this incorrect behavior has existed for a long time, this first
>>> became a problem once we started reading the correct taskfile register in
>>> commit 4ba09d202657 ("ata: libahci: read correct status and error field
>>> for NCQ commands").
>>>
>>> Before this commit, NCQ commands would read the taskfile values received
>>> from the last non-NCQ command completion, which most likely did not have
>>> ATA_ERR set, since the last non-NCQ command was most likely not an error.
>>>
>>> Fix this by changing ata_eh_analyze_ncq_error() to mark all non-failed
>>> commands as ATA_QCFLAG_RETRY, and change the loop in ata_eh_link_autopsy()
>>> to skip commands marked as ATA_QCFLAG_RETRY.
>>>
>>> While at it, make sure that we clear ATA_ERR and any error bits for all
>>> commands except the actual command that caused the NCQ error, so that no
>>> other libata code will be able to misinterpret these commands as errors.
>>>
>>> Fixes: 4ba09d202657 ("ata: libahci: read correct status and error field for NCQ commands")
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Applied to for-6.1-fixes. Thanks !
> 
> So, the Fixes-tag points to a commit that is only in your for-next branch.

Arg. I got confused with last week fix...

> 
> If you this patch to 6.1-fixes, then the Fixes-tag points to a commit that
> does not (yet) exist in the tree.
> 
> If you prefer to this patch to 6.1-fixes, then we should probably change
> the Fixes-tag to point to:
> e8ee84518c15 ("[PATCH] libata-ncq: update EH to handle NCQ")
> 
> While the problem could happen even on v6.1-rc5, it is highly unlikely,
> as v6.1-rc5 is reading the wrong status register for NCQ commands,
> which means that during an NCQ error, analyze_tf() will read the status
> from the last non-NCQ command, which is most likely does not have ATA_ERR
> set in status.
> 
> I think the only way it is a problem on v6.1-rc5 is if:
> 1) A non-NCQ command fails
> 2a) No D2H FIS (non-NCQ command) is received with ATA_ERR bit cleared,
> before 3) happens
> 2b) The device is not reset, before 3) happens
> 3) A NCQ error occurs
> 
> Perhaps just queue this up for 6.2 instead?

Indeed. It needs to be there. Moving it.
Thanks.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

