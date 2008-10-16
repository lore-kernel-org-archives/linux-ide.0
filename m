From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: powerpc allmodconfig
Date: Fri, 17 Oct 2008 02:30:24 +0900 (JST)
Message-ID: <20081017.023024.132760073.anemo@mba.ocn.ne.jp>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<48F7159D.4040709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:50200 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760003AbYJPRaS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 13:30:18 -0400
In-Reply-To: <48F7159D.4040709@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org

On Thu, 16 Oct 2008 14:21:17 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > drivers/serial/serial_txx9.c: In function 'serial_txx9_probe':
> > drivers/serial/serial_txx9.c:1041: warning: format '%x' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
> >   
> 
>    Atsushi-san, are you seeing this one?

Yes, I'll send a one-liner patch soon.

---
Atsushi Nemoto
