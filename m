From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] cleanup powerpc/include/asm/ide.h
Date: Fri, 8 Aug 2008 18:22:16 +0200
Message-ID: <200808081822.17118.bzolnier@gmail.com>
References: <20080808151849.GB14495@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:19845 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbYHHQdt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 12:33:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so586961fgg.17
        for <linux-ide@vger.kernel.org>; Fri, 08 Aug 2008 09:33:48 -0700 (PDT)
In-Reply-To: <20080808151849.GB14495@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Friday 08 August 2008, Adrian Bunk wrote:
> This patch removes code that became unused through IDE changes and the 
> arch/ppc/ removal.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
