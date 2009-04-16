From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] hpt366: use ATA_DMA_* constants
Date: Thu, 16 Apr 2009 20:58:25 +0200
Message-ID: <200904162058.25731.bzolnier@gmail.com>
References: <200904091638.50949.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:35201 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbZDPTjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2009 15:39:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so261819fkq.5
        for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2009 12:39:10 -0700 (PDT)
In-Reply-To: <200904091638.50949.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 09 April 2009 14:38:50 Sergei Shtylyov wrote:
> Use ATA_DMA_* constants instead of the bare numbers for the BMIDE register bits.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
