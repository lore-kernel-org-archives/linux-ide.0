Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF1C05027
	for <linux-ide@archiver.kernel.org>; Mon, 13 Feb 2023 01:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBMBz1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Feb 2023 20:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMBz0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2023 20:55:26 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF61EF93
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 17:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676253325; x=1707789325;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Ux4ySoJ0nmfZWrlQH4O0Pn6C0sk/7P7CcnFYslyhno4=;
  b=OoYFgPtqKVr+AMLtjJmjffv8vPJqNbjXFRkwr3vwokcQJaVn61NmNxwf
   CfWrfu4B6R+7fnEoYqW0YPRw+i88vR2+MZIE9HaQINTktCPMJu57hc4Dc
   7qyEqXonIe8VJJKeLkKI5OlUtsSzf9yGkDlZJ9mLrJfiZ0y5E3xVbg5S8
   xE96I2X+xFJnXEr1Pt2cyk7B/a2KyMlNRVp0tfnMb7RU+x87mmhUbVEUT
   QmCCOjryUY6JOBq6kiq9Kw7PQLK1hgI57vj9VSh3PzprsadsnaJ4TwhHA
   wzYNosUao3BeCGYQH5X0s//knPjDPk2UHhcJumuPfls5pTn1zUpMoyDf6
   g==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="228106125"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 09:55:24 +0800
IronPort-SDR: MDZk5gnOhPrJvFplDPrl6zePX+ctaO9Y/JR28IAViVjInY/6nbgIkUne+LdJFkSDGszvLCEGsT
 eDRvVfnAuL6+7UOIHtxbZ+3PbyS1K0npoA+TErKYjG+47c8sFazDFsixWvPZ2r5MkRvA1gnGz1
 KsxI07lgz9f4fMmNf7C+1alaWEakcHjNqY8nq2KTzyW2BO2L0erm2OUZg4ACM5r1sW9goQ7KFa
 1SGed/WhixLHA+tky5qg9BBw8rtGBi9tQGSvPp3uazlY74nOhRLj4RRcqu63fe1jovoHkA8Ut4
 8A0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 17:12:34 -0800
IronPort-SDR: jb9HU+AAGwtl9zmTKhJQGOBO8r9LNzsJFBUpPBy1gA35lesC/lhOFpptO3hEmjdg9yJuUNk1XD
 u5bjAjO/YuTorOpeYc7jTMgJwpy2NuENuViW9GBYtpIIjFMRqPOc/EExgEubHnHpVrkResJIdP
 l2smfc7TbEtMyF9vUqRMg7A2FYoceVY12tQ0/CATUIywcGUabMKrwqFmHXQl2WMjU9WdP4+L1j
 NE/xfKIdSZgk7fRwqruEax96iRH7DuSsm//vGPMH3R4w1nkADLwyN6S4tAAXdDjguX/OfHNlpa
 guk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 17:55:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PFS8r4JtVz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 17:55:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676253324; x=1678845325; bh=Ux4ySoJ0nmfZWrlQH4O0Pn6C0sk/7P7CcnF
        Yslyhno4=; b=s1NvIeKIn2BbBEdgMXl7P0VbYlv1pPLNxc8SVwQKhXpvIrXR5la
        4KAHrkoxrtgfC+4jPBHJMC7efMfOEXv5YkT/EIO39YbNexGZm99DBzoREXQCmDXp
        58373Oq2t3izZGXCOC7Q6v97jzpeNdeOZ+U2a6+830ifgX82tf66iccPElcagT+9
        7eEfnNFqEqbJ6O3FBiBeGoONeJmlSHHxm4sYJE9NZGyR2NYo+2QjVP6SWKVs5r3x
        7EER2lWAIt7gF9bSZ8rwZyY6Xb42Rfxb53GYP4yeQ6ENREqjnbXJ1/rhZOLUXCPX
        KTODpXYl54En0zvjm0eVFrvXn8yI1AHaILA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mj_ITwiLFZ8c for <linux-ide@vger.kernel.org>;
        Sun, 12 Feb 2023 17:55:24 -0800 (PST)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PFS8q6mhdz1RvLy;
        Sun, 12 Feb 2023 17:55:23 -0800 (PST)
Message-ID: <fbcb24c2-b6f7-2e5d-77db-c25fe80c6d41@opensource.wdc.com>
Date:   Mon, 13 Feb 2023 10:55:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: The SATA_ini162x.
Content-Language: en-US
To:     Magnus Elfvendahl <magnus@elfvendahl.com>,
        linux-ide@vger.kernel.org
References: <e19a0e0a-b925-3509-0ea3-bfb2c65d4912@elfvendahl.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e19a0e0a-b925-3509-0ea3-bfb2c65d4912@elfvendahl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/12/23 23:53, Magnus Elfvendahl wrote:
> Hi
> 
> Is there a workaround to activate the driver again?
> 
> We have a small production server that stopped working due to Ubuntu 
> disabling access to the drives connected to the controller.

That is not a lot of information to go on... What is in dmesg ? Anything
logged there ?

> 
> Fortunately for us, we are not using the RAID function of the unit, only 
> using it as a disc-controller. That is, the pass-through function.
> 
> I have been ill for a long time and not been able to start doing 
> research as the what the issue is, and I just found this information.
> 
> 
> Best regards.
> 
> Magnus
> 

-- 
Damien Le Moal
Western Digital Research

