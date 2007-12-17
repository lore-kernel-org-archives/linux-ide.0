From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] hpt366: merge set_dma_mode() methods
Date: Mon, 17 Dec 2007 21:53:38 +0100
Message-ID: <200712172153.38425.bzolnier@gmail.com>
References: <200712142146.31984.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:64708 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936412AbXLQUoH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Dec 2007 15:44:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1631636ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 17 Dec 2007 12:44:04 -0800 (PST)
In-Reply-To: <200712142146.31984.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 14 December 2007, Sergei Shtylyov wrote:
> Group the array of pointers to the timing tables with the timing register masks
> which allows us to merge HPT36x/HPT37x set_dma_mode() methods into one.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
