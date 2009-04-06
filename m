From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx493[89]ide: Remove big endian version of tx493[89]ide_tf_{load,read}
Date: Mon, 6 Apr 2009 23:13:50 +0200
Message-ID: <200904062313.50980.bzolnier@gmail.com>
References: <1239034146-3514-1-git-send-email-anemo@mba.ocn.ne.jp> <49DA2C50.6000108@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55424 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756967AbZDFVLp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:45 -0400
In-Reply-To: <49DA2C50.6000108@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 06 April 2009, Sergei Shtylyov wrote:
> Atsushi Nemoto wrote:
> 
> > Now tx493[89]ide_tf_{load,read} do not contain word I/O operations.
> > They are endian-free now.
> 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>     Oops, now this clashes with my patchset (not applied to pata-2.6 AFAICS). 
> I guess I'll have to repost it... Bart?

Since I already had your patches merged locally I just applied this one
in front of yours and then repeated:

- force apply the patch
- ignore rejects
- refresh the patch
- audit the result

cycle for all patches.

It seems like the end result is OK (changes to big endian ->tf_{load,read}
vanished, change to "fixup" ->tf_load survived and all patch descriptions
remained valid) but please verify it.

Thanks,
Bart
