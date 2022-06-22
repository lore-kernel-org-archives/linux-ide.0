Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE706C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 22 Jun 2022 23:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiFVXpT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiFVXpR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2022 19:45:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313AA42A2F
        for <linux-ide@vger.kernel.org>; Wed, 22 Jun 2022 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655941517; x=1687477517;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YdSf2yB4jXP5hnDFm5JFFyMmIBMmskTgp/VDw2VuMOQ=;
  b=AoiPCwFOpKbRxkde5rkoVBID41zf24CR0k7TeEuEdFtld/p1ZtgVCc3l
   WLYWjiuEwa6W6ld5RrdUbZriKFDRBwC7N99DoUiRO90tkIcqd03kz9m1c
   +Q5QWgivvjBJ7df/8D9tAJB+2UKELE+4G4nq5MFGn2pZFyQ1waEtvfW34
   peTDHLTbJr7gY5SPfCRWtb1XmFv9/DjLkwRle1AGw1+7IZaJXFjxxF5iJ
   3MP6q/T00/IGGWYT5vvGkTWEcmgiDYj4w+aCe6uaDP2/Z+X3aPsPNDQEo
   SMfGa5qgbpiqIYfbIU+8TvDE4pfxwVSu+zQWqoeSnzBUFpOSc5WXC8N+r
   g==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="315975035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 07:45:16 +0800
IronPort-SDR: ppjYMeWnAXDXQybyBrWvUuV/RctcrY8RO3/rCRZZxq6apMyUrLizLn8RjQBGdoJk2imdHMJY+S
 kWKjS4Hxa1mp+QYri50jcOe1280J1+pE+uy8UEWdaza68/ztUyGpQ9MB/SQ4eD+6D40o0UH8/U
 /w9oCG42fQ/CW/e9QnLUX+Oa/6CnVYdclltAbVhORuUvYgRZDP640iqRNgTquNjrBXzu01rlZG
 m/H1E8EmTGL5cE115VJ3cQHe4Bph+1MryJFpVPD0Fk0GkMQDNGg2iSnGJLLisl+Hro6B+OTIlK
 MiVih0XKc6slnZFH87l7x7Qg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2022 16:07:45 -0700
IronPort-SDR: 7Nf4Z3/MDStzNoEzec9SDROZk5SB+Rc1phSCF5ajiM13KINR1+gqCpfgLgNjEQi84RGNqOQA/e
 S/Sh+0ZcCPF5W4O0WVm9G70INkqjDjwBqHt6Rf9OizYQNvnwj9mgs24L6Fw6AHTLEW5Afbgt+C
 pCX1Yig3nyPNE5kqsmCfwXvjWCICkCBWQX/9beTw6xbIoOLLfpGr3cLXjpK3yW1njBURRRENOH
 jGyk8/9LzEGfnQWhybpdvhfWP7xva+3cK5k89cLbRM+cRgu2dw8i/dJTmnLCGrwFhVeFRIrkS9
 /uU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2022 16:45:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LT0P81dwMz1Rw4L
        for <linux-ide@vger.kernel.org>; Wed, 22 Jun 2022 16:45:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655941515; x=1658533516; bh=YdSf2yB4jXP5hnDFm5JFFyMmIBMmskTgp/V
        Dw2VuMOQ=; b=tuFBZcx4mLnQ9CAgn9NHqShZD+rKZzIZoYkZ7HP5FnteINxIwh5
        3Cr39e42T59jf+yMo6FpV5QMrD/ZOxz9ZmY4uSvEBFwmHc/g847YyFyhN6FkRTwD
        Xc2ge1oMBPhR+pfhQtiaVfPv0bahrBllUPJkSYdp+yeNgDYki+4qXxtOx9N0jqHW
        GhhqnQtBQ1JNGu6fX8ZAvodsPU37QFhQ+W7AFTH3F66adEFnlPROpbz6yAcDHQi1
        DX5VI4UnyCUcVfXtFSoD80czUVHSO8nKKsTzoHUsRAx2MoCIOu6ciA3IJO1wmo0I
        BJ4mHjhcb5SRp1VIAXhXqUNgCFBPVl2nsFw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MimyvGI1yydl for <linux-ide@vger.kernel.org>;
        Wed, 22 Jun 2022 16:45:15 -0700 (PDT)
Received: from [10.225.163.90] (unknown [10.225.163.90])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LT0P65FJ8z1RtVk;
        Wed, 22 Jun 2022 16:45:14 -0700 (PDT)
Message-ID: <2e7f96b6-2223-c687-a65b-6b90964bb4e1@opensource.wdc.com>
Date:   Thu, 23 Jun 2022 08:45:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-scsi: fix result type of ata_ioc32()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <05a7fcf4-3a2b-3012-34c6-ca1f00fa457c@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <05a7fcf4-3a2b-3012-34c6-ca1f00fa457c@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/23/22 05:57, Sergey Shtylyov wrote:
> While ata_ioc32() returns 'int', its result gets assigned to and compared
> with the 'unsigned long' variable 'val' in ata_sas_scsi_ioctl(), its only
> caller, which implies a problematic implicit cast -- fix that by returning
> 'bool' instead (actually, the object code doesn't seem to change, probably
> because the function is always inlined).

Looks good. I would though prefer to change this commit message to simply
say that ata_ioc32() return value is clearly a bool. The implicit cast to
unsigned long from int is not really an issue at all (the reverse cast
would be an issue). And keep mentioning that the object code does not change.

By the way, does your statis analyzer stop complaining after this change ?
Because we still have an implicit cast in the user site.

> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
> 
> Changes in version 2:
> - changed the result type of ata_ioc32() to 'bool', updating the 'return'
>   statements as well;
> - dropped "sloppy" from the patch subject;
> - added a note about the object code to the patch description;
> - changed * to ' in the patch description.
> 
>  drivers/ata/libata-scsi.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: libata/drivers/ata/libata-scsi.c
> ===================================================================
> --- libata.orig/drivers/ata/libata-scsi.c
> +++ libata/drivers/ata/libata-scsi.c
> @@ -539,13 +539,13 @@ int ata_task_ioctl(struct scsi_device *s
>  	return rc;
>  }
>  
> -static int ata_ioc32(struct ata_port *ap)
> +static bool ata_ioc32(struct ata_port *ap)
>  {
>  	if (ap->flags & ATA_FLAG_PIO_DMA)
> -		return 1;
> +		return true;
>  	if (ap->pflags & ATA_PFLAG_PIO32)
> -		return 1;
> -	return 0;
> +		return true;
> +	return false;
>  }
>  
>  /*


-- 
Damien Le Moal
Western Digital Research
