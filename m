Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E36D528
	for <linux-ide@vger.kernel.org>; Thu, 29 Feb 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244321; cv=none; b=OB243E7dtA380foLAKRsgZd6GJIAxlzBgKgdqSeqReycCYMUGq4jdWu4ZHT+C06a/IBJ/QmIaqZceBpmV3IcZbHKxvUey31zUGPSG3M0J4sykKtJxT3HNGmJb89Buv0SY5yS0eu6X2dDtTBW1oJbpol7uycLS7I7AhNm+ZDTeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244321; c=relaxed/simple;
	bh=5DbVUHySeDB9YEJSKPkg8srk8wvvGFrP3vfhRWS7FHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IClsM82r4RtQgp7X1kHiLSolm9oOaj2kCTi6MD06PJ33F76/5Dn0SNbMgo0GK6+Qtrpi7nxI3SKIs0YlwrQu9OOjbtt+OHHRBksEk5XnHqkBhbCPJAk7BpM4vYra+KlzGbncPdcGsealIVrf+Zqjl2B1NGxz+kExHxa3yByEDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com; spf=pass smtp.mailfrom=opensource.wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JgZ47PXi; dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b=PKgyndpq; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JgZ47PXi";
	dkim=pass (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.b="PKgyndpq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709244318; x=1740780318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5DbVUHySeDB9YEJSKPkg8srk8wvvGFrP3vfhRWS7FHE=;
  b=JgZ47PXi0eNmQfSt15QSH31v3VB+LfC7IVZQwGk+F3rbWqtnPSXGaiCT
   fUXm84WU0EpdvPhdcoCQ0+A7kp5QU/D2sUgjlTlrv+9tYmyccwceM+B6+
   jcwVzOx5dzkvAhi1Jr4JUS6uVVUZ1TXeG5OekCrXl6sh6ukd5XVZhRY9o
   3giTiWqRmDx4M9WfIm3syITn4EtzR5e2htX/jmn3H737t0MN84I52o5sI
   RA/C9jlT/lcuhp/Mdh+vBGeGvE0oyOlBFCFqJ93ivj9kpNoFrs68Col6Y
   2wfaUqcFRKEd4LImit47JRG0ZYi91vhjX0+pDLeF3c7gKD7qG+nZL+WvQ
   w==;
X-CSE-ConnectionGUID: akzXG9MpQ2+fAycrBIx5Cw==
X-CSE-MsgGUID: u9ozvTT5SY2wuvGGIBft8w==
X-IronPort-AV: E=Sophos;i="6.06,194,1705334400"; 
   d="scan'208";a="10764781"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2024 06:05:12 +0800
IronPort-SDR: 6ZKA9IO9Ck1xKAdGYMJueZwXl2+b2w0NNr0bao5MG98yBfHBj/3L5Fv3al2L59pq5hGhxCHFYv
 gIRsEWhbIZqA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 13:14:28 -0800
IronPort-SDR: TcYSiqCngzmvvGW5kF0I90S6D3ace7rFTnN+/YLkOEdeT3Nq2uf5qeNjqIONJBFvu9wnw/hH4A
 lzQ0JOSrR4Vg==
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 14:05:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Tm4yv6J1Gz1RtVN
	for <linux-ide@vger.kernel.org>; Thu, 29 Feb 2024 14:05:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1709244297; x=1711836298; bh=5DbVUHySeDB9YEJSKPkg8srk8wvvGFrP3vf
	hRWS7FHE=; b=PKgyndpqPaoVtbkHJHnNngynZ8i3Cnbj5CubPIpPguFVaxaW79b
	yfdudKrjmX+iQfkitUX5H3wrJCm41H+wcM2lYznfLBNqQQOFifBIlGT7nm5nEWAa
	ki9w4jIlxp1ETlzaZYoVCbgId94JOJmmabmJrsKwQcoCq546jsU/vZYNV9cainvs
	LUOb6SefCZoP39xsxJwjILrSEn6v3APatlMJggXzRpdqnRfROt2BebEPvUThewa5
	EgZKie41VUPR+7xpclyRTdLCmFz65+YJdZ4+9ChnP1x4+5C00UAt6IgnQxbSouHa
	faAg0EbwbEK6zbheCI5MHUIMChadcMv51cA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vfcf882kXvit for <linux-ide@vger.kernel.org>;
	Thu, 29 Feb 2024 14:04:57 -0800 (PST)
Received: from [10.111.69.9] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.69.9])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Tm4yc5T89z1RtVG;
	Thu, 29 Feb 2024 14:04:56 -0800 (PST)
Message-ID: <18490fc9-7fda-41ee-803a-bda874c2b42d@opensource.wdc.com>
Date: Thu, 29 Feb 2024 14:04:56 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipr: Remove SATA support
Content-Language: en-US
To: Elektrokinesis DJ <cpubuilder2@gmail.com>, brking@linux.vnet.ibm.com,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: jejb@linux.ibm.com, john.g.garry@oracle.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, wenxiong@linux.ibm.com,
 Niklas Cassel <cassel@kernel.org>
References: <CABa-fKRfE8B2TLVJASB9xQaOXDiYH3YCw0YEEg1UcGu2Le8xWw@mail.gmail.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CABa-fKRfE8B2TLVJASB9xQaOXDiYH3YCw0YEEg1UcGu2Le8xWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/29 9:31, Elektrokinesis DJ wrote:
> I am dissatisfied with the decision to remove SATA from the ipr driver, I
> have multiple machines in my homelab that now require manual patching every
> time I would like to update the kernel and initrd image. Bladecenter PS700
> uses the ipr SCSI driver if you install a common SATA SSD into the Planar
> SAS slots. This limits me from being able to use newer kernels without
> patching, unless I would like to procure expensive SAS SSDs.

The ipr driver was the only libsas/ATA driver that had not been converted to the
new libata error handling, and was thus preventing necessary cleanups in libata.
When it was removed, it seemed that no-one was using ATA devices with IPR beside
SATA DVDs, and very few people had this hardware to test anything.

So it seems that devices beside DVDs were/are actually used.

We can try to reintroduce the support for ATA in ipr, but that will not be a
simple revert as the new EH handling needs to be supported.

Brian,

Any comment ? Is this feasible ?
I do not have the hardware to work on this, so patches will have to be done by
you or someone with access.

-- 
Damien Le Moal
Western Digital Research

