Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AF7C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 06:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbiCXGj4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348288AbiCXGji (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 02:39:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C04BB85
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648103883; x=1679639883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=th6fJzewXxkpK7FMsjh5ye9o2KH1jd+ZAf0nWA/6uto=;
  b=UdSk5HuFq45HE7a8g2oqd4kLD92lrgJavYYctmhkd2JeQMH8x2Kg9ARp
   GqnbgHJENrtAVPeBTx+U3qISeesOA7SD9SLHO/UOA4zalV/apb7+I79r7
   5JLWeMj42dHQ6WPSXekPcapoRSjnNU9lgOBQWUjpiuHzpwcq8ioIrD/LE
   NgCoOOgmCNZqgHBWrvJ3aiuTiyHDei+EZbWdv5m8PusSNpGEKjk16rm6j
   QHydihLbSIZy9Jq0/dL8oBVP7fYc7P8/sTiC4VHiI73T/p+1sVTq/GBrq
   dnW0pT1McamD5P0ztw/iFnEpVPiwx48TRUY+ctUglUl6PBdBFyr3JW739
   A==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="196144526"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 14:38:03 +0800
IronPort-SDR: TRHxX+0YqhL40ZfnSPa7AZQnj8jdbTCJOteBfQ+0cAL1WAFir9VLqd0MZdvE9RI7HTxZ3Xhz3N
 xKSqcY+Aw6rpnYfSZ5gtkeC9uP12TqS7qNI4CNAPI2Ub34VmOyjqCjPgtSDqeWqtkAH1rC2BIp
 3339OctAEgllZeqxOfCF1WXXa5qTCn+s/PFAuSi4unjYpZMiXP5IDkTnH+/gwxxQG8OkV5ibWw
 zoVVaGU7726+7IHipwmYBbLpMJWYp9q0LOi9wiFAnl4NxboHUvynnBRIiE68AoMZjCbe+djVVN
 U/CC/RYoFqYe0e5C2OI/qr1R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:09:56 -0700
IronPort-SDR: 26fHXlqLM4zyyWMUgBLr+QVy3xzuQWzcym/SHG5+/qXFDfx/ALnMHFjexLW7QxlrjwVSOzFNu5
 SX3rQ0e2q+XXsceRpUHCFD0QkA3CwvheEOW/R4CrMGcfAm16Zd8tgVZYhJ0aDtzrcxYvSRi8B3
 a6073FfTzysv87uaqFf5mU4v9cbNBcFhalKxLbjHEW9Vd68NHQbEBmlKUwSlanLqR7j/4IAXEI
 ZdsQrzKrDUlfgYMLoEHVG33KF8DGwmfcu4BT6l8rgsxaMjBBD7286Pw7003zq9mdbTeEO3e70M
 Dcc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:38:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPFsR0vqsz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 23:38:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648103882; x=1650695883; bh=th6fJzewXxkpK7FMsjh5ye9o2KH1jd+ZAf0
        nWA/6uto=; b=ek6psxzPc7mGuRaqgy7ciuTJcAeonn8vSXRqaEhWc0HHsiyoGwH
        IiODI8D3a2YHpklukCImqgzmlKH6IqoqIQj7cg7zPucwljgp51EJ/yUfs6NuJarw
        L54mb8m3YbzyTFWszGRHQ8EpfqgcJ2cUZQu4HP5PxYRiGe62MMFfvZwKPGHfS5n8
        A9MOmLC49M6mFZMHMtxicwMuiT6nODENF6SjmxhmNhcV8DtY6/P2bAHKOAG0yPyE
        bMdhOEcaKbaQ04imb0K4giiBqzoNKbBgRkEVAKl0nUhSvpl+y1ZKRmbR4Ts8dYFm
        rUySK1AQwJKFSXTGpiZf6C1F71JDoNYDSxA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G9C06_ZeKKaf for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 23:38:02 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPFsQ0cksz1Rvlx;
        Wed, 23 Mar 2022 23:38:01 -0700 (PDT)
Message-ID: <55df3e41-6252-47e3-1e2f-bf96dce6c304@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 15:38:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
 <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <4459a2ff-0852-d8fb-a2e8-307d651f728c@opensource.wdc.com>
 <YjwPhvPyJHiDbkOL@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjwPhvPyJHiDbkOL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 15:28, Christoph Hellwig wrote:
> On Thu, Mar 24, 2022 at 08:45:56AM +0900, Damien Le Moal wrote:
>> Mario, let's check what other distros do first before deciding. Fedora for
>> sure has a default of 3 and I have never seen any issue with it (and I
>> have been using Fedora for a long time with many different drives).
>>
>> Not sure what distro you are using, but if it is not Fedora, please check.
>> We should check at least Debian, Ubuntu, SUSE, RHEL and CentOS. I can
>> check some other minor ones too as I know users.
> 
> Debian:
> 
> hch@brick:~/work/linux$ grep CONFIG_SATA_MOBILE_LPM_POLICY /boot/config-5.10.0-1*
> /boot/config-5.10.0-10-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
> /boot/config-5.10.0-11-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3
> /boot/config-5.10.0-12-amd64:CONFIG_SATA_MOBILE_LPM_POLICY=3

Thanks. Debian testing also has the default at 3.

Mario reported that Ubuntu and Arch also use 3, and that RHEL has 0 as
default but changes it to 3 after boot.

Gentoo default config is also 3. Checking CentOS and [open]SUSE now.

So far, it is looking like 3 is a sane default.

-- 
Damien Le Moal
Western Digital Research
