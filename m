From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PATCH: Small fixes backported to old IDE SiS driver
Date: Tue, 3 Jan 2006 17:54:14 +0100
Message-ID: <58cb370e0601030854j45f9af79gd594850926061326@mail.gmail.com>
References: <1136301581.22598.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.198]:16453 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbWACQyP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 11:54:15 -0500
Received: by nproxy.gmail.com with SMTP id l35so893020nfa
        for <linux-ide@vger.kernel.org>; Tue, 03 Jan 2006 08:54:14 -0800 (PST)
In-Reply-To: <1136301581.22598.5.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org

On 1/3/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Some quick backport bits from the libata PATA work to fix things found
> in the sis driver. The piix driver needs some fixes too but those are
> way to large and need someone working on old IDE with time to do them.
>
> This patch fixes the case where random bits get loaded into SIS timing
> registers according to the description of the correct behaviour from
> Vojtech Pavlik. It also adds the SiS5517 ATA16 chipset which is not
> currently supported by the driver. Thanks to Conrad Harriss for loaning
> me the machine with the 5517 chipset.

Looks obviously correct.  Andrew, could you add it to -mm?

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks,
Bartlomiej
