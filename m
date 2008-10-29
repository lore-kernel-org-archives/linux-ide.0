From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] tx4938ide: Do not call devm_ioremap for whole 128KB
Date: Wed, 29 Oct 2008 20:12:32 +0100
Message-ID: <200810292012.33069.bzolnier@gmail.com>
References: <20081027.223939.59650930.anemo@mba.ocn.ne.jp> <4906542A.9090905@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:51068 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYJ2T2y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:28:54 -0400
Received: by gv-out-0910.google.com with SMTP id e6so99787gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 12:28:51 -0700 (PDT)
In-Reply-To: <4906542A.9090905@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Tuesday 28 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Atsushi Nemoto wrote:
> > Call devm_ioremap() for CS0 and CS1 separetely.
> > And some style cleanups.
> >
> > Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
