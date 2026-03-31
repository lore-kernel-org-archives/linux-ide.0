Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531419D074
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921715; cv=none; b=aWx1hxKXuy39GxmKiHtmqw7gIUj4INTCbsPGYf0ZZhhWA7soySf3NxVtcp6SYiR4uxusHryVNu1eP6vxdWr8U3qSu++cbUfom9q26zC9EhtR36AgIzVWcZSHAX8ky7OrAEu8sXR0NKCm/XzkR6kVNLYomt/YtIOyXlK4sTJpwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921715; c=relaxed/simple;
	bh=k11O9TBCZDHoC0QF1fRme0zRRa+ofm8imsr+xWHwYhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB78BIJOG8kaW/irDYw3GQ99yHEslvX2hNVKgdDVRJqN1XSeZgToN1lQ1RT1m1GBsmc0RMD5iY2UUEh6Z8jnqanR9oKdKr/8TbzNhLVuDX/Jdx+pghs7UfW5cAZIOxeMxKl3n1UYxOyMgN7DSDy1vGI1sIRZ2Nr+AthvAKzvY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS32gryc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS32gryc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF3C4CEF7;
	Tue, 31 Mar 2026 01:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774921715;
	bh=k11O9TBCZDHoC0QF1fRme0zRRa+ofm8imsr+xWHwYhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qS32gryca3Leuo/d92lrfp1QUkE9wuDGd+DyH5Nd/BTSPQ+UnuS56hVdws9AnJczc
	 lnRqrEbn79vGlXCv6NtHPSIkYOiUM9iEHQu4jekreIEC2hcFg2WFQeUo5Ne7QsHWXR
	 kv3TmMx7a9baV86Bg270vWWRgKK0hLUghPR0ZWEtI2shjpTVMOgKlS68gdSa/btgS7
	 HKaBwrSfG71XmBc4fIuMqnQC/jvk7rxxtrxyEngry8jjh74HLafEKqx42dJIqimaWs
	 r1NkdUoCY0pI/VapNIlX4iGnP+zn4TuV1jpPlcXuF6DiiL6KYCZJXFITWfzuCdObyN
	 1VvIhYZiwGLRA==
Message-ID: <6a02ae15-bc91-4a4d-be2d-87e311584ba5@kernel.org>
Date: Tue, 31 Mar 2026 10:42:36 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ata: libata-transport: remove static variable
 ata_scsi_transport_template
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c23f827a-2ff9-4a6d-afcb-fce83fda4899@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 12:21 AM, Heiner Kallweit wrote:
> Simplify the code by making struct ata_scsi_transportt public, instead
> of using separate variable ata_scsi_transport_template.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

One nit below. With that fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> diff --git a/drivers/ata/libata-transport.h b/drivers/ata/libata-transport.h
> index fe5ca66fc..629ac843a 100644
> --- a/drivers/ata/libata-transport.h
> +++ b/drivers/ata/libata-transport.h
> @@ -3,7 +3,7 @@
>  #define _LIBATA_TRANSPORT_H
>  
>  
> -extern struct scsi_transport_template *ata_scsi_transport_template;
> +extern struct scsi_transport_template ata_scsi_transportt;

Drop the extern please.

>  
>  int ata_tlink_add(struct ata_link *link);
>  void ata_tlink_delete(struct ata_link *link);


-- 
Damien Le Moal
Western Digital Research
