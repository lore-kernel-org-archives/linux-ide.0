From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] trm290: cannot call ide_setup_dma()
Date: Tue, 1 Jan 2008 18:38:40 +0100
Message-ID: <200801011838.40660.bzolnier@gmail.com>
References: <200712301946.40108.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:12142 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbYAAR1v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jan 2008 12:27:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2424490ugc.16
        for <linux-ide@vger.kernel.org>; Tue, 01 Jan 2008 09:27:49 -0800 (PST)
In-Reply-To: <200712301946.40108.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sunday 30 December 2007, Sergei Shtylyov wrote:
> The TRM-290 chip is *not* SFF-8038i compatible and therefore can *not* call
> ide_setup_dma() -- fix this and also cleanup the code a bit...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
