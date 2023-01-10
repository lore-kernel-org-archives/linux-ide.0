Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC00C54EBC
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjAJNXT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjAJNXR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:23:17 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38169CFC
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356996; x=1704892996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QTBZrQdLHDsAsAqEoVMFsJCKFUD0i+1isXzUx2uayrY=;
  b=bljlMihdy7lgrlrMUZ+4a4B83sgEj4R37sMPwmdvrxQxqVAaekJC94UI
   Zt1PyDJesVtXtbE54AXWhcQUh/rDyYaI/Qq3WhQmxciDk7L6H3NPoIl1N
   lCCY6akcYCxbJhQNM1hZeN+8wfYGq7AnrlnOa1bdQ5qcBAuEBhIxTiTg3
   3wPeEWzWmzGfmjvo+0ghmWmtsecoXB5o9xXkxY8fCYvzseAv1c1M+Mvs6
   rfNNKYdcJggSEXkGoIzFij3HZusKqHDjqPONSFYR5O5Odx3QjmxWVDBtg
   xkKmlMUXun0p0sdd/X1N3mrDPS3ZXzGCwLax9JPwdFXFsSFHHH24fL4td
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220556151"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:23:14 +0800
IronPort-SDR: fTaOcn5SWV/OoPp8IXsG0jSexaDpk2Jr5Tb08oy66iSx9eeUDXUn+k1f4adDp/aQUtleE+nYpg
 Qs5KNGU3cAAlnmUdBeQlcGEBMgd7ySC+nmohl0gdDgGP9QBPIvvegdZ6lML5pn7oa+FjwILcHC
 fwOGYUvZyk2wVwvkw3KwXmnH+WznLkovIAJL+rTQxNKbkYwwm6VLEsDtmj+EKotaf1JoIKMonF
 1lqNUlrTaXP2aNpIl6q2sibg3pIs+HzSgD4cdMtUTd3fUQ+U9ud19Gk5720K8lP/tFu0JgrZRn
 Ta8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:41:04 -0800
IronPort-SDR: bRruLk6o5wisgJ/1SS/GHfvI1fH3tPIcK1TKcQeqwUql9tXAY9wmLpWx7uGS34VjZ4XtQnH8fA
 X9hfKsaqM0RJkOapl2EHBYdYdtFsO4zEefssD/EhCnHSTgphkd3QKABYHhgrFwEcB9ateNRzrP
 N8hyHIOexncfpK+Dy3JZrJMWF/aqd43JFVxffRO0QgQ9Ajmtu+2RHVkRHa7+9vR4gCIIoGPuo2
 m+xwtYLjJz6PK5tEjIlG/x+SmKQcOiitYlZ+4nRuo61m4M7LRpQBHYXV6V6N642Ir1XkNzzeyg
 8ok=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:23:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs2B4y58z1Rwt8
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:23:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673356994; x=1675948995; bh=QTBZrQdLHDsAsAqEoVMFsJCKFUD0i+1isXz
        Ux2uayrY=; b=Yz+xO2Mqtrx0XY1yk8sQYcfRq9jOTUKiSg/HN7jFNe0q23pjrTr
        P+fenOPLHjxDfQS4/28cCio9+KYAdwm5j85ax/nDOFgUw2qadQjxYHsNjxbEhkmj
        +B+LkFiFxdgXrfjb+f7ZWczynqPqXE6HdzoLgo8k1Qd6Q+PeJ5STj4A9HeQMk2JJ
        Bt9WpKa4UgkkEU7xIHTiLSeKEZQjl6pzRBT2VOQ+2TVDzpYH5QXngI6kAvajODIA
        kuvCX94fQ6wGfqVedf7FhYrsG8FWDPPXaCulir9cdzUWtrd4rqe8Xrte+koJQjlu
        HnvSR0uruYWX9mVPOcCHpJSTyOm5sIQ1uQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id giatnSSIEsam for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:23:14 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs286pFSz1RvLy;
        Tue, 10 Jan 2023 05:23:12 -0800 (PST)
Message-ID: <6172d4fc-9747-7003-84bb-899dbff33865@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 22:23:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 0/7] Improve libata support for FUA
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <Y7WuEqMgySOCCTqy@slm.duckdns.org>
 <79260c74-92dd-2cdf-ad71-e70d9fa0f8a9@opensource.wdc.com>
 <Y7cT3SSssHzBYqU4@slm.duckdns.org>
 <b5c57ca5-49b0-b9c6-4a65-a8867a74e950@opensource.wdc.com>
 <Y7hiemMjV5y/ToIF@slm.duckdns.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y7hiemMjV5y/ToIF@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/7/23 03:03, Tejun Heo wrote:
>> We can take a big hammer here and start with enabling only ACS-5 and
>> above for now. That will represent the set of devices that are in
>> development right now, and only a few already released (I have some in
>> my test boxes and they are not even a few months old...).
> 
> All that said, yeah, if we restrict it to only the newest devices, they're
> more likely to be well behaved and a lot more visible when they misbehave.
> That sounds reasonable to me.

I re-posted the series without patch 7 enabling FUA by default. This
maintains the current state of libata while still cleaning up nicely all
the code around FUA.

I will send 1 or 2 patches later after thinking a little more about how to
safely enable FUA by default only for recent drives or drives of interest.
E.g. SMR drives as the lack of FUA support for them forces the use of the
block layer flush machinery, which itself causes write reordering... That
needs to be addressed too, and will look at that.

Thanks for the feedback.

-- 
Damien Le Moal
Western Digital Research

