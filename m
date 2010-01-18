From: "Caspar Smit" <c.smit@truebit.nl>
Subject: Re: sata_mv: wrong EDMA error cause when disk unplugged
Date: Mon, 18 Jan 2010 11:36:08 +0100 (CET)
Message-ID: <23044.87.210.74.220.1263810968.squirrel@ketsers.dhs.org>
References: <9ff69a5d1001180147h643572e5m2e9db0361caeb334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-69-81-65.colo.transip.net ([80.69.81.65]:59823 "EHLO
	ns1.emsolutions.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab0ARKpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 05:45:32 -0500
Received: from ns1.emsolutions.nl (www-data@localhost.localdomain [127.0.0.1])
	by ns1.emsolutions.nl (8.13.8/8.13.8/Debian-3) with ESMTP id o0IAa8jR026433
	for <linux-ide@vger.kernel.org>; Mon, 18 Jan 2010 11:36:08 +0100
In-Reply-To: <9ff69a5d1001180147h643572e5m2e9db0361caeb334@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Prashant,

Same here, using 1.28 from the debian backports 2.6.30 kernel.
Plug a disk = 0x00000010
Unplug a disk = 0x00000020

Kind regards,
Caspar

> Hi,
> I am using latest marvell sata driver version 1.28 for marvell chip
> 88SX6081, I noticed following behavior:
> 1) When I plug a disk, EDMA error cause value is: 0x00000010. This is
> correct.
> 2) But when I unplug a disk, EDMA error cause value is: 0x00000020
> (EDMA_ERR_SERR).
>     which is wrong. It should be 0x00000008 (EDMA_ERR_DEV_DCON).
>
> Please let me know if anybody experiencing the same problem.
> --
> ~p~r~a~s~h~a~n~t~
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

