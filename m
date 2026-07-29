Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9E175A6D;
	Wed, 29 Jul 2026 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368550; cv=none; b=Biy09HAVnlf122c4Dq/77TCex4nihnB4LTQs9vcWtz1hPRbaqs0XzQno2pPSWiig0Rk7XnmY50IQNa6PzwDq2wsNXJssJsogT//d9OF7ji+HR5rZyzNZq52qT4Be3STF0MU3D1OrSXdWWBHHmz+QiHF8tyMeypMFhEY65ICozhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368550; c=relaxed/simple;
	bh=uN3pN/wYlQBP5r7DHmdZmCnElfzxd8hfPeb1Dmf+QBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHqAfCsYRbDkCCyzIsE2X7sxjeMAwo9CtFOZYtQNzhmBbsVFcMW7jBN6s/0mlgo+PaX8eUVdB5ejX0lgO2NqdkG92lZrE7uJCHYrt4dYsZjrNokHl/+z+A2XoemqSQIRcdqYnMf6cvbYfQqRDvI35UDQwXBpeJfy5QLGnUkuI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRqRxaZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRqRxaZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6119E1F000E9;
	Wed, 29 Jul 2026 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785368548;
	bh=e5pinI4HjAAifd0Bo2rB77efx+tt0GIB4tRcFWSgXts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZRqRxaZ+bQUdKyso+/AafcLF1QWGrKX2owQ8iDzQhfox1Okm97O3oTxX6hVKAoeJO
	 au+pkXIGLA5ai06kntSSTt+RqO9azRah/zslnLk0NGNGomdHa44cs83RnYR8srJT/C
	 Sl5au2ewI4HPG0dZ0QDdCZbaEkVIzIPFEzjwlWNXzMiCb7SKEjn9KP86eJOuRG9CCg
	 uSWI8n5LiKa2R4NO3Nd0j/30WjYKRHi619cBgqNH+Q7md/yDgy/RE0zzCIqpjDAZYb
	 1MRWW56wnG2kUuiItb5YXmGC1ZU4y+OvIRqBmS0TGZyOwYptpaK7k9g4U7L44VAMKM
	 YajlU05BK3JeQ==
Message-ID: <683be1d4-5df2-4426-b5c2-be217758fccf@kernel.org>
Date: Thu, 30 Jul 2026 08:42:25 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_parport: Fix use-after-free in new_device_store
To: Pei Xiao <xiaopei01@kylinos.cn>, cassel@kernel.org, linux@zary.sk,
 axboe@kernel.dk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shuangpeng.kernel@gmail.com
References: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 21:27, Pei Xiao wrote:
> The function new_device_store() calls driver_find() without any
> protection against concurrent driver unregistration. This can lead
> to a use-after-free (UAF) when a driver is unloaded (via rmmod)
> in parallel with a new device addition via sysfs.
> 
> The race window exists because driver_find() returns a pointer to
> the driver's private data, but does not increase its reference
> count. The caller is responsible for ensuring the driver remains
> valid, but new_device_store() did not hold any lock or reference
> during the lookup and subsequent use.
> 
> Concurrently, pata_parport_unregister_driver() releases the
> pi_mutex before calling driver_unregister(), allowing new_device_store
> to proceed with a stale pointer after the driver has been freed.
> 
> Fix this by expanding the critical section protected by pi_mutex
> in both functions:
> 
> - In new_device_store(): acquire pi_mutex before calling driver_find(),
>   and keep it held until all uses of the found driver pointer are
>   completed.
> - In pata_parport_unregister_driver(): hold pi_mutex throughout the
>   entire unregistration process, including the driver_unregister()
>   call, so that no concurrent lookup can see a partially removed
>   driver.
> 
> Thread A (new_device_store)       | Thread B (pata_parport_unregister_driver)
>   driver_find("aten")             |
>                                   |   mutex_lock(&pi_mutex)
>                                   |   idr_remove(&protocols, id)
>                                   |   mutex_unlock(&pi_mutex)
>                                   |   driver_unregister(&pr->driver)
>                                   |   (frees driver_private)
>   /* continues using stale driv */|
>   -> UAF!                         |
> 
> Logs:
> BUG: KASAN: slab-use-after-free in driver_find+0xd0/0xd4
> Read of size 8 at addr ffffff9f970dc690 by task sh/4737
> Call trace:
>  show_stack+0x14/0x1c (C)
>  dump_stack_lvl+0x70/0x84
>  print_report+0xf4/0x5a4
>  kasan_report+0xa0/0xe4
>  __asan_report_load8_noabort+0x18/0x20
>  driver_find+0xd0/0xd4
>  new_device_store+0x140/0x30c [pata_parport]
>  bus_attr_store+0x5c/0x94
>  sysfs_kf_write+0x1c4/0x25c
>  ...
> 
> Allocated by task 4734:
>  kasan_save_stack+0x28/0x4c
>  kasan_save_track+0x1c/0x34
>  kasan_save_alloc_info+0x3c/0x4c
>  __kasan_kmalloc+0x98/0xac
>  __kmalloc_cache_noprof+0x158/0x3cc
>  bus_add_driver+0x70/0x4d8
>  driver_register+0xf0/0x3b0
>  pata_parport_register_driver+0xb8/0x1c4 [pata_parport]
>  0xffffffc07f5ce014
>  do_one_initcall+0xb8/0x36c
>  do_init_module+0x230/0x6d4
>  ...
> 
> Freed by task 4737:
>  kasan_save_stack+0x28/0x4c
>  kasan_save_track+0x1c/0x34
>  kasan_save_free_info+0x48/0x8c
>  __kasan_slab_free+0x5c/0x84
>  kfree+0x174/0x3e0
>  driver_release+0x1c/0x7c
>  kobject_put+0x178/0x47c
>  driver_find+0x78/0xd4
>  new_device_store+0x140/0x30c [pata_parport]
>  bus_attr_store+0x5c/0x94
>  sysfs_kf_write+0x1c4/0x25c
>  ...
> 
> Fixes: 72f2b0b21850 ("drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport")
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> Closes: https://lore.kernel.org/lkml/20260728024015.2014674-1-shuangpeng.kernel@gmail.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index 40baeac594a9..34f09192a419 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -3,6 +3,7 @@
>   * Copyright 2023 Ondrej Zary
>   * based on paride.c by Grant R. Guenther <grant@torque.net>
>   */
> +#include <linux/cleanup.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/parport.h>
> @@ -618,8 +619,9 @@ void pata_parport_unregister_driver(struct pi_protocol *pr)
>  			break;
>  	}
>  	idr_remove(&protocols, id);
> -	mutex_unlock(&pi_mutex);
>  	driver_unregister(&pr->driver);
> +	mutex_unlock(&pi_mutex);

Sashiko had a comment about this that I think is very valid: if rmmod is
executed with devices attached, what happens here?
This entire driver seems to be lacking reference counting on the
modules/drivers, so this all seems very fragile.

> +
>  }
>  EXPORT_SYMBOL_GPL(pata_parport_unregister_driver);
>  
> @@ -646,6 +648,7 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
>  		port_wanted = -1;
>  	}
>  
> +	guard(mutex)(&pi_mutex);

Please no. We do not use these annotations anywhere in libata and I personally
consider anything that hides code a *bad* idea. So just move the mutex_lock()
call here and add the missing mutex_unlock() in the !drv case below.

>  	drv = driver_find(protocol, &pata_parport_bus_type);
>  	if (!drv) {
>  		if (strcmp(protocol, "auto")) {
> @@ -656,15 +659,12 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
>  	} else {
>  		pr_wanted = container_of(drv, struct pi_protocol, driver);
>  	}
> -
> -	mutex_lock(&pi_mutex);
>  	/* walk all parports */
>  	idr_for_each_entry(&parport_list, parport, port_num) {
>  		if (port_num == port_wanted || port_wanted == -1) {
>  			parport = parport_find_number(port_num);
>  			if (!parport) {
>  				pr_err("no such port %s\n", port);
> -				mutex_unlock(&pi_mutex);
>  				return -ENODEV;
>  			}
>  			/* walk all protocols */
> @@ -677,7 +677,6 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
>  			parport_put_port(parport);
>  		}
>  	}
> -	mutex_unlock(&pi_mutex);
>  	if (!ok)
>  		return -ENODEV;
>  


-- 
Damien Le Moal
Western Digital Research
