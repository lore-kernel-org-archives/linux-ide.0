Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426B23D7
	for <linux-ide@vger.kernel.org>; Thu,  3 Oct 2024 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938885; cv=none; b=Ruu77vZyuSfQDjmEJa6+p+iAIpUa6dAbJmFdVJ2misouJhLVNCmVvOc3BB+mUsFpW2YUsLz/yj97JbD+kQo6vEITjg+fvb78+lB8eYOggFqKDd2wvB7B8hRZS7dz3q+RbUn/YrkFGTovgdYP7/51En7lOCYLiRJnEny7YqsSiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938885; c=relaxed/simple;
	bh=ArbjUydtmGlo5b1ehyfK+5eOMTPBVWa9ApNJGz3Qu5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBaSap2GUGL3VxEVIRiBlgl8D6axQ+mR0Z/xU2ogletDUHh1sZr4s7yqawbP2OBh6VpkdTm2oFUVHTHGRFIq+XlVDnViVH/Y+q5MdrCiilOWZQPQP1KGTl2oiP67FufuiYGdQ1MdNquq7BtBnIf6oajpBdcy9VPONGcxw7NVn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk5867Lj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk5867Lj"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c882864d3aso499584a12.2
        for <linux-ide@vger.kernel.org>; Thu, 03 Oct 2024 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727938882; x=1728543682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeFU/LyDTmhZuy175QMgG/UWC/hjLY8mwcwo3xYsGbw=;
        b=jk5867LjpkGh0JuShRgh5AOwP1QuBddnXEeu6VRD8HwjgXuMxjR2Q7uziQgmx/z4Ca
         qqcTyvR7MgtCZoKoSoJzkg+5rTS4oW0p/TjSJli+K9UyxHbW3h6nFhLdF7kN7q4+jeGB
         TC29dRnp9vuaSIfjlyeh2/0GGR8H16WN2eMo/iHWuli4m3gHKTmGVA4TFHk2ENIzcLHO
         UuolRH03O9tEq/1bmQCgENQJUhhlH+D0LuW0+CGFa/7D3UIJPdPQDsj2gJgSTpFbkdg/
         7J3E3xD/Xnm4JwjkkvWSNZk+MCas+FNO/pjNOk7kgflSTKUJTT4+Uky0s4dIYizu9uhp
         3TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938882; x=1728543682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeFU/LyDTmhZuy175QMgG/UWC/hjLY8mwcwo3xYsGbw=;
        b=oEnspVT/zx0pN03TMeHI70Z0YPbIzfx1xYRn/xqKhRgUZfe6nwnZxGfmjvYQKDyYDn
         HFSqKGeIJvFK+xFsEKbKERNiQZCVWjkbPmE30vwir1mZo4M7n0bUpL/9NbphaxfvnTNZ
         PMDmi79L1PxgTNjVaVCyE7nvHj1/3mrkMvpuNl8Seuw7gemQfKoFvNrYpU45GyXzpiS7
         QN6QDgoGd9A7gcd9dmKdyhKInHY3SCDqpZT5Sq5LD9orvTWldyIbRQ48DEcpZSGHbpZF
         WbTYqTawv9RNcyTNav6IhJgynldPqT92YcToqSDSWNfJ3wM29QkY0zV265VsUyYdklRN
         OyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWm3cokH4/6GC4kHH+1XE5aZh5uPns/KHZ0LC8g/oriqp0oTCBsm0EyrWZiQa8PbT0ELJl2lw6vWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvlAYQHivvvFAdilwGlUZIKSXABpn/9OHHFKV0hlGoOJhVlUdu
	OnsZ9THFNLQiEUOzIn3jYY6Y7EWGvHtRJzMy4X0EvICM62U9IUxZ0jF40aFK
X-Google-Smtp-Source: AGHT+IER3VyW3n6ywREaiId2g3zAK8SXUqTp9Fta4Nf0MTIrzOUDcBEsds5SS13sKcJoxzc3Tta5gg==
X-Received: by 2002:a17:907:3e1c:b0:a8d:caa:7ffb with SMTP id a640c23a62f3a-a98f82618f9mr481463566b.29.1727938881654;
        Thu, 03 Oct 2024 00:01:21 -0700 (PDT)
Received: from [192.168.1.64] ([91.231.32.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9910473a94sm41072866b.169.2024.10.03.00.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 00:01:21 -0700 (PDT)
Message-ID: <389d8a20-835e-4541-892a-ea9ffa59d320@gmail.com>
Date: Thu, 3 Oct 2024 09:01:19 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: libahci driver and power switching HDD on newer kernels
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-ide@vger.kernel.org
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
 <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
 <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
 <a0c34406-3bb3-4880-9513-0876aacd4de6@gmail.com> <Zv25MQWh-1yYAcVC@ryzen.lan>
From: W <linuxcdeveloper@gmail.com>
In-Reply-To: <Zv25MQWh-1yYAcVC@ryzen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 2.10.2024 o 11:20 PM, Niklas Cassel pisze:
> On Tue, Sep 24, 2024 at 12:42:10PM +0200, W wrote:
>>>
>>> Given that you had 6.4.12 working OK, it is likely some commit that introduced a
>>> regression. If you can git bisect it, we will have a better idea how to remove
>>> the regression.
>>
>> Please take a look at bugzilla report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=219296 - there are the details.
>>
>> I'm wondering what is the better way for communication - here on mailing
>> list or put the comments in bugzilla ticket?
>> Probably here will be better idea...
>>
>> W
>>
> 
> Hello W,
> 
> Could you please try the following patch,
> and see if it helps:
> 
> 
>  From dba01b7d68fffc26f3abf3252296082311a767a0 Mon Sep 17 00:00:00 2001
> From: Niklas Cassel <cassel@kernel.org>
> Date: Wed, 2 Oct 2024 21:40:41 +0200
> Subject: [PATCH] ata: libata: do not spin down disk on PM event freeze
> 
> Currently, ata_eh_handle_port_suspend() will return early if
> ATA_PFLAG_PM_PENDING is not set, or if the PM event has flag
> PM_EVENT_RESUME set.
> 
> This means that the following PM callbacks:
> .suspend = ata_port_pm_suspend,
> .freeze = ata_port_pm_freeze,
> .poweroff = ata_port_pm_poweroff,
> .runtime_suspend = ata_port_runtime_suspend,
> will actually make ata_eh_handle_port_suspend() perform some work.
> 
> ata_eh_handle_port_suspend() will spin down the disks (by calling
> ata_dev_power_set_standby()), regardless of the PM event.
> 
> Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
> explicitly mentions that .freeze() does not have to be put the device in
> a low-power state, and actually recommends not doing so. Thus, let's not
> spin down the disk for the .freeze() callback. (The disk will instead be
> spun down during the succeeding .poweroff() callback.)
> 
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-eh.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3f0144e7dc80..45a0d9af2d54 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
>   
>          WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
>   
> -       /* Set all devices attached to the port in standby mode */
> -       ata_for_each_link(link, ap, HOST_FIRST) {
> -               ata_for_each_dev(dev, link, ENABLED)
> -                       ata_dev_power_set_standby(dev);
> +       /*
> +        * We will reach this point for all of the PM events:
> +        * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
> +        * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
> +        *
> +        * We do not want to perform disk spin down for PM_EVENT_FREEZE.
> +        * (Spin down will be performed by the succeeding PM_EVENT_HIBERNATE.)
> +        */
> +       if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {
> +               /* Set all devices attached to the port in standby mode */
> +               ata_for_each_link(link, ap, HOST_FIRST) {
> +                       ata_for_each_dev(dev, link, ENABLED)
> +                               ata_dev_power_set_standby(dev);
> +               }
>          }
>   
>          /*

Hi Niklas, Damien and others,

Niklas I applied your patch on:
commit 9852d85ec9d492ebef56dc5f229416c925758edc (tag: v6.12-rc1)
and gave it a try.

I have done 2 cycles of hibernate/wake_up and in both cases it worked 
fine so the HDD is not powered off and then powered on.

W

