Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E569C38159
	for <linux-ide@archiver.kernel.org>; Thu, 19 Jan 2023 00:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjASA3V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASA3T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2023 19:29:19 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40D5FD72
        for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2023 16:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674088158; x=1705624158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sWJiQobN+0+lYp6N/mgIWU2A4vK/ghJzsbDaE3IN9ck=;
  b=No1V7LYc7OeF4fj7qWg1kvd9xvwqlNh0UyR9gfAyEDlJ+eBs2xOnFrFY
   GphjrNtzR4aaX9HiBYcqvu1QmXbvbvaDvvBgcs7eJqk5JQfAjTlTEr18q
   LPRG114a9BM89wRK53vgGBgeRm5nTHqwRDh3dkYypiVt6HLINNSM3Kme/
   UgFOt/lapxWh7tlE596MWu/WSq+Gz5im6qYheXosZbUsbREBqwfH/VmlK
   /8i3nhZwHwiiphasMicH3mFygbANpn/vZXrpyueEO2Hl1QnuUVMIPz1Ly
   bFFISQsWzlFWwHtVP1KB9O0S/MsPmJz8lIDtqvo+1+9yJbu1jGfR6Uhqz
   A==;
X-IronPort-AV: E=Sophos;i="5.97,226,1669046400"; 
   d="scan'208";a="325475854"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2023 08:29:17 +0800
IronPort-SDR: JvGya9bviVpUrSgo9yXVqCBvXNQnYlLUAds7OpjSvMOxo2ooe0KnDtYoLx7MJ//CWX00aPwxn7
 J8tnA9RvsbWuLPrwoGoDmukK8R8lAyg19ovYQFntsJqObZwlwUgdknQYsUAOEkeNN9Q/K03jkt
 IqUrK7mz16Mr4gYf9SKvjsxK6iPeV8dgk87AxB9zGq6JCWLEWUNpcR3rIQ3ZQQPYIw/i2M1+We
 Ifde0ScAOMrDTnrLtwxMdmAxHCsYMTB7al2QmTi8XyqRE4uk6+F420OrjAJG4d8xo1buk3Uyid
 9XU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 15:46:56 -0800
IronPort-SDR: w51vGyZJwTJ76jmQsPK1F+4cGJy16YRnpkzWOv/gZgEJLpcTa0gQC7cE7dec/QQFAoOqtzLFGq
 OpQ5F6NC8P3XFIVFPs0IkuXWoUDHm/wLNMGzi+zMpcynmVI/JwY9wGNypJWEnBZmG4fPbCOpXa
 MVSj9sZBZaUZBB5bTZjR6Przsyb0dgW/AhxqZP/RFhKAV6c72CLOs7hn7kEVCh6u5zZAP3gQ+W
 mzV9CWeh0YOb3fbiROIlnpG/h9/VY9d2JcX4Ccx4BMz5hIopvUs8zwgy184cZBhWyWN3CsXSiA
 CBI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 16:29:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ny3R05Lmmz1RvTp
        for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2023 16:29:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674088156; x=1676680157; bh=sWJiQobN+0+lYp6N/mgIWU2A4vK/ghJzsbD
        aE3IN9ck=; b=go99c9otVZxBxvEabGMfegMifmMOKrQm5hjQSPHPV7ZO8H1JAJs
        XM9fMMqHszsQ5vKTPUaZxfjVgflYlUxOTqiZwnqbBQIqMHT6zUN2tU5Unp9K7haU
        MNWtvvg4ElABCxSsjfFI1ZR0KeC1GKm8Kom9iaMils2vf4rQrNZnH3fzQZBwToh3
        I2zNrheHkFeywGiJ7hKxK1O3y0Z4pWH8I8oza+BdEZLa9zeVwKqavYDCJcFuJpD/
        /SIl/4kmy5yv4uWopItAvKk0Jc6tIVLNDgn45oQ4BGTVwi2Yhj78hP4wlrBWk3Xn
        Q/RHGbuBkyLTVJSI/M5Ae/4J7DgFoDERmoA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tFi6CMbNtoHb for <linux-ide@vger.kernel.org>;
        Wed, 18 Jan 2023 16:29:16 -0800 (PST)
Received: from [10.89.84.31] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ny3R00BXjz1RvLy;
        Wed, 18 Jan 2023 16:29:15 -0800 (PST)
Message-ID: <5171a47a-e508-1433-6975-8da5b27318b8@opensource.wdc.com>
Date:   Thu, 19 Jan 2023 09:29:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <41774337-a8d9-a2de-72ea-27b6016ff720@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2023/01/19 4:43, marius@psihoexpert.ro wrote:
> [ 73.075849][ T112] hardreset, Online=>Offline
> [ 73.075856][ T112] sata_set_spd_needed, scontrol=0x300
> [ 73.080328][ T112] __sata_set_spd_needed, initial limit=0xFFFFFFFF
> [ 73.085601][ T112] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
> [ 73.091900][ T112] __sata_set_spd_needed, target=0x0
> [ 73.098386][ T112] __sata_set_spd_needed, spd=0x0
> [ 73.103475][ T112] __sata_set_spd_needed, final *scontrol=0x300

Can you share the patch/diff printing these ? Just to be sure I look at the
right place :)

...

> [ 76.203475][ T112] debounce, SCR=0x100
> [ 76.263475][ T112] debounce, SCR=0x100
> [ 76.323475][ T112] debounce, SCR=0x100
> [ 76.327332][ T112] resume, return at end of function
> [ 76.331189][ T112] hardreset, ata_phys_link_offline check failed
> [ 76.336287][ T112] ata2: SATA link down (SStatus 100 SControl 300)
> [ 76.348747][ T112] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved limit 0xffffffff, hw limit
> 0xffffffff

OK. And here is the problem: cur spd is 0x0, so unknown, and that leads to an
einval exit of sata_down_spd_limit() instead of trying something sensible like
starting with 6Gbps. That leads sata_set_spd to also have cur spd = 0 and
setting of a bad scontrol which prevents detecting the drive. See the difference
with forcing 1.5gbps:

> [ 19.819298][ T112] hardreset, Online=>Offline
> [ 19.819306][ T112] sata_set_spd_needed, scontrol=0x310
> [ 19.823798][ T112] __sata_set_spd_needed, initial limit=0x1
> [ 19.829052][ T112] __sata_set_spd_needed, corrected limit=0x1
> [ 19.834752][ T112] __sata_set_spd_needed, target=0x1
> [ 19.840614][ T112] __sata_set_spd_needed, spd=0x1
> [ 19.845703][ T112] __sata_set_spd_needed, final *scontrol=0x310
> [ 19.851592][ T112] resume, do loop
> [ 20.083568][ T112] resume, after do loop
> [ 20.143567][ T112] debounce, SCR=0x113

We have a good SCR thanks to spd being set to 1 = 1.5 gbps.

So patching sata_down_spd_limit() is the right solution I think. Let me cook
something for you to test.

-- 
Damien Le Moal
Western Digital Research

