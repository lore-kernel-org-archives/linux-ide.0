Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA443C05027
	for <linux-ide@archiver.kernel.org>; Tue, 14 Feb 2023 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBNXvG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBNXu6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Feb 2023 18:50:58 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469691A1
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2023 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676418656; x=1707954656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9CpydODQoc4YcAYpk8Ls8YOL4wFNAyRJ+PdfBH3v+nY=;
  b=I16t+hHTJ7cgU32MtiVGipSVVCuNkg+x+QsPC8gmzcnJZ8BbhOlpgKv0
   KQ6ghOnFLEcqUG22LLJom+i6k8zYF1KApMm+Q5KD4CmhQCkV0vNsFO5D6
   3UqLhUHI1CDE2O9Ho4xpQ21H01hPBBTLzeg1MhQC8mcCH1CAiCzCU5Gga
   xiSt7Uy7j2Wm6MQgdfB6wrWn2+UqPzWi4Unbrdr63n72OTK/wcUcdCf7f
   p4qNLUL7DcuX1qjxKGttqDKjGyFQEp4c/Vz1AMB2BMsoQWHT6q617Hjvd
   yc4tA7IbptSE2TQZSRQm/vCw7UAy2qFVSSLjd0RvFKfMBWgp8T8v3fDCh
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223110875"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 07:50:55 +0800
IronPort-SDR: QrPBTAzHgrzclw319MskTinm/Z708cVhqSoVAPGpcbwbGzchU79A96+IbW2a/nDL9lciDMRaEy
 7QSRqNnP6ea+WUN2tyrnJR8r0tWa5WXGC5+o+zsIs5cbBTgOO8zEEqzjNXZIg71+Kn0Z7vt7H4
 kpmp7SYiQQL5/V+ncwNLRG+hqr+VU/yGnJpGJQbvOu+cxLeldNkRmEFAOo9awUjuJrY2WOih2e
 TYo8btKKYjKsy/yePRKZks/9r8D/HIHIll1tvB85R+TiqETO0U7Nq4fG9ssnyEe7QZ5P+OUrRa
 5fs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:02:17 -0800
IronPort-SDR: 8clc58G3CIsNSXpSO1c++u2QhCFU7vtXZXG6x2sY6/LgSlVS5q9TCgtGTAXxzHn8nW5vwlF2js
 nPjnrQqNzvkyPGBLgTXJb+Ht0A/O0oQg5QLcVKgAf6GXH1eXrMcjkBgkma9VAtQUG9Q0mAC9P/
 GfQaCcDwDhMc8ciqzsU9iJRZmad8mjw8ivl8Q9RlhtgssPNispF90lsk/g2HTNadtbpr3gLd2o
 os3Ux1XzCZ8z0Db9cfAh1uMxpaO7Y1Ptd6qNGyip4M4AwalctrrV3ItAgZaz+kwMxtmmAC83+K
 dPk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 15:50:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGdJG5KxGz1RwqL
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2023 15:50:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676418654; x=1679010655; bh=9CpydODQoc4YcAYpk8Ls8YOL4wFNAyRJ+Pd
        fBH3v+nY=; b=Zlj8iJJOtuahv9EypvaSpUKW68uRqV7r/0iHBSbsV6kg76ixDHg
        vlNeMODxWwGWdBwm4oZQNecv4ZPX4KghNXHWJCxJ0mMaTFnJKvkrT5Wb9gbQRpr0
        Qahoea9HrZtKCNWZX+riwZGyqI6c25XHJoJCNesEe6UotuG2ea146Gg0KkmPa6lL
        ItEvwsQHU5Jg/kn8bOYduQ+AXFPxGQ9l6zlRSRFi6UL/uoEIB0zBZXYGvjobsqtL
        l8orQy3wR7s7Bji4i+7RC6sez9tjF7GjLiW39fur7+GJFgzwKZ8RaUp1G0rHx1Gx
        ZavwVQ2MozQcxm2QAXWeYJVevCVqSACm+Og==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OXrfPxiKBdJU for <linux-ide@vger.kernel.org>;
        Tue, 14 Feb 2023 15:50:54 -0800 (PST)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGdJD3YV2z1RvLy;
        Tue, 14 Feb 2023 15:50:52 -0800 (PST)
Message-ID: <6ce57b8c-7f0c-f3d1-6938-c87fa4ab650d@opensource.wdc.com>
Date:   Wed, 15 Feb 2023 08:50:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/18] pata_parport: protocol drivers fixes and cleanups
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214230010.20318-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230214230010.20318-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/15/23 07:59, Ondrej Zary wrote:
> This patch series fixes two bugs and cleans up pata_parport protocol drivers,
> making the code simpler with no changes in behavior (except logged messages).
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Sergey did send you some reviewed-by tags for some of the patches. But I
do not see any in this v2. Did you forget to add the tags to the reviewed
patches ? That is nice to do so that I do not have to keep track of
reviews across series versions...

> ---
> Changes in v2:
>  - added two bugfixes (first two patches)
>  - addressed Sergey's comments (mostly split patches)
> 
>  drivers/ata/pata_parport/aten.c                            |  45 ++++----------
>  drivers/ata/pata_parport/bpck.c                            |  86 ++++++++------------------
>  drivers/ata/pata_parport/bpck6.c                           | 107 ++++++++-------------------------
>  drivers/ata/pata_parport/comm.c                            |  52 +++++-----------
>  drivers/ata/pata_parport/dstr.c                            |  45 ++++----------
>  drivers/ata/pata_parport/epat.c                            |  48 ++++++---------
>  drivers/ata/pata_parport/epia.c                            |  55 +++++------------
>  drivers/ata/pata_parport/fit2.c                            |  37 ++++--------
>  drivers/ata/pata_parport/fit3.c                            |  39 ++++--------
>  drivers/ata/pata_parport/friq.c                            |  56 ++++++-----------
>  drivers/ata/pata_parport/frpw.c                            |  71 ++++++----------------
>  drivers/ata/pata_parport/kbic.c                            |  66 +++++++++-----------
>  drivers/ata/pata_parport/ktti.c                            |  38 ++++--------
>  drivers/ata/pata_parport/on20.c                            |  45 ++++----------
>  drivers/ata/pata_parport/on26.c                            |  52 ++++------------
>  drivers/ata/pata_parport/pata_parport.c                    |  31 +++++-----
>  {include/linux => drivers/ata/pata_parport}/pata_parport.h |  41 ++++---------
>  17 files changed, 271 insertions(+), 643 deletions(-)
> 
> 

-- 
Damien Le Moal
Western Digital Research

