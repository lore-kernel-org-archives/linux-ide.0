From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA in Target Mode
Date: Wed, 19 May 2010 11:48:55 -0400
Message-ID: <4BF40867.9000606@garzik.org>
References: <AANLkTinSg70pTj2uwnHuB4xT1I88nNU06l080_m9vngl@mail.gmail.com> <AANLkTimLUIShHybcy51NThd2gtkQxFtXWCyVY2iee_c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53009 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0ESPtC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 11:49:02 -0400
Received: by gwaa20 with SMTP id a20so1870962gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 08:48:59 -0700 (PDT)
In-Reply-To: <AANLkTimLUIShHybcy51NThd2gtkQxFtXWCyVY2iee_c6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jayaraman Thiruvady <jayaraman.tg@gmail.com>
Cc: linux-ide@vger.kernel.org

On 05/19/2010 02:12 AM, Jayaraman Thiruvady wrote:
> Hi,
>
>        I am trying to make vdisk ( file disk ) to emulate as a SATA
> drive. To do so, i thought of making a SATA port to target mode and
> cross wire it with another SATA port ( initiator) and by mapping the
> SATA target mode port with vdisk, the SATA initiator must detect the
> vdisk as some SATA device to perform further. Is such scenario doable?
>
> Is the place where i can find more details on how much scenario is
> achievable and the details Marvell SATA support as target mode in
> kernel-tree and its info supported chipsets?.

Unfortunately, nobody's really worked on it, as far as I know.

It would be great to see SATA target support, though.

	Jeff



