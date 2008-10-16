From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] scc_pata: kill unused variables
Date: Thu, 16 Oct 2008 21:40:56 +0200
Message-ID: <200810162140.56921.bzolnier@gmail.com>
References: <200810162305.31300.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:10957 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbYJPTwr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 15:52:47 -0400
Received: by gv-out-0910.google.com with SMTP id e6so107071gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 12:52:46 -0700 (PDT)
In-Reply-To: <200810162305.31300.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 16 October 2008, Sergei Shtylyov wrote:
> Fix the "unused variable" warning in init_hwif_scc() caused by the commit
> 48c3c1072651922ed153bcf0a33ea82cf20df390 (ide: add struct ide_host (take 3)).
> Moreover, remove the write-only variable 'dma_status_port' in init_setup_scc()
> about which gcc gives no warning and which has been there from the very start...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
