From: David Rees <drees76@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Tue, 26 Jan 2010 12:51:33 -0800
Message-ID: <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	<20100126160243.018b87e3@lxorguk.ukuu.org.uk> <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39452 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab0AZUvx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 15:51:53 -0500
In-Reply-To: <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

On Tue, Jan 26, 2010 at 8:19 AM, Vishal Rao <vishalrao@gmail.com> wrote:
> 2010/1/26 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>>> Should work with 64, 128 (tested) and 256 GB capacities with any
>>> firmware versions in
>>> drivers/ata/libata-core.c because of ATA errors in dmesg, hangs and
>>> filesystem corruption.
>>
>> If you've only tested one type why list all three ? Also you've not
>> listed a firmware version so do you know which are affected ?
>>
>> What controllers did you test with ?
>
> The 3 IDs should match I believe and the firmware parameter is NULL.
> Affected firmware versions include at least the latest 1916 and the
> previous 1819, likely older ones as well.
>
> Tested with my own Crucial CT128M225 model which has the IndiLinx
> Barefoot controller.
>
> The libata-core.c file has an existing line for "OCZ_CORESSD" for a
> particular firmware version
> but I suspect many, if not all of those controllers may have this issue?
> At least one user of Intel SSDs reports no issues with existing
> kernels and I've read that
> they do NCQ right.

A lot of different SSDs use the Indilinx Barefoot controller and the
firmware between each should be nearly identical.

Have there been any other reports of NCQ issues with similar Crucial
drives or Indilinx?

I would be hesitant to apply this branch to the trunk without seeing
at least a couple other cases of issues.

-Dave
