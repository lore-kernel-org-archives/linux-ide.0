From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] at91_ide: remove custom tf_{read|load}() methods (take 2)
Date: Tue, 7 Apr 2009 20:40:15 +0200
Message-ID: <200904072040.15676.bzolnier@gmail.com>
References: <200904072107.33324.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45110 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761627AbZDGVk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 17:40:56 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so2531294fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 14:40:56 -0700 (PDT)
In-Reply-To: <200904072107.33324.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

On Tuesday 07 April 2009 19:07:33 Sergei Shtylyov wrote:
> Since tf_{read|load}() methods of this driver have now become identical to their
> standard counterparts using MMIO accesses, there's no need to override those
> anymore...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> ---
> Remove ide_mm_{inb|outb}() that somehow fell out of my attention...
> This incorporates the patch posted by Stanislaw Gruszka today.

Your patch was already in pata-2.6 tree so I just applied Stanislaw's
one on top of it.
