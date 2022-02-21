Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475DC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 21 Feb 2022 00:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiBUAHg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Feb 2022 19:07:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiBUAHf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Feb 2022 19:07:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F91B41F99
        for <linux-ide@vger.kernel.org>; Sun, 20 Feb 2022 16:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645402033; x=1676938033;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=bU/UCegiWu6YJuqZ+Yd/bUqj+DSrm0dBOd9zKEjqMTY=;
  b=NlQrN/92cKnq1TMwL2LQLIVnrJjo3AqIrksCKG4n4LtbZ3YAnF9dW/Gm
   5J2PkGrKsRmyWISM13O5G/eAE/V2zBBNE+9bKzSH/gque/YkwjL956unK
   i9zp8KoUq7hPZRSuB8O/jYfdYYLOPbd9a08/2W0PFjS5UB4ySMtcvtjaQ
   ri4/n3a4J+PgihdV3EMk9V4CieKGSjUg7KI//nHVNnkUKc3+e/qLFhSp/
   kcM3jQLTsI2lFogrX3xV1D/M+ZbsCSbPKSG+Lqgy3udPgAO0XFJ37WoTm
   GDk1V7aMa9uSP9XnFQgYXdAkgq7WimLN/S92KIANV+P5y03nROLAMSOuS
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,384,1635177600"; 
   d="scan'208";a="193474636"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2022 08:07:12 +0800
IronPort-SDR: eqswJHXKpioiiJ6fF7TXGL8C15I09frIV3HBNTnK7GOJNL+YfAr6kX6Fa1i7eCWykeD9MJ1c3s
 TFb4o5WZvpxPk3+tIn3uoATLuC/ej2lRe+CIApQT1p1XozQXLSrCgyh1lu5enungHnW2JtfcmY
 w0adSEfxc2ORxIHHSiIu4NDU9QiyO+Oq8trhc1zCs7phWo569X0m18+1CwjedYQnAKnKvuoe+7
 D3N6N4wE7oN4T6nVAhwC01zDdASju9Skt5SlQ3/mLd/fEZhZwcr3IuQ7uymKVdo9ltgRBCE9Gw
 ivzT7VOccLxLs5h4OztLCdnm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:38:47 -0800
IronPort-SDR: 6qVG+T5VNRuBR9VZOFtsPiCTs3igRNolbkY7MGGNY0oWaFeI5SIU/7BhB5XR+qT8WhFmNsxxWA
 BaHu6l4cjqRE27TZwpxLtXUCnBljXo0waJrijFtzT22rv2IRc5zwZIQlrjW+hSxeDVnvg9KC9B
 rJqdc92LACQVmHC9n1eZefnEZuxUPZNwvb+t/xtR0+BJ9WSutm9eNh6LOHxqVLdYF5IjizkdFs
 xhsIh2Dgk3fpk42zNR13tZydohGViXmcdCoRJ2+bHvcZY6o8Lecv4XQmZXQFFTi584/c0tw3/L
 uDk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 16:07:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K22fm4mFrz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun, 20 Feb 2022 16:07:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645402032; x=1647994033; bh=bU/UCegiWu6YJuqZ+Yd/bUqj+DSrm0dBOd9
        zKEjqMTY=; b=nGUZGoE5/FQR6FIw/au07kp+06sTRHo1viK5Chb8P95D3c/e2M4
        351+Xz8KtrXu4e2f5hn33pQ3OLTEBaJcQBF8CoLrEx9gdVWZikZa7FXsHsR+oI5P
        3zQ6vZAtzzBXKS5xoi15zlRQ/tJ5Hv9gSqCnneFsRVeoeG5X9Y3mm+ASXDILhbqi
        lEz3OUTFbidTdI/y7+f8iRMiyBRd3mXKNv9ICczkYmYK1R4idKjqlVTTkV9at552
        cyrg4vTrmw8qbZYP+IVMINxG2QEIHCQtAHhEouA6mv4guwaSIhKs8m2ORkOzE9+p
        t8ff3cBkzOcEFMJSeAeZncKnrtFhL2CijUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ft89A4Fx5v5T for <linux-ide@vger.kernel.org>;
        Sun, 20 Feb 2022 16:07:12 -0800 (PST)
Received: from [10.89.87.236] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.87.236])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K22fm0Mbpz1Rvlx;
        Sun, 20 Feb 2022 16:07:11 -0800 (PST)
Message-ID: <7f105813-2fe6-5dbb-bd83-5c4c8d42d716@opensource.wdc.com>
Date:   Mon, 21 Feb 2022 09:07:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] ata: pata_hpt37x: fix PCI clock detection
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <02715925-4a0f-30dd-86b8-85786cf6484a@omp.ru>
 <f37abf49-e11d-f9d7-f247-f296213100ff@opensource.wdc.com>
 <f8df20fe-5219-540a-e3ab-952345662cf9@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f8df20fe-5219-540a-e3ab-952345662cf9@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/02/20 18:20, Sergey Shtylyov wrote:
> On 2/20/22 9:44 AM, Damien Le Moal wrote:
> 
>>> The f_CNT register (at the PCI config. address 0x78) is 16-bit, not 8-bit!
>>> The bug was there from the very srart... :-(
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Cc: stable@vger.kernel.org
>>
>> Any Fixes tag possible with this one ? I have not checked what "git
>> blame" says...
> 
>    As I said, it was there from the very start, so should be:
> 
> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")
> 
> [...]
> 
> MBR, Sergey

OK. Will add that.

-- 
Damien Le Moal
Western Digital Research
