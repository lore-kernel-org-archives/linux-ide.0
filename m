From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Tue, 30 Oct 2007 07:15:15 -0600
Message-ID: <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
	 <47270CE9.4060501@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:4395 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbXJ3NPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 09:15:16 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1870590rvb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 06:15:15 -0700 (PDT)
In-Reply-To: <47270CE9.4060501@msgid.tls.msk.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Matheus Izvekov <mizvekov@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On 10/30/07, Michael Tokarev <mjt@tls.msk.ru> wrote:
> By the way, did you forget to remove a jumper on the drive
> (the only jumper installed by default) that limits drive
> usage to SATAI?
...
> ..etc.   Try again without the jumper?  Note that NCQ is NOT supported
> in SATAI mode, or there were some pre-standard implementations of it.
> In SATAII, NCQ is standard (well... more or less anyway ;)

Huh?

To my knowledge, the jumper should only limit the bus rate to
1.5Gbit/s, for compatibility with one or more chipsets.  It shouldn't
affect the command set supported by the device.
