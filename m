Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE3C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 21 Jan 2022 09:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379650AbiAUJ1n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Jan 2022 04:27:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2956 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiAUJ1l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2022 04:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642757259; x=1674293259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wvAGSSkbD8sKVKozj06LSLUZ8DGhuMSqNCuuyy1l4Tg=;
  b=XuJwheHPGDcgFAbYId+vG8SouBaxARjEgMyN0dD0RVzfhIT4dH2QYJB1
   uFyXQMN7sCo+HpkcPn6wnABbAc/0blXrF91BhyWIlsCUyUIgt7lYKmRXW
   fRhkrFnh65Sqs0nEloL0El3r+oi/pSSCAxUc5aCpXqTDbfZSW9mQ/50Yg
   DtpwHe6QJmQFMMR9vq2TjnxvH9ezM3ek8vnK5iA445wW5pF+QYuE8AeH9
   W6JG6yYFRRwxN71+H3RLyD+L86PRtnMxOmJNMFzjiqpEpOMoHVSXtkjQD
   WvqbcHYcOHbLi+w6TWROKEchmp7vYAPEG3fcZ9s/Q9ZO4KTMGjJ6Ufh+k
   A==;
X-IronPort-AV: E=Sophos;i="5.88,304,1635177600"; 
   d="scan'208";a="195827691"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2022 17:27:38 +0800
IronPort-SDR: zEIFyKsbUMiOsdePDicX1gOgPdnF0zB8xrBEu3ZcOhy+9g7Sd+N0IjWJ53fn0sEmS3KfGiLWAZ
 OUfj8492crqORpzk78UdUheZ9az5ymjM9vqLju9nD5KtpVnZTkogJLCbdk4hDew6Vka9H+dn1y
 bbZJ4l2o0qrKjFekGZBG2VsY6PkYg3aqZSavpUa7PYujubrpFVcMAiS5GpAP942rv4+RUPSWIO
 Z6dDY0lzAsQdJ6baklSY5wJ8MfvbpZW/BPp9+fXUWUP1rNyZ5DmX2Nsl/khyV93b32ru47G9ag
 mC6sk8a5MTUEgWe8oy/C/6Cg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:59:50 -0800
IronPort-SDR: Xk/pxxZERS6cr0JY0keCawK4CpdTx7/DJVkYrK5ggLj0mlcI6Ko7+A6emDTsYNUnTXPTtry2El
 3AokOkxSIwtFWDl5dUA4dNE9FvD1tUmW5s6DYNgq6yLIszBIzgjnWq216pBlnnxB878gGX8Buq
 1O53kj2p0NFQr6E67jyEKnbiTb8jAfXd7S4kkADC2KgVcuhS5URm6fEy0hg+Yfv5FNUMuZ5t+1
 OQaop7N+6irQ7Mx6dGROfXZ0Ryp6T/7d2QF+uAZcr8HEIiWiG1dWH+JMXCiV+z4EolI50N0pUE
 XOk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:27:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JgDYk1Vk3z1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2022 01:27:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642757257; x=1645349258; bh=wvAGSSkbD8sKVKozj06LSLUZ8DGhuMSqNCu
        uyy1l4Tg=; b=eH3Z965uTxH9B+Ybb9izm7AvFS75V8fAtbih7EcrBmg7M/fwcUl
        zPO5DnBIzdU5y2lrgu4Toooa2iwJ80SvIeOybdNsW2ZCtiztoVPnkBiW+WGnXsCF
        rt1FhRMpYD88Dj5WRfDmAFbslsE3tgUxc+Fr6VJqVCN/9qbFUeTGceLrudBjI1aU
        sdvxSCmFi568o65dcF8bo1LwSeDImocsGkIEbnuHw/Bhtj6dZWRDbB2WM2DNWD+s
        SKh0qfGhm1+18rMesxGU5cTyK4ESN8u4o6fAtuD88a3tw8r8IrnAfIzUWnSImuKi
        xsfnz+gHr8NdGnoX1OkyQGMOLelsLgwoJCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jjmjzQYrCTMi for <linux-ide@vger.kernel.org>;
        Fri, 21 Jan 2022 01:27:37 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JgDYg5LFjz1RvlN;
        Fri, 21 Jan 2022 01:27:35 -0800 (PST)
Message-ID: <11ec9f44-5e1c-c4cd-8d63-93d7538a12c8@opensource.wdc.com>
Date:   Fri, 21 Jan 2022 18:27:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [next] mips: cavium_octeon_defconfig: pata_octeon_cf.c:598:23:
 error: passing argument 1 of 'trace_ata_bmdma_stop' from incompatible pointer
 type
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
References: <CA+G9fYtq0wzSeG8YG-a+=KrbdWqHJMXk1hvq0FKeAvj9sZAK2g@mail.gmail.com>
 <6249735f-e6b7-1331-eb2b-361bb17d6115@opensource.wdc.com>
 <CA+G9fYu__OOvk-ESXoOqbd-Lk+CmO8CSQ8chEFf3MyeTjKtp9g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+G9fYu__OOvk-ESXoOqbd-Lk+CmO8CSQ8chEFf3MyeTjKtp9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/21/22 17:58, Naresh Kamboju wrote:
>> I just posted a fix. As I do not have the environment to compile test
>> mips, could someone test please ? I will send the fix to Linus asap
>> after confirmation that it is OK.
> 
> Please share your patch / patch link. I will test it with tuxmake.
> 
> you may also give a try with these easy steps.
> 
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> # Original tuxmake command with fragments listed below.
> 
>  tuxmake --runtime podman --target-arch mips --toolchain gcc-10
> --kconfig cavium_octeon_defconfig

Just tried this and it all passes for me.

> 
> - Naresh


-- 
Damien Le Moal
Western Digital Research
