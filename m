Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6211CC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 26 May 2022 23:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbiEZXg5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 May 2022 19:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiEZXgz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2022 19:36:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6D9CC8E
        for <linux-ide@vger.kernel.org>; Thu, 26 May 2022 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653608214; x=1685144214;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5aOO3l4X37RIZER9G375fTN6qpkd0blJ+jmHgGF3ATY=;
  b=LYXjiVjhHg2Bfcm2NfMCm4hAO/fKmLgxuynVL0e6F4ZgEcS2Kl96SqyL
   GJbngfL8GBZH9dTC04xmsRBGuXCD8iXdmSUwhyQNF9Ab6f861L+pt3Xay
   42EJLbcE7wpAVv0S8bPwQJhZKek9YXKZpa0yGmmfC6gV8yV2GLfeWQSrl
   jvAi8m9GQ8tIMJxFaXBRf1Xjjesu95RYMn9gZcbzzlzJQa1DbRm3aXYNF
   /+MV7MT7IDCNsXdeMuGk/U2HCkPL9p3outrXK3TDyL4fqkWWoDYm223VL
   u52+8qefbywv6aHmNiQU77Bd5Zj9r5weHGX/EADoN3QTDa3IVCUrpjUSd
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="200332295"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2022 07:36:53 +0800
IronPort-SDR: Opx80FcB0YFvoPYllgysvVSg6kqxitlJ5esgDAZD02gJq8TusrsSOsORRFYu8GxalKSvgmZbot
 RL9M9RkY04xwLP4zFdJU0sZ199z4jGj06qwh3pyXuGVB1PuHJyBBbXbgRcZPyhRI78Z3VEzpWI
 inJh5OEAJIvnCd2yOreK4gUMZpD3t6gQpfOzCubOz4KHyKGWPk+cKXIBA4knvIqj4C8TTI1//N
 RJ8V9e6BZ0aqnR4QOZvLfeO7efgk/I3S8HM0lmD60nNkPaOiz5XzuXFESFn7puC0ODZ5mZ5cag
 etlaxFjLuZPhJp3YojTu9hMG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 16:00:47 -0700
IronPort-SDR: Pww7sjhuPYU0FAn6y1qAkhHr9XyaWxHcpRSfqTvEMt6Djd3FnqSPGPBt7aoPWEWYhoGdPAxROh
 5JjdbhxP9JK58qRGRedhKenOzMaJXHs0Hb7tI8cV+8ImxAr29NgtkSBG0Egp7h0NA1GHs9eyvo
 6y7zJcz7r9lQeqA0JVsk03OodEak13SbCJaxg5gOEXP1EToOZP++y28W+no6m3195g7XIBGQmP
 dU5KJQAVV7DuXGlkSjPi9lvKQvw79jigkNJ12vOFwEiDa9lIPuqNbVoao3fwMG5BgNuPMzg8jH
 xEY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2022 16:36:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L8PTx4d1Hz1Rvlx
        for <linux-ide@vger.kernel.org>; Thu, 26 May 2022 16:36:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653608212; x=1656200213; bh=5aOO3l4X37RIZER9G375fTN6qpkd0blJ+jm
        HgGF3ATY=; b=BacP7Jatv+BJw1zFiPK3NjFqdVDGp2i8cR2yZiB7bcyppWlnwgU
        A2blnr4WrXz9NTanLuPCTql0gyTrT64S636CVSzfM4VGx9wBon79FSTVAO4IytCq
        01ZSPR3sL0KcG5c0rGX0yCAuV33+nxGb7+yNdfqX23j4twmtBpz0cwu//TMy9Tmo
        aVknV/GyYphA7o8BNTt0TKebQ0l6RdcqYabF+HBVCWnCmxluUIuxchEBO9WWsTXb
        VRTWWnvmrmBbgonnnIz6HsoeNQMWq8Y6lOx9Wv+2Mi83Bff7tQR51QwOSdIpjF6H
        QnkBXZQ2wdcAggBxEMFduYRS2O/2ETjw9QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HG-sLOQoVmE5 for <linux-ide@vger.kernel.org>;
        Thu, 26 May 2022 16:36:52 -0700 (PDT)
Received: from [10.89.80.98] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.98])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L8PTw0v9qz1Rvlc;
        Thu, 26 May 2022 16:36:51 -0700 (PDT)
Message-ID: <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
Date:   Fri, 27 May 2022 08:36:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: Multiple errors with DVD drive
Content-Language: en-US
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>,
        linux-ide@vger.kernel.org
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/05/26 21:38, J.J. Berkhout wrote:
> Firstly, if this is not the right place for this message, I apologize.
> In this case, disregard.
> 
> I have a problem which I suspect is a bug in libata, but of course I
> could be wrong.
> 
> The problem is:
> After going from Linux Mint 19.3 Cinnamon kernel 5.4.0-97 to Linux Mint
> 20.3 Cinnamon kernel 5.4.0-107 I discovered that I could not (reliably)
> access my optical drive anymore.
> It produces errors like:
> 	ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xe frozen
> 	ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
> 	ata1.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 in
>          Read(10) 28 00 00 00 05 61 00 00 40 00res
> 50/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
> 	blk_update_request: I/O error, dev sr0, sector 5508 op 0x0:(READ) flags
> 0x80700 phys_seg 19 prio class 0
> 	ata1.00: failed to set xfermode (err_mask=0x1)
> 
> The system was Linux Mint 20.3 Cinnamon with kernel 5.4.0-107-generic,
> mobo ASRock model X570 Taichi.
> After some tests I found out:
> Kernel 5.4.0-99 works OK;
> Kernel 5.4.0-100 has the problem;
> Kernel 5.13.0-30 works OK;
> Kernel 5.13.0-35 has the problem.

It looks like your distro is backporting patches so the patch causing the
problem could be found by bisecting. While 5.4 kernel is an LTS kernel, the
latest release is 5.4.196... 5.4.0-100 is the distro version number which does
not tell me what set of patches it got on top of 5.4.0. These are not
stable/vanilla kernels.

To get help from this list, you will need to try with a vanilla kernel, ideally
from git. You could try the latest mainline 5.18 first to see if the problem is
there or not.

Also, what AHCI adapter is this machine using (lspci) ?

> 
> The problem is described more fully in
> 	https://forums.linuxmint.com/viewtopic.php?f=47&t=371251
> 
> I reported the bug to the Launchpad Ubuntu site under number #1968155:
> 	https://bugs.launchpad.net/bugs/1968155
> 
> One other person (as far as I know) has the same problem.
> 
> I froze my kernel at 5.13.0-30, so for the moment I can use my system.
> I realize that there are probably not many users with an ASRock X570
> mobo, and in that group only a few would be using a BD reader/burner.
> However, it would be nice if I could again keep my kernel current.
> 
> With kind regards,
> 
> Jaap Berkhout


-- 
Damien Le Moal
Western Digital Research
