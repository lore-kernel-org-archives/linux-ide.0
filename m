From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Tue, 26 Jan 2010 21:49:18 +0530
Message-ID: <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:62712 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab0AZQTT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 11:19:19 -0500
In-Reply-To: <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

2010/1/26 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> Should work with 64, 128 (tested) and 256 GB capacities with any
>> firmware versions in
>> drivers/ata/libata-core.c because of ATA errors in dmesg, hangs and
>> filesystem corruption.
>
> If you've only tested one type why list all three ? Also you've not
> listed a firmware version so do you know which are affected ?
>
> What controllers did you test with ?
>
> Alan
>

The 3 IDs should match I believe and the firmware parameter is NULL.
Affected firmware versions include at least the latest 1916 and the
previous 1819, likely older ones as well.

Tested with my own Crucial CT128M225 model which has the IndiLinx
Barefoot controller.

The libata-core.c file has an existing line for "OCZ_CORESSD" for a
particular firmware version
but I suspect many, if not all of those controllers may have this issue?
At least one user of Intel SSDs reports no issues with existing
kernels and I've read that
they do NCQ right.
