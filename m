From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: More IDE hackery
Date: Wed, 03 Nov 2004 17:08:35 +0000
Message-ID: <1099501714.29846.71.camel@localhost.localdomain>
References: <1099487809.29560.28.camel@localhost.localdomain>
	 <58cb370e04110309146ad102fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:18624 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261785AbUKCSLs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Nov 2004 13:11:48 -0500
In-Reply-To: <58cb370e04110309146ad102fc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> It won't work unless you modify ide_register_hw().
> See ide_register_hw() vs "initializing == 1".

I changed that to allow a fixup to be passed as well. That causes most
of the noise changes but I could make that ide_register_hw_with_fixup()
to avoid changes elsewhere adding NULL to ide_register_hw calls.  Which
would you prefer and I'll go make full patches

> +	/* Has a serial number but is warped */
> +	if (!strstr(drive0->id->model, "Integrated Technology Express"))
> +		return;
> 
> This shouldn't be needed now, no?

Probably not.



