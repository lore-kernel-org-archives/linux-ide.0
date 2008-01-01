From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide_setup_dma() assumes 8 ports
Date: Tue, 1 Jan 2008 18:38:57 +0100
Message-ID: <200801011838.57615.bzolnier@gmail.com>
References: <200712301948.55016.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:11606 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbYAAR1w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jan 2008 12:27:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2424492ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 01 Jan 2008 09:27:50 -0800 (PST)
In-Reply-To: <200712301948.55016.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 30 December 2007, Sergei Shtylyov wrote:
> According to http://marc.info/?l=linux-ide&m=114346138611631, the drivers must
> always register 8 DMA ports with ide_setup_dma(), so its last argument is  not
> needed. While at it, kill some useless parens in that function...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
