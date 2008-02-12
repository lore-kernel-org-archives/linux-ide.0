From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Add missing base addresses for falconide and macide
Date: Tue, 12 Feb 2008 01:15:37 +0100
Message-ID: <200802120115.37876.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0802112232060.7963@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:30755 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbYBLANH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 19:13:07 -0500
Received: by mu-out-0910.google.com with SMTP id i10so5799228mue.5
        for <linux-ide@vger.kernel.org>; Mon, 11 Feb 2008 16:13:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0802112232060.7963@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>, linux-ide@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Monday 11 February 2008, Geert Uytterhoeven wrote:
> commit 29dd59755a849cc6475faa6a75f3b804e23a6fc2 ("ide: remove ide_setup_ports")
> forgot to take into account the base addresses for the CONTROL registers for
> falconide and macide, as pointed out by Michael Schmitz.
> 
> Falconide was tested on Aranym.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michael Schmitz <schmitz@debian.org>

Thanks!  Applied.

[ this patch was a missing link to (hopefully) bring the number of open
  2.6.25 IDE regressions down to _zero_ ]
