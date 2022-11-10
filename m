Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FECC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 10 Nov 2022 02:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiKJCGQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiKJCFx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2022 21:05:53 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B61AD
        for <linux-ide@vger.kernel.org>; Wed,  9 Nov 2022 18:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668045952; x=1699581952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iaP0AsfpD5oKOtrU9XDK5Cy7gJWFY97QcCq5HKOWRaU=;
  b=RLy7u+lxFD6et3N/F3A3ea2QZJ4IRQ4YkwLS0u08JIJgPysd93MwiWDr
   DkWpXnjyBh5pKe4s9SB1iPZsnwESdQwF+zT+PnL0CBWbu0UXxbnLOKLjb
   GPbIFEPmt/L2N0Swue3s47DBYnYlauIiCdD6elM0OiKnSM9ppeKk2qIuU
   FGa+I62A43BsQq0T880PF7fnIJOiDvEHd4jpf92uN4hWSF/bUF3hNUjBU
   xPnXkj/CdReXI6b6QzxfiRUMH0NwzIwR2WrQXbKa5gObu1ZP/Ugqi1W2d
   Z+vZcrzfteFUoZRGBC8xOLmBl/8ZwxFKBI5kJQ+f0RjJZ7jDn/RLbmu7J
   A==;
X-IronPort-AV: E=Sophos;i="5.96,152,1665417600"; 
   d="scan'208";a="216245837"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 10:05:51 +0800
IronPort-SDR: 47xL5O+P8JJ1XUH9LpgArc7RFRR0f7DoHRNrJX7RbBJGH4EWcgdmfF/C/G3kLZwPbdXRtVFs00
 Jiu686Ew0MSJuTQJSDPsPiqFeLXSrrQHaTpAormkh0l7+UWVXj51kBXY2g8ZUb/+gU25M8ikFz
 /Wq1OgrrODFKfrRBLfSy0Y7mwxpoVmrSH1juH2n/8xtBs9k9PRF0l3z+5zVXTuEdyC3laWcAgF
 sb3WYWvQ7TaNGnj+uvDXiOVdW771lHBGQ61FvmelBZcLqLGfUCGLq96FoHlr1IuF3TTvpXQNeq
 Eyg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 17:19:09 -0800
IronPort-SDR: BZVPAWof5+TIwP/6MeubHHwgQEA60oaF0/lfapj8nwuHRmazrdDUy+ihpRLZsaW7EEFm8H/jGz
 hg/B26szkN300BePhPbkusGTGRD+VZzY0c3RW8jZLkGnPJEdKcGgG9oXDCpMJMwRaAooumiNuo
 rfafM0kODcWX69Di3tHHP/u47eof91ZAEcUxDc7R6bNohMrKPD0YKyZaqTrnt7EuWoH3AYL6R+
 UFOEr1yZZAH0e9IlW1/IN2bwPu9kXERElGb/txSHMswMATTxTA5ke+SIOz1pePL7MeDaFt7I2h
 Neo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 18:05:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N74tj2JMLz1RvTr
        for <linux-ide@vger.kernel.org>; Wed,  9 Nov 2022 18:05:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668045947; x=1670637948; bh=iaP0AsfpD5oKOtrU9XDK5Cy7gJWFY97QcCq
        5HKOWRaU=; b=UtThT8GjId50JOIbhedwDj2nBklaiTQZxJKmSmkt1Um6Wefmy7l
        01XyfiXnYHI72a/bFG6+NH71IhybM9ok1g5MxxG8QNqdIaaTfolQpzIiecNc6NcN
        vdeoEqLO4qAVRQ/Zd2yd2VOUcB++DylWCXuM5cQedvdRTMOtcQLx/ICGfnQZ7Orp
        UbGQnNbloPgB7UB5JZf+vER85KSWAjthkvybceNku09DLb0UJ7TUPArr/L4jioxd
        3jXm22zUDnzLaQQe8SB3WEGbxCaC6VISlT5RktQB1TQtwgIeOThcy79UgF39AFF9
        iCvMaCl4gh+k1LleIHPiMjlWOs8ESkWZA8Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id slzLSgceRaF3 for <linux-ide@vger.kernel.org>;
        Wed,  9 Nov 2022 18:05:47 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N74tg1xxpz1RvLy;
        Wed,  9 Nov 2022 18:05:47 -0800 (PST)
Message-ID: <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
Date:   Thu, 10 Nov 2022 11:05:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/10/22 04:55, marius@psihoexpert.ro wrote:
> November 8, 2022 8:27 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> So the adapter & driver are OK for regular ATA devices but they may not
>> like port-multiplier devices, or one of its flavor. See:
>> https://en.wikipedia.org/wiki/Port_multiplier for a nice summary. PM
>> comes with either command-based switching or FIS-based switching. The
>> adapter may not support the flavor that your PM box uses, while the
>> sata-mv adapter does.
>>
>> Try to check the router SATA adapter specs and your PM box spec and see
>> what PM flavor they support. If that matches, then this is likely a
>> driver issue. If they do not match, then nothing we can do. You will not
>> be able to use that PM box with your router.
>>
>> --
>> Damien Le Moal
>> Western Digital Research
> 
> There is a lot of info in Marvell Armada 38x Functional Specifications manual, but I don't
> understand it. "FIS" is mentioned.
> See https://ulli-kroll.de/Downloads/NAS326/A38x-Functional-Spec-PU0A.pdf , page 241.

Yep, looks like the adapter does support FIS based switching. See table
1291 of that manual.

> From my kernel log:
> ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs
> From kernel sources ahci.h:
> pmp means "port multiplier"
> fbs means "FIS based switching"

Yep. So the driver says it does support pmp & fbs, as expected from the
manual info.

> Areca didn't write information so detailed in the manual, but it does say it supports NCQ,
> so according to Wikipedia article you indicated, it probably isn't command-based switching.
> Is there any way to get this info from the working router (sata-mv)? Or if I connect it to a desktop PC?

For the working router, you should also be getting the same message that
you printed above, listing the flags of the adapter. On my test box, for
an Intel C620 series AHCI I have:

ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part
ems deso sadm sds apst

So no pmp nor fbs support. And for an additional Marvell PCI SATA
adapter on that same box that supports port multiplier, I have:

ahci 0000:61:00.0: flags: 64bit ncq pio

So no pmp nor fbs either. Yet, I have a 4-drive port multiplier box
connected with eSATA to that adapter, some random unknown vendor thing.
And weirdly enough, it works fine.

On a different test machine, an Intel Z170 chipset AHCI says:

ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part
ems deso sadm sds apst

No pmp/fbs again (No Intel adapter that I know support pmp). And an
ASMedia ASM1062 Serial ATA Controller add-on PCI card says:

ahci 0000:08:00.0: flags: 64bit ncq sntf stag led clo pmp pio slum part
ccc sxs

pmp is supported, but no fbs. I have a Logitech LGB-4BNHEU3 4-drives box
connected which does not seem to support fbs (the manual is useless
about that). It works fine, but when connected to the Marvel adapter on
the other box, it does not...

PMP is a mess and never really stabilized as faster USB interfaces
showed up at about the same time as eSATA tried to spread. That never
happened, and we are left with a bunch of devices that are hit-and-miss.

This of course does not mean that this is not a bug in the ahci-mvebu
driver. We can try digging into that. First thing to try: enable debug
messages in libata and libahci/ahci-mvebu. See
Documentation/admin-guide/dynamic-debug-howto.rst for that. Then connect
your eSATA box and see what it says.



> 
> Marius Dinu
> 

-- 
Damien Le Moal
Western Digital Research

