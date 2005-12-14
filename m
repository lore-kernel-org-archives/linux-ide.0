From: Shem Multinymous <multinymous@gmail.com>
Subject: Re: tp_smapi conflict with IDE, hdaps
Date: Wed, 14 Dec 2005 18:32:51 +0200
Message-ID: <41840b750512140832r2be9317akcc9d661e7810cf0f@mail.gmail.com>
References: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
	 <1134486203.11732.60.camel@localhost.localdomain>
	 <41840b750512130729y49903791xc9ceba4e6a18322e@mail.gmail.com>
	 <1134488305.11732.74.camel@localhost.localdomain>
	 <41840b750512130804s32fe543xa11933f681973281@mail.gmail.com>
	 <1134490575.11732.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:17352 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964835AbVLNQcx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 11:32:53 -0500
Received: by wproxy.gmail.com with SMTP id 58so406488wri
        for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2005 08:32:52 -0800 (PST)
In-Reply-To: <1134490575.11732.104.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>, Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org

Hi

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> But the ACPI DSDT is OS independant in theory and in practice to a fair
> extent. It can't make assumptions about windows drivers.

The IDE issue is moot in light of SET_STREAMING, but just for the
record: the preinstalled Windows on this ThinkPad uses Microsoft's
default IDE driver and Intel's default 82801FBM driver, so it doesn't
look like it's doing SMAPI-specific synchronization.


> Its probably easier to write than go find one
>
> I mean you need
>
> tp_hw_init() {
[code snipped]

Oh, thanks! That's far less voodoo than I feared.

I'll coordinate things with Robert Love (hdaps maintainer).

  Shem
