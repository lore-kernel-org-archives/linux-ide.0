From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] palm_bk3710: fix tRP for UDMA mode 4
Date: Fri, 11 Jul 2008 21:11:10 +0200
Message-ID: <200807112111.11254.bzolnier@gmail.com>
References: <200807091940.15722.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:61635 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbYGJTXH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jul 2008 15:23:07 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1178108yxm.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jul 2008 12:23:06 -0700 (PDT)
In-Reply-To: <200807091940.15722.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

On Wednesday 09 July 2008, Sergei Shtylyov wrote:
> From: Mikhail Cherkashin <mcherkhashin@ru.mvista.com>
> 
> Fix tRP timing for UDMA mode 4 according to the ATA specification.
> 
> Signed-off-by: Mikhail Cherkashin <mcherkhashin@ru.mvista.com>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
