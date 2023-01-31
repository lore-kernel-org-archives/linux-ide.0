Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A220C61DA4
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjAaCgj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 21:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjAaCgi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 21:36:38 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7837F10
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 18:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675132555; x=1706668555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SNeQfKOzxazL03Bi6f8L2PK2N7W6QrSqPRc7tQbUgyA=;
  b=DC0IOOl6XjL5Hna8qdjg/9xMD1u8E5nhuFEtk7O6Wc0RnczzuHyDUq6G
   IiQU7mNmA2kCu3xPuMrKtfsDCsMVk1CSzXcwyPDcglUJFMdr2O63Vjtz9
   oKfitiy4+ttSwRz9kd53ef2NjWhH/g8Gfaq+CAw+jrXyz9PGannVnAI5x
   6kvw2KM9cXBJr4FtbpMLN3/nPpEcM6Lq0gcD8dwV+nTTecva3MgGIQxTi
   DHtPuWUdpnF0wn4rTJPO9ii3CNMgSRoIEoGxWmd2kj30GmqOaU54lfXK0
   F3WZv5d1EuK6B6fJuiPScGThg91hnNukKcJ1ZEmpOC5JBq6vuCpYFbGNn
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="334096400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 10:35:01 +0800
IronPort-SDR: uXnMb53PZsIOk97a2ZTOyBfPI4dQ+C/TKb4fHz9Wu7nV0CAJNZMRmaaWvF3cQy2v72L9NgoVqt
 G+273xTFonhfDb0L+OUsoxShVoTBgoyRJGRQKKxZ3Bz797pqpIPD+9i8olER6mGmOSQWq1+Ynl
 SMDVGyq4lH8Ern1nYULFXD0BJH3AOcQtduiaCj/9cpKBw8bpqRpRosvjJb3vTeGI7SYsRUJXhq
 l5zlmNcYKd47YzEho9p5DMwMYpOm6sVax1QiIXJAmizRkhFcwmKm+aNDJhvBU9k/RG34TWGHS8
 djs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 17:52:26 -0800
IronPort-SDR: b/URwYT/q2fIs9SXh10BY+ia/1exQALeisVIKhV1movX1DWA1oQfddeFlQPYHxzcK2MLNsihvJ
 rS+idPhiGfUW3JyJ7DlzmSG5Jn9qDIZ3sCVGpHL3l38b/HoLkmfgsFZfhGlv/TjxRSILmPCbZZ
 /7DkgSuQLPcZI8h3ZJV2gSI12qjGgyY+xnUyzC0mDv4PbHui70E21Cz/PnQGs+W23ExZtAF11A
 EgQ+vP/5y0SvlW1aAqF3oILYn7ZSNoq4Hp38+tWVwua6UdY81T8pGEgkgQ7aGB1cx8t/hkWMvF
 MZs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 18:35:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5TfY5Cj4z1Rwrq
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 18:35:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675132501; x=1677724502; bh=SNeQfKOzxazL03Bi6f8L2PK2N7W6QrSqPRc
        7tQbUgyA=; b=dMJJfFHihTNKloKThOcz6pDKfVyF8SaJICmxOk6T8dtV3bYFUOx
        /VtCMpJcodap7obbBT0V4uPiWi0LXyMquMWcpOuET1PCtRVuj+gkmFapwB0hONXf
        wIgyGHjByTP5+kVq1OHEJJ3fSQXgIvpn6BS3u8jN5oAeXL2/XRvNxvwmPujPhC1o
        G0Nak5faxYubTBConQ6ofPyGlVIHOVpqLp8b90/YJOBuiHRlVvZSmycBkGLE3ODo
        L+EzJu0c4MUmDNnhI2Ce/0BJ9U2Hs0O1Vrs+tEjRlputbCO4zo1ScyNI6X6pa5E/
        HpwiDywfnqQsqDUCmgs/zRmHjBeDuT8bd5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bMgYzUlMrwRI for <linux-ide@vger.kernel.org>;
        Mon, 30 Jan 2023 18:35:01 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5TfX4Sp8z1RvLy;
        Mon, 30 Jan 2023 18:35:00 -0800 (PST)
Message-ID: <341397a1-9da5-466d-a738-cad79e8d2390@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 11:34:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Marvel 88SE6121 fails with SATA-2/3 HDDs
Content-Language: en-US
To:     Hajo Noerenberg <hajo-linux-ide@noerenberg.de>,
        linux-ide@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, risc4all@yahoo.com
References: <db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de>
 <930a0685-c741-110e-40c2-660754301e5a@opensource.wdc.com>
 <a248857e-991c-16d7-496c-9dc692186ead@noerenberg.de>
 <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b4a515f6-e11c-756b-ff90-114836f919f9@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/30/23 22:40, Hajo Noerenberg wrote
> Summary: With U-Boot and kernels <3.16 the drives work, even without jumper.
> I wonder if there is a way to get the drives working with up to date kernels.
> This would have the benefit of a.) no need to set jumpers and b.) getting
> bigger/newer drives like the WD30EFRX to work which probably do not have a
> downgrade-jumper.

Can you try with libata.force=nolpm ? A lot of old WD drives have broken LPM.

Also, did you try with the pata_marvell driver instead of AHCI driver ?


-- 
Damien Le Moal
Western Digital Research

