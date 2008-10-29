From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
Date: Wed, 29 Oct 2008 20:12:19 +0100
Message-ID: <200810292012.19750.bzolnier@gmail.com>
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp> <20081027.235224.82088530.anemo@mba.ocn.ne.jp> <49064ACA.20200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:35072 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYJ2T2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:28:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so58729ywe.1
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 12:28:50 -0700 (PDT)
In-Reply-To: <49064ACA.20200@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Tuesday 28 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Atsushi Nemoto wrote:
> 
> > From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > Subject: [PATCH] tx4938ide: Check minimum cycle time and SHWT range (v2)
> >
> > SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
> > assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
> > release to address invalid hold time, so it actualy applies 4 times and
> > so constitutes -DIOx recovery time.  Check requirement of the recovery
> > time and cycle time.  Also check SHWT maximum value.
> >
> > Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
