From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/11] ide-pmac: remove nIEN clearing from pmac_ide_do_setfeature()
Date: Mon, 23 Jul 2007 23:22:34 +0200
Message-ID: <200707232322.34930.bzolnier@gmail.com>
References: <200707222033.55198.bzolnier@gmail.com> <46A3AF3E.1070104@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51030 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbXGWVZk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:40 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40027ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:40 -0700 (PDT)
In-Reply-To: <46A3AF3E.1070104@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sunday 22 July 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Upper layers are responsible for controlling nIEN so don't clear nIEN after
> > command execution in pmac_ide_do_setfeature().
> 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added
