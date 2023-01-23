Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB2C05027
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 07:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAWHCM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Jan 2023 02:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWHCL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2023 02:02:11 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3113DDD
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2023 23:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674457329; x=1705993329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m32N6yfyapBoZgijXgwVdDZzCkyqP4nL9Rslza15ees=;
  b=oHXKbYlyqM5xxZqt35w8sTKWcl6lztRefqyH2QetmuN1R4SDrVQPOuiy
   k9D/OBVP0HTOhpyT3FYlihNi0Pw4bxxOPAHFHxN0o4aD1F11DZV4pf+Vu
   qygxIkJ8FAE+0p9+wfmBtyAlZ56BdNQ3ZSFME/51dytKIg3nfj/9BIU2C
   3ivq0+4UNn9SR0WTx8KDLHuusWc0+BA9FGP6tFSwp7D5l1TZqb5Rb4v/a
   LtG6pO1rgtODbv2SjZDKjaikfyK6Evw13kFGawWwvAy+xO0ts2GG7hBJR
   R+NendCR9vffEVyEbJ3gtld/DIxhqiVrvfsDYzpO1eOrXv+XGZ418Jfyw
   A==;
X-IronPort-AV: E=Sophos;i="5.97,238,1669046400"; 
   d="scan'208";a="333515429"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 15:02:09 +0800
IronPort-SDR: rx89ErJZSFN6EyH88N5QLZw1lxyEuiBM3Umri/fb/D7htwBoshoqGNFdcaOrwUeSO9YKIzoo/c
 HC5oQCeovZgJ4ZYhcZTsgjgFYgG3QhT+ztSkAJJN5pl7r6ZS3PfNGwy8CcGdwS7T5bNMa4Y7MD
 rWRZ1tMntB8VSGxV41V3Tsf+uFoTmQ9O69MFgxSWS7vYcw46KfVmeZSRkLEz46QbGqkPuh3Siz
 Cvz8FevTm0Jo38INMbuiNKsewChTRfmb/0OV6/zi2bh6UTpibAiryJgghXxB/nRS/s0lojFvvn
 MYo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2023 22:13:59 -0800
IronPort-SDR: 6JVKkesEzutAzYBJzbbtXTaBIEQh+BabsnyESRZH34srxTX27Lsu80okd5cdp5FLn9iDSkTj3t
 l7NG9yNM4VjrPklEon7D1LzhWIiFskqpx5vrqTdRoS2Z9Ki6XQqcsbwMeRKGXIlFMkE7RKp6YF
 SVFoZtDBlJAyMSPeoqFpJo9upds8884rFogYxFYu3+OqkmU8dpWUbx2TmePAZRCds2k52Kt2qz
 wIjJuXn5WzhLAmxrZ8vdvfa+AbTNW0E/z9mN6lLvbCKgZnAtQxJ5s3RF27GL0eK5cx6+sEyjRN
 gyM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2023 23:02:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P0gyT12nbz1RwqL
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2023 23:02:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674457328; x=1677049329; bh=m32N6yfyapBoZgijXgwVdDZzCkyqP4nL9Rs
        lza15ees=; b=Ft+TIy8HfTG7k6bHa8Y4KhgKpRC73irBMQ2qGLm8p8WWPp+fpdv
        DOOgC4NIkm4B9gBndN6siLm+cWC4RnQKjagtj9YDgfQ0n8zLBxy8vp/NRk+eO9hx
        8SoLEtKPih1Z+mH7gkn25XHeIMd949xOlGe1fthiFeTgKHCDWNXU3NbRam/HZlIQ
        syKtXgpttDj40quT3Wyfjxp1jYtaXTzBzI1k0rtWM52dUaDwUOADbTq723yRdFz2
        hC9ND2YjBBeAxxp0nOpZ6hE0+HEYjuuU1g00IbsrR+Echuj+fFpzdGreqy8/+oXm
        tqwJkhq4Hm4/gInSXKvLv6eq/XaRwYJoIMw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MADMAsyDxraw for <linux-ide@vger.kernel.org>;
        Sun, 22 Jan 2023 23:02:08 -0800 (PST)
Received: from [10.225.163.50] (unknown [10.225.163.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P0gyS2Tjsz1RvTp;
        Sun, 22 Jan 2023 23:02:08 -0800 (PST)
Message-ID: <cf5d33e3-995f-4346-b02a-b203ed94d9e3@opensource.wdc.com>
Date:   Mon, 23 Jan 2023 16:02:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <5171a47a-e508-1433-6975-8da5b27318b8@opensource.wdc.com>
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
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/20/23 03:46, marius@psihoexpert.ro wrote:
> January 19, 2023 2:29 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 2023/01/19 4:43, marius@psihoexpert.ro wrote:
>>
>>> [ 73.075849][ T112] hardreset, Online=>Offline
>>> [ 73.075856][ T112] sata_set_spd_needed, scontrol=0x300
>>> [ 73.080328][ T112] __sata_set_spd_needed, initial limit=0xFFFFFFFF
>>> [ 73.085601][ T112] __sata_set_spd_needed, corrected limit=0xFFFFFFFF
>>> [ 73.091900][ T112] __sata_set_spd_needed, target=0x0
>>> [ 73.098386][ T112] __sata_set_spd_needed, spd=0x0
>>> [ 73.103475][ T112] __sata_set_spd_needed, final *scontrol=0x300
>>
>> Can you share the patch/diff printing these ? Just to be sure I look at the
>> right place :)
> 
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -427,6 +430,7 @@ static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
>         u32 limit, target, spd;
> 
>         limit = link->sata_spd_limit;
> +       printk(KERN_DEBUG "__sata_set_spd_needed, initial limit=0x%X",limit);
> 
>         /* Don't configure downstream link faster than upstream link.
>          * It doesn't speed up anything and some PMPs choke on such
> @@ -435,14 +439,18 @@ static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
>         if (!ata_is_host_link(link) && host_link->sata_spd)
>                 limit &= (1 << host_link->sata_spd) - 1;
> 
> +       printk(KERN_DEBUG "__sata_set_spd_needed, corrected limit=0x%X",limit);
>         if (limit == UINT_MAX)
>                 target = 0;
>         else
>                 target = fls(limit);
> 
> +       printk(KERN_DEBUG "__sata_set_spd_needed, target=0x%X",target);
>         spd = (*scontrol >> 4) & 0xf;
>         *scontrol = (*scontrol & ~0xf0) | ((target & 0xf) << 4);
> 
> +       printk(KERN_DEBUG "__sata_set_spd_needed, spd=0x%X",spd);
> +       printk(KERN_DEBUG "__sata_set_spd_needed, final *scontrol=0x%X",*scontrol);
>         return spd != target;
>  }
> 
> @@ -467,6 +475,7 @@ static int sata_set_spd_needed(struct ata_link *link)
> 
>         if (sata_scr_read(link, SCR_CONTROL, &scontrol))
>                 return 1;
> +       printk(KERN_DEBUG "sata_set_spd_needed, scontrol=0x%X",scontrol);
> 
>         return __sata_set_spd_needed(link, &scontrol);
>  }

Thanks for that. Unfortunately, my PMP box is currently disconnected from
my test machine in the lab. Need to get there to reconnect it :)

But I think I got an idea of what is wrong here. Can you try this patch:

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 18ef14e749a0..cb12054c733f 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -436,7 +436,8 @@ static int __sata_set_spd_needed(struct ata_link
*link, u32 *scontrol)
                limit &= (1 << host_link->sata_spd) - 1;

        if (limit == UINT_MAX)
-               target = 0;
+               /* Try highest gen 3 limit */
+               target = 3;
        else
                target = fls(limit);

Note that with further digging, it seems that even for a working system
with all drives detected, we always end-up with something like:

cat
/sys/devices/pci0000:00/0000:00:17.0/ata6/link6/ata_link/link6/sata_spd_limit
<unknown>

And same for hw_sata_spd_limit.

So the UINT_MAX blind initialization of the speed limit before probing
seems to never be corrected and set to the actual limit of the
link/device. That needs further correction. But for your case, the above
should fix the issue I think.

-- 
Damien Le Moal
Western Digital Research

