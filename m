Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096532B104
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213297; cv=none; b=F3oZtAlYwCwNMja4EdU3F0hmc7msB+eeU+A3zth3GCrzTjM+1mxHiRZOHoeEGTCJZ4oOo7b6AzGn2ecxywfc6YJdsFCz80Y/s4rANcZTP4zSXalxvWktTKFKVOC6cqLEo2FT+xKFCfDtXC+feMcerBFhnBhcHRkYINC0YTnHNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213297; c=relaxed/simple;
	bh=2HiYNHtpiwlinYwZBZ63IDQmUuz5sT2+8WRsib4kRxs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kvAmycdVYSE8kuIcqwesmyc5AasBSOBdLKbd+90zFfNZ8xPcquEl1xoGjnKfVqKpP7D2UDXh4CCZ1bUOn4fXmqk/m/VPgUkeAK4CvyWjcIYeShqzy7+IlIhq91hwgJm6FuKD+2AMzOxkHyHlY+z3WTeo5O4/9r6A/Hwn9vW+dKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGvD97ST; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGvD97ST"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c04bf4711so33512561cf.2
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2026 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785213294; x=1785818094; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tMss1/FThSbWch9e3kOJre78IjoToX7pWehfwkR1FMY=;
        b=pGvD97STYryWFORXZcFmtfY87a1WXj6kXjud6Sf0rFfujvO6vZTM+qHygdLV7Levd2
         fNVoWTwGAwSN4kiu27zPCJKv6TTqIvj6SfUYpLSCXGNX87ZvxZp5fom3r2ohMJ1MkdG8
         N2oRmwqyldMlbGbmfSJ4M0PM2yS99TJuFGqaqFazwm0pdKHElexuby6dbDpQ/oag2xYh
         EbWedgHHk1sW6ncgeBs2KSJ/4G7+1ETB8oZY/PPnZJ/iNadBBKbQscNTJCKtP0Kvc9PF
         JEV7ugu045o7JHXWu7bp+x5pt/VyAjsoOtUZb0axh8TaKqdW/9SRDDQzBJah2bPC46u9
         3akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785213294; x=1785818094;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMss1/FThSbWch9e3kOJre78IjoToX7pWehfwkR1FMY=;
        b=WwkbztWtkfJ4LnXQLO5Y1JJ8dcL4K3SXosF/Rx7yMZ0kMuSehecTFuqzmVEqSuZ90v
         DZrvuvJcRnMShPxYI6XsDhLmvINfso0/xrF563KYr/ZdfMbBtheDKX0I5EOL/IbFMaXP
         bVKFoJqu7rk4dv0P+v1VB+iw1xH+pl/OBtrPhaToCsC0SY/HMWSAQEMEH1eGWdGqK4+e
         FMS4ELvCm3M+kNsFlxf+wl/I5hw6iA8WPiax9/VlYEUHpM59SsS9kInm+3pC3ZiHQM10
         /RCtMo+OiEBJMSXqDfv8GOv+h1fIyNWI7UCe7h0N77lRN0eOZ3iU5J4ahjYDJ98RAaoh
         VUXg==
X-Forwarded-Encrypted: i=1; AHgh+RoKjtcrsEwgc9w6hSCwum9aWiiYW3QlIvl0I6h7jcsCvw2J23qRmwFqonnMN/MQdGKjDV7gnjnW6dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ybhDwbwK+RB1aPAKTixC4hbeGivhifBqdXQFTM6E68CDcnR/
	gMoboGU+Atzy6Ya/I0HBy7sEmBzKiHdiB8aDDBjIGw6w/aflg8fcs7xZ
X-Gm-Gg: AR+sD102VdMOdt+rTQsZWA7aTNJGtDKcOTN/slo0DYuxVhIR94gYqiP0SxYFeIOE3TE
	bb8/serq6RVlcNlMgOvM0UPF/BHlVDTpUlAuuyvUtJhyCMaln9ljT2qZakacu9pF5C/ecsymtV9
	L9tO0RtGYi1BNgqrOPLPEAReEZHo0PGaw4Wjb9FG8PQtCsc96tA3q/dn/mRL8a1BiXEuIbqusux
	o8a76ZnSadveYk+s+EBPK0CmTjPgdvLwl0zfjjRu3QeOUEYAS6es9qoYf2kterszulZ5qkFbQ+t
	HB7kSNVVIQVvHJiUc7UYDty+4BiyrWu4qAUqVZRlmfJ+TlzmURu21B9/wJBR8+34yLYLnLP43C+
	8i+veTuaApg22B0g3L51QAA4dRguqmbdoaf5i3fPVqbyx2jxBUm9E/w/NTO1Z2Ha79LAH3Dc0g4
	mhKYaDQzCZDrTVDPMFl3tRe6y1ucN1uiVHlCytnUoD87Ga
X-Received: by 2002:ac8:5a54:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-529d6fe2b59mr6700361cf.28.1785213294536;
        Mon, 27 Jul 2026 21:34:54 -0700 (PDT)
Received: from smtpclient.apple ([2600:1016:b128:d40f:1075:1a29:112c:4cb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a29d13c5sm68044881cf.22.2026.07.27.21.34.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 21:34:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] ata: pata_parport: KASAN slab-use-after-free in driver_find
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <b6018f00-020a-46eb-b74f-2b0f42019fff@kernel.org>
Date: Tue, 28 Jul 2026 00:34:23 -0400
Cc: Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <69B390E9-F5AA-4B22-AF50-070612603F51@gmail.com>
References: <20260728024015.2014674-1-shuangpeng.kernel@gmail.com>
 <b6018f00-020a-46eb-b74f-2b0f42019fff@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jul 27, 2026, at 23:01, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> On 7/28/26 11:40, Shuangpeng Bai wrote:
>> Hi Kernel Maintainers,
>>=20
>> I hit the following report while testing current upstream kernel:
>>=20
>> KASAN: slab-use-after-free in driver_find
>>=20
>> on commit: 62efbc768363bc7bb00f0915ad265f34b40d414e (2026-07-27)
>>=20
>> To help trigger the bug more reliably, we applied a minimal =
diagnostic patch
>> that only adds a delay.
>=20
> Can you share that patch/diff? That would make it easier to figure out =
where the
> race is because you are not describing anything here. The stack trace =
helps, but
> without being able to reproduce (I do not have the hardware), this =
will be hard
> to fix.
>=20
>> The reproducer and .config files are here.
>> =
https://gist.github.com/shuangpengbai/a8a1b5339bc41944c2f80d9f87e01a7e
>=20
> This site has a broken certificate and Firefox does not want (rightly =
so) to get
> me there. So not touching this.
>=20


Hi Damien,

Here are the reproducer details.

The diagnostic patch I used only widens the race window:

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d17bd91490ee..eb9dfbdd2aec 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
@@ -1421,6 +1422,8 @@ struct device_driver *driver_find(const char =
*name, const struct bus_type *bus)
 		return NULL;

 	priv =3D to_driver(k);
+	if (!strcmp(name, "aten"))
+		msleep(200);

 	/* Drop reference added by kset_find_obj() */
 	kobject_put(k);

I reproduced this in QEMU, without parallel IDE hardware, using:

  CONFIG_PARPORT_PC=3Dy
  CONFIG_PATA_PARPORT=3Dy
  CONFIG_PATA_PARPORT_ATEN=3Dm
  CONFIG_KASAN=3Dy
  CONFIG_DEBUG_KOBJECT_RELEASE=3Dn

Then boot the kernel, make the in-tree ATEN protocol module available in =
the
guest, and run:

  rmmod aten 2>/dev/null || true
  insmod ./aten.ko

  (
      echo "auto aten 0 0 0" > /sys/bus/pata_parport/new_device
  ) &

  sleep 0.03
  rmmod aten

With the delay above, this reliably triggers:

  KASAN: slab-use-after-free in driver_find

The relevant contract is the comment above driver_find(): it does not =
prevent
the returned driver from being unregistered or unloaded while the caller =
uses
it, and the caller is responsible for preventing that. In this case,
new_device_store() calls driver_find() before taking pi_mutex, while
pata_parport_unregister_driver() can remove the protocol and then =
unregister
the driver concurrently.

Thanks,
Shuangpeng

>>=20
>> I'm happy to test debug patches or provide additional information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>=20
>> [  755.753286][ T8297] BUG: KASAN: slab-use-after-free in driver_find =
(drivers/base/bus.c:1430)
>> [  755.754175][ T8297] Read of size 8 at addr ffff88812200f490 by =
task repro.sh/8297
>> [  755.755320][ T8297] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+ PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [  755.755331][ T8297] Call Trace:
>> [  755.755341][ T8297]  <TASK>
>> [  755.755344][ T8297]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
>> [  755.755393][ T8297]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
>> [  755.755478][ T8297]  kasan_report (mm/kasan/report.c:595)
>> [  755.755487][ T8297]  driver_find (drivers/base/bus.c:1430)
>> [  755.755502][ T8297]  new_device_store =
(drivers/ata/pata_parport/pata_parport.c:649)
>> [  755.755610][ T8297]  kernfs_fop_write_iter (fs/kernfs/file.c:345)
>> [  755.755615][ T8297]  vfs_write (fs/read_write.c:595 =
fs/read_write.c:687)
>> [  755.755678][ T8297]  ksys_write (fs/read_write.c:739)
>> [  755.755703][ T8297]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 =
arch/x86/entry/syscall_64.c:94)
>> [  755.755717][ T8297]  entry_SYSCALL_64_after_hwframe =
(arch/x86/entry/entry_64.S:121)
>> [  755.779923][ T8297] Freed by task 8297 on cpu 0 at 755.752571s:
>> [  755.780598][ T8297]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
>> [  755.781128][ T8297]  kasan_save_free_info (mm/kasan/generic.c:584)
>> [  755.781700][ T8297]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
>> [  755.782222][ T8297]  kfree (./include/linux/kasan.h:235 =
mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
>> [  755.782658][ T8297]  kobject_put (lib/kobject.c:689 =
lib/kobject.c:720 ./include/linux/kref.h:65 lib/kobject.c:737)
>> [  755.783163][ T8297]  driver_find (drivers/base/bus.c:1429)
>> [  755.783659][ T8297]  new_device_store =
(drivers/ata/pata_parport/pata_parport.c:649)
>> [  755.787092][ T8297] The buggy address belongs to the object at =
ffff88812200f400
>> [  755.787092][ T8297]  which belongs to the cache kmalloc-192 of =
size 192
>> [  755.788598][ T8297] The buggy address is located 144 bytes inside =
of
>> [  755.788598][ T8297]  freed 192-byte region [ffff88812200f400, =
ffff88812200f4c0)
>>=20
>> Best,
>> Shuangpeng
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research


