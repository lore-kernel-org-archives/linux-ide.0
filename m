From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 1/5] ide: remove PIO "downgrade" quirk
Date: Mon, 18 Feb 2008 18:02:36 +0100
Message-ID: <58cb370e0802180902i1c66713dmeb7f52dc444947f5@mail.gmail.com>
References: <20080217185105.16210.26582.sendpatchset@localhost.localdomain>
	 <47B9AD1D.4020307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:61745 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbYBRRCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 12:02:41 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1687286mue.5
        for <linux-ide@vger.kernel.org>; Mon, 18 Feb 2008 09:02:37 -0800 (PST)
In-Reply-To: <47B9AD1D.4020307@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Sergei,

On Feb 18, 2008 5:06 PM, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
>
> > No need for it nowadays
>
>     Since which moment, could you elaborate

We fixed:

- PIO auto-tuning in core code

- PIO programming in host drivers

- IORDY handling in core code and in host drivers (it could be that the
  incorrect IORDY handling was the main reason behind the "downgrade")

and

- lack of corresponding "quirk" in libata hasn't been problematic so far

so IMO there is no longer a valid reason to punish PIO performance
and the said "quirk" should be removed (in 2.6.26 after long time in -mm).

> > so remove quirk code from ide_get_best_pio_mode()
> > and IDE_HFLAG_PIO_DOWNGRADE host flag.
>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
