Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87988C05027
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 12:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAWMNF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Jan 2023 07:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjAWMNF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2023 07:13:05 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142418140
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 04:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674475983; x=1706011983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NxzP6e5QqDUbOnlxlZN5mv7RQYnrGh8ivkXUzQi1Tgo=;
  b=meY66dPgwLBF6ECWvmAwHpM57UiDbsE+0JvJNQYAoLzfN+4Kro/ufLP4
   zAHs4XLuZ2DRncCjC+KBBx1yG2WXUlPjolvAgMI1l6CaulHjFCQ52cGkb
   W1fhSr5Fx/WxZ9/Y+rsIQu7Y6ifotKPPofxmUkAkLWgHIZXy/jKqo8iML
   9PDO2MOg0xDYrs94yxc3HLy6X9G7hQ6g8muUhF9JI+USJuJKENVP0LIa+
   UzJOSPnglQ6fIUnGhu0oHyM/p1tthxcl3DEs5WN1KeutbsPYo5TdWacky
   0nf0IE9BlR5UD02YTyb7X06REXHmbwGxJKa8vG8uDqbPEWKVrKQNQX6n9
   g==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669046400"; 
   d="scan'208";a="219875436"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 20:13:02 +0800
IronPort-SDR: C76BymYdcCqokfxS8rFAzL4pbCY5opPoQdjy+Tp6yhDI7cE5JNqCIM+HHOtP8zlsqD4dFe41z+
 w+Kgtl2+M3UMDIr5yx5nyYH+SqbBXaB29nBys8GGcgsWuAxS6n3+xYUw0IdJiGc0wTgB1Jr5/D
 YX6RnBen5Jj11ip9D8llQ/c3W8PRNmdfcnRKOPJVuBbMwu8nPA95FJ+4RUO5mdNZTb0ZPRE76t
 /lJMIIZRMKPzSNAHCN65usLltujghyJ6Ej4sce1SPleP2GAAiuMQZCiI31OHRDbEBxEE/dm+xM
 cCI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 03:24:53 -0800
IronPort-SDR: NAh8XxJjbhE1ApK9D1HprFQEJE+D2h8ol1szUnboYI0pd+42GyWGbBdJ7W4mWxoryyosVCcLDg
 fQFATqVyMMqrNHqdkVy7jw7d2XEfjdR8foX1YNCnzlAiLiZitvh6I3+Z7mXQC3iWrDvIyDznxk
 Lj4tsbBiScrDq/0pZMvkA3c4lxGc7Eekb8AHH0XCPmAzwnTmiIqJTEFYWnPwRikgf8CARCpMJV
 WbVi186kybgsf8qu86mE/HoIfyoruTDVRmyxP5viyFHrCEc6jx1cBibNiI0LBdQJmVs5s5Wst6
 MmM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 04:13:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P0psB5Zlfz1Rwrq
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 04:13:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674475982; x=1677067983; bh=NxzP6e5QqDUbOnlxlZN5mv7RQYnrGh8ivkX
        UzQi1Tgo=; b=o354PpCqbRZO4aN1Chdr0dY5AP5TB/OCf9FdhNrkXoAd9lazkim
        PVnYRXRQZhx73qb1hwZcOEmT/iIwYCTgRUVzY69U1b6PJtpxBgLs7CRaqLqghHCD
        JO8D8Wd2mO5GY9a7qgFCVZ2HMu63157mAjkNsph/ofLWWpDTpoYiH8/qa+/yGrTx
        C/Pi0roiEQ5wDDDS1SWNw+YQ67mZ5427T2Ichafwq/KEbZ8Nm7XhHi3fJ+vEL77r
        +AJsUxaJbzJd36ZMgiHeEiT4OJx3ZGCr0oaYDGznls+RNgeYfYIbONOtS9pTQrpW
        y557LB24btLV7wdAiBnY5Kk6p2WBdHEW8Ww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ydPffjA1EJGs for <linux-ide@vger.kernel.org>;
        Mon, 23 Jan 2023 04:13:02 -0800 (PST)
Received: from [10.225.163.50] (unknown [10.225.163.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P0ps93Tysz1RvLy;
        Mon, 23 Jan 2023 04:13:01 -0800 (PST)
Message-ID: <61bf131d-64e6-5ed8-999d-fcdfc6caae1a@opensource.wdc.com>
Date:   Mon, 23 Jan 2023 21:13:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     Hajo Noerenberg <hajo-linux-ide@noerenberg.de>,
        linux-ide@vger.kernel.org
Cc:     marius@psihoexpert.ro,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <70a4c391-925d-a4af-2e6e-793b75e5cd0b@noerenberg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <70a4c391-925d-a4af-2e6e-793b75e5cd0b@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/23/23 18:10, Hajo Noerenberg wrote:
>> The same router works perfectly when I connect a laptop HDD. The same
>> DAS, including the same eSATA cable, works perfectly when connected
>> to an older Linksys WRT-1900AC v1 with Marvell Armada XP (MV78230),
>> using sata-mv driver. This is the kernel log from the older router:
>>=20
>=20
> Sorry to interfering in from the side, but I have observed very similar
> behavior with a Marvel 88SE6121 controller (AHCI kernel module): Very
> old SATA-1 HDDs (mostly laptop HDDs in my tests) work flawlessly,
> SATA-2/3 HDDs consistently fail. Limiting SATA speed (libata.force=3D1.=
5G
> ...) does not help.
>=20
> Interestingly, SATA-2/3 HDDs do work with U-Boot and 'ancient' 3.x
> kernels. There was a suspicion that it was the PCI subsystem (the
> change in kernel 3.16 from kirkwood/pci.c to mvebu-pci). Pali Roh=C3=A1=
r did
> a great job to investigate this problem very persistently, but in the
> end we did not find a solution.
>=20
> Without knowing anything about this area, there was the assumption that
> the problem must be at one of the lower levels close to the hardware.
>=20
> You can find all the details and a lot of protocols in Bug
> https://bugzilla.kernel.org/show_bug.cgi?id=3D216094
>=20
> I've been trying to revive my NAS440 for over 10 years with all the
> components (https://github.com/hn/seagate-blackarmor-nas), so I have
> the hardware available and am happy to persevere to try things or
> otherwise help.

Well, the first thing to do would be to test your system using the latest
kernel 6.2-rc5 and see if the problem still exists. If it does, please
report the issue.

--=20
Damien Le Moal
Western Digital Research

