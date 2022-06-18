Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E16C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jun 2022 06:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiFRGps (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 18 Jun 2022 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiFRGpr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jun 2022 02:45:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E54D9EA
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655534746; x=1687070746;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=zdbHkkHYDoTGs20H0kaKa5SUGxeUgixaAroFpiwtLVI=;
  b=b80zhRpAo2ReqaVCjwQ4rlzn8HISIpqJ4Ueh57cPMrWT3hU0w3cJ+iA5
   J+eHX0S9k+hSCrFO79tUe+pavYOM381SxdYieob/mI6B5uKL0e6ff1Kzp
   zl1oqDiMPG3WPhd4m3QS3mWJk7yLtu9rbKlHPl8gzOxGdnvnoPyB+pWxo
   B/3P6Y1J5CYcop5lEIihzYUGjLZmLjX7mLOYplNHG9yQvv0VrCTQ3UkZw
   V2Dddgdjdd5oR4aDPYrAx1VXlZUSos9htWX9+HrNdqx9U4vOLAyc0G2QZ
   iMD8FITP83BYHsyFt5oL5TTG15mNgkyWuyEtYFHyrzCOkYWwydQbidqA2
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202203331"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2022 14:45:45 +0800
IronPort-SDR: Jzo9dHX27u40/ruL6IW+LwGb79RekVpz0rF+2TmhiWW5CIOHXANSrIREFLxU+PriCVwYfaRQdW
 R0EPhU6nA6AEfCvBkchHkcTO085GjYaMGrMa6achMzKC3f9h6rCLERMy64Du/r3dirZAZ9SOjX
 QaUUJ9HUNF0AVbpvpJUFnP8O8rz9q21ycx7Dko2pVg+fgLo1B24LxDOf9HjUOYJmXI5S0YiJaf
 Du8H8Pta6mZNsdmvJXePOk/ZpVvjNfVDXkOFQ6h1hZKIRv6rpol1lgrYu1NLMlIA+7PCv0WyND
 nK6Wpv68NRbdBOsGZTqTkKnS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 23:08:19 -0700
IronPort-SDR: EF03Uwfcbzr4Bbd+FE6QHDq3TowoV3wBdB9NjUPRTzVeCPw0oDXWjb/CVnrDbyHppU5cKqfVNt
 4jyBBF34H8V9HqHmUp7QObtGUmgkkkGTtfBVfaLOQMJC4YoFgyVHRjJ2ftS6FvRkiqPkyZsGD2
 O5Sj8tzwOjBTp14MZ7j7H/HaB9txWo/JUJ3cBpQn/qJpMldUtgKPhwYRhGH1sk6Y6Sr3UXYBSS
 /wBImvjzpHM5AjBbgCCl28pEjWEU9KoDhPZnwT/UAdZG+EmuJ7L0tjBc+t3w2yPoCiq740e9rq
 n34=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 23:45:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LQ5yd294yz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 17 Jun 2022 23:45:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655534744; x=1658126745; bh=zdbHkkHYDoTGs20H0kaKa5SUGxeUgixaAro
        FpiwtLVI=; b=FW6dkjyOfs9eUNPqhqMCyGBHjKOlx0GHY2M9u9MCf/f0KxgS9CO
        UcdI7roD/Q46Vg5pc2E8CurrUyY9B+lDZt16uHG+KdPkAG/NZjEetwp3I/i8gwDE
        RuM9AT2c7ulacCUL9nfN66C6zVqfLdLyBlBW+ayDMiGX4U76xudWyBhbTu4H7XUC
        fKnb0YSVeoZxb61HPTwieBtCNuW2cf179ekJ3o3hLFGL2j9MkRczeJ8A759cXx5m
        XQOwegUsrVIlXsjNElzRJhxcdlYLcRP3ltHxAeBcB42m41Zs8hhtmKOyD+i/WM8O
        xBkEoCZTQQpdUWil+QLe2UH+FAEspaFAZmg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7AleEwgsVfm2 for <linux-ide@vger.kernel.org>;
        Fri, 17 Jun 2022 23:45:44 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LQ5yc3Qg1z1Rvlc;
        Fri, 17 Jun 2022 23:45:44 -0700 (PDT)
Message-ID: <a2d8df09-2ecf-baa5-d8ee-4651f5a612f1@opensource.wdc.com>
Date:   Sat, 18 Jun 2022 15:45:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/2] ata: libata-core: fix sloppy parameter type in
 ata_exec_internal[_sg]()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220615193821.9235-1-s.shtylyov@omp.ru>
 <20220615193821.9235-3-s.shtylyov@omp.ru>
 <849f65c3-007e-8f01-2412-e91b3fd6d254@opensource.wdc.com>
 <c2aac3d9-d1d9-eb87-2644-462f30902352@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c2aac3d9-d1d9-eb87-2644-462f30902352@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/18/22 02:27, Sergey Shtylyov wrote:
> Hello!
> 
> On 6/17/22 10:44 AM, Damien Le Moal wrote:
> 
>>> Make the 'timeout' parameter to ata_exec_internal_sg() *unsigned int* as
>>> msecs_to_jiffies() that it calls takes just *unsigned int* for the time in
>>> milliseconds. Then follow the suit with ata_exec_internal(), its only
>>> caller; also fix up ata_dev_set_feature(), the only ata_exec_internal()'s
>>> caller  that explicitly passes *unsigned long* variable for timeout...
>>
>> Checking this, struct ata_eh_cmd_timeout_ent uses an unsigned long timeout
>> and ata_internal_cmd_timeout() returns an unsigned long which is stored
>> into the unsigned int timeout variable.
> 
>    I know. All timeouts stored in those tables fit into *unsigned int* (except
> the last ones which get truncated from ULONG_MAX to UINT_MAX anyways).
>    Note that *unsigned long* has always been silently truncated to *unsigned int*
> when calling msecs_to_jiffies() in ata_exec_internal_sg(); nothing changes with
> my patch, it just gets truncated a bit earlier...
> 
>> So it may be good to add another
>> prep patch before this one to cleanup the auto_timeout stuff (struct
>> ata_eh_cmd_timeout_ent and ata_internal_cmd_timeout()).
> 
>    It shouldn't matter whether we do it before or after this patch, due to
> truncation which happens even now (I have such a patch, but no description
> yet). I was planning to address that as a part of the large patch series,
> most probably next week (and I wrote about that in the cover letter)...
> 
>> Hmm ? Thoughts ?
> 
>    Was I clear enough? :-)
> 
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
> 
>    I wanted to fix SVACE's reports 1st, then the rest of the sloppy timeout
> typing...

Fine. But in the spirit of fixing everything with these types, please add
a patch to also convert the timeout tables to unsigned int. It is never a
good idea to have code silently truncate long to int as that can be a pain
to debug. So let's go all the way and fix this.

If you cannot do the additional patch, I will do it.

> 
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
