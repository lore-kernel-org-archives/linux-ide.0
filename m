Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520D5C38142
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAaXrd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaXrc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 18:47:32 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0958F2B619
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675208851; x=1706744851;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=RxCk67QNwa//MxVAABUiYO3ZqirMz45Wqq1HJ3aLvKg=;
  b=g/huigFGZzOt7a92wOVbsRlgluN+HwU/dcZQz6jffJPqAwpvd4zGMJ4V
   DJ6JNLsmnj23izfIA/mUXWGHUpRemGy8/2KawaCfkIK3huiZTdDN3N5nw
   Wee4CKB2PRzXP/+V54SXtp23vVDdRVYZFDJC1NIdL/qmNoQcVSGEBuDzV
   fut+9lsKBuE9dv4l02O4gYQqxPwFeH4jPppL5mq7KzI/oGUUMIeaHjhg0
   7hgpL3o6m2vwZiRW2+8tW78OezAJMVx7Iz3TEdqpx/HDSYGpaMEoYxauR
   nyfDU8yJwb4lYrEA7F9snO85XjOuvvX1unBMS9cRHGwH4qVK9P8wfg6ee
   w==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669046400"; 
   d="scan'208";a="334181337"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2023 07:47:31 +0800
IronPort-SDR: H+KuO1Cn+VAf/XjDUxXJG588sNuhK7th4G8FdXB2tK/wTJLFN/l6kXuFY5P738LwYU/cNitJk+
 UFsoZE0QtIK/vO042BLZIj7kfZ72Aklun6FNQMY6HzbCrOMaWq50bCLvUQ6j5Tdv/8maZBm9VP
 djvPmuUjbjUEFsgv4OACQzGYelzSDKorfhBbwwIWVBkMV3VO8G0/iXJmR3KmykoJ/QQd8Gr6sA
 FfgLodxFtwj1mu8EU+Uiu21MrUAN0KXBozMggyT+U6OKta1njUAA1sNUDiuzPnALyYd2lZYrmc
 itA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 15:04:55 -0800
IronPort-SDR: oDCFw6rSA9F/TRCwB2oF1yLmbaTVb02UiknWaRX/ZuEM4g3Jiwmn8+qBblLMigdk+PjCR7wG8m
 9x+J6/EVg9wyLu1qtgbPLiiNYZSSJv0izgh5cafLdbLx+fOqPMgz/K7shp8PDbsCc3dr7nC+Cz
 q5EFHtCuCUZCsiNeDuuXDjhOn3Rd6MeKqLV2IwkFk4v00zKzfnQgBKc/353aA9oVk0U8yzFC8U
 Mt5Gade9dEtPWK7+pXr1bBF8n+Em11jBETIdzAFBWhJliU7D0ITBRUVEJzT7fbRfM/yYM9J196
 TI4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 15:47:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P61tp6GRrz1RvTr
        for <linux-ide@vger.kernel.org>; Tue, 31 Jan 2023 15:47:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675208850; x=1677800851; bh=RxCk67QNwa//MxVAABUiYO3ZqirMz45Wqq1
        HJ3aLvKg=; b=JZrPal9CQK43Y8KYwKihe96P/r8U3GkYToW4eR35ybcHYk7A8zh
        U1FkX0l4asJ50MObkplidNKsNtE3PgCkXiK3mjIwdxZs1uydO6KNr2Je15uaxM1S
        UD351CjgGwhjr2tZbTnzHUwCGRfrO7zWETfO/qslSwBPJPCFKTxvnERWP3moUAAz
        fQ6v1m1uW+hjpZVjn4/X18FgzaJS0whZz+7daZcIF33TlwlYUBOnd/Xd1FmSaTWl
        mhkRy+1uk24GFROtb6EDmFCVF3LeUn6jX7tpVwC6g3SP2xRD/lDZwX8WhxggUlIV
        qhY32CuiYOwTGkttyQNr+0dvqHpkDt2VaXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LRnk09BgE3QW for <linux-ide@vger.kernel.org>;
        Tue, 31 Jan 2023 15:47:30 -0800 (PST)
Received: from [10.89.81.171] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.171])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P61tp0NV0z1RvLy;
        Tue, 31 Jan 2023 15:47:29 -0800 (PST)
Message-ID: <e3403b61-a015-8937-288c-78fd782173a9@opensource.wdc.com>
Date:   Wed, 1 Feb 2023 08:47:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [Bug 216982] New: sound hit
Content-Language: en-US
To:     bugzilla-daemon@kernel.org, linux-ide@vger.kernel.org
References: <bug-216982-11633@https.bugzilla.kernel.org/>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bug-216982-11633@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/02/01 1:59, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216982
> 
>             Bug ID: 216982
>            Summary: sound hit
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 6.1.8
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IDE
>           Assignee: io_ide@kernel-bugs.osdl.org
>           Reporter: kirill-s-0801@yandex.ru
>         Regression: No
> 
> The sound disappeared on the ASUS Vivobook. When I plugged in the headphones,
> the sound disappeared, after removing the headphones, the sound did not work.
> Switched cores, there is no sound. When there should be the intended sound,
> there is a crackling in the headphones. And everything works on the Windows.
> (fedora 37)
> 

Why is this addressed to linux-ide ? This problem has nothing to do with libata
& ata drivers.

-- 
Damien Le Moal
Western Digital Research

