From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx4938ide: Avoid underflow on calculation of a wait cycle
Date: Wed, 29 Oct 2008 20:20:17 +0100
Message-ID: <200810292020.17975.bzolnier@gmail.com>
References: <20081028.220904.128617360.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:51068 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYJ2T3A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 15:29:00 -0400
Received: by gv-out-0910.google.com with SMTP id e6so99787gvc.37
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 12:28:59 -0700 (PDT)
In-Reply-To: <20081028.220904.128617360.anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org, sshtylyov@ru.mvista.com

On Tuesday 28 October 2008, Atsushi Nemoto wrote:
> Make 'wt' variable signed while it can be negative during calculation.
> 
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
