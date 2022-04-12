Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E79EC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 12 Apr 2022 00:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiDLAkA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDLAj7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 20:39:59 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F61929A
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649723863; x=1681259863;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=UkbpQaH9D7n8VJEkfQPCzGJm9hHUHs1R9i1MGD67+GQ=;
  b=PqbuVeApAWp99wf+NGuJD4puJmLpQxULVdpc9na0g3lyXqlg9UReR2Xj
   gvSfrGCGft+dNcOy41PFl6T+zP6sXCXgJOinegr9CQ8cf7oJBQ7qC5bec
   dEbWphRVClt12dd56/2x/JECxmQsl7SLI/jQPatoFSCMvWsH09B13+RCs
   fUQMb/1DvYI3OXbD/nVquP+U7SxJhJqzZARM0flqYd8+7QogaA8mJSdlO
   MMkOzAgvW6Cc5Yut+Utenqub8HaZKHoLucgp+RVpac+vNROa9YFJyH5l1
   Ho38+fKjtQgUuicWSmj9GpxKmxlLpZjFRoOw2vO3Nc4WWp9JhhmkYceyw
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,252,1643644800"; 
   d="scan'208";a="197678684"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 08:37:43 +0800
IronPort-SDR: ZXYVnl370uQzjSti4wzSePUZfP0f1ElNxpNZu7mERRbjO3n+DRZLmOUDL9OMHQVyq9UcNsJg1c
 xHWeGUdKm0vnps8iglRC8NtADE9gGF7vq4xTpu0aszevUziah/eVR0Vfa9OFRGRtHlZJAiM1tS
 2r7mp4gsu3xnB6HEgMLk6z41wL6HFRvSkZ5ghCG8busLLKdG+swa3kIH1VKOOm8IhTc57Bh5tS
 acwq4AIO1+1h2cxD+XdQX7jz/TC5JaiSQsA0/dFfjKwMDbJ3hbRlxbslpqDI6dfCHX/fdDtUIF
 ELyYic8nZoKViRUieNWm7M95
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 17:08:12 -0700
IronPort-SDR: LCPYl+q1mMTeJvTPAB/aXS4doKheUWjr69gcgaDc+Cke9L4Wn6+4xZGykxXj3XcqNMUCszWb9M
 qhQq7EIourXGEX7XL9W0zGNC0knsfHnzclYgbvAVcRhZyXBL68b4duJ5USNgAg48TRKTAudBtw
 wbiXCh4wDmOehBL1WB684BxALpkxTQCFJTTgmbM5uHMHnbW3zJfc+XH00pWTdjvTSMsei2gOfg
 BvO1kAY/ZhA2iiaVuQJCyUL7hYWel3zl16kHgexXnYjt2+2xn2SnfWOWR4hKitbcnCT+lt9BMx
 /NM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 17:37:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kcmyv19kWz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 17:37:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649723862; x=1652315863; bh=UkbpQaH9D7n8VJEkfQPCzGJm9hHUHs1R9i1
        MGD67+GQ=; b=pumDFwTIi+I/6aVMTP3VvbP3btps5n2j+/HhPh2zGvhVr3g3IrV
        Wd9sF4UM3+ks9BjjuMa2BVD5HGiDITkgD8FyCJjJY1bxj05QSuV/cmUjeAgSOgur
        mFakSO2erRnuDvhRDZmNvBvLs9RSWdkmMRedu36oMWVNmjKIHAMuuZVlXyxg9RDi
        RbZk5QQgjj1gvhxaNuIAKzfKFU4aX4MUHWHDqPA+fjBfkPNxL4H8hsm9JVmudMEy
        qBTsi8ySED6YxyG4RPnrhzIFlkA+3t7R5s2rYOpr3jk4uiwqBOjJBiNfqlGfwotT
        /LujKbYXCPEliHtkdTUWhRMXxltsJpWPNJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zPBOoCVBuTDR for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 17:37:42 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kcmyt394Dz1Rvlx;
        Mon, 11 Apr 2022 17:37:42 -0700 (PDT)
Message-ID: <cbed5ad9-7219-b811-fb4e-9ae34798e022@opensource.wdc.com>
Date:   Tue, 12 Apr 2022 09:37:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: libata-core: fix parameter type in
 ata_xfer_mode2shift()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e028feca-f049-c3e5-ac4c-ec071a4e2972@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e028feca-f049-c3e5-ac4c-ec071a4e2972@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/10/22 04:13, Sergey Shtylyov wrote:
> The data transfer mode that corresponds to the 'xfer_mode' parameter for
> ata_xfer_mode2shift() is a 8-bit *unsigned* value.  Using *unsigned long*
> to declare the parameter leads to a problematic implicit *int* to *unsigned
> long* cast and was most probably a result of a copy/paste mistake -- use
> the 'u8' type instead, as in ata_xfer_mode2mask()...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied to for-5.19. Thanks !


-- 
Damien Le Moal
Western Digital Research
