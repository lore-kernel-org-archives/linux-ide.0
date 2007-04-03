From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add NCQ blacklist entries from Silicon Image
 Windows driver (v2)
Date: Tue, 03 Apr 2007 13:13:11 +0900
Message-ID: <4611D457.5050309@gmail.com>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org> <20070331181940.GV14134@stusta.de> <4611D289.5090209@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:55116 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbXDCENT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2007 00:13:19 -0400
Received: by ug-out-1314.google.com with SMTP id 44so155628uga
        for <linux-ide@vger.kernel.org>; Mon, 02 Apr 2007 21:13:17 -0700 (PDT)
In-Reply-To: <4611D289.5090209@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, jgarzik@pobox.com

Robert Hancock wrote:
> This adds some NCQ blacklist entries taken from the Silicon Image 3124/3132
> Windows driver .inf files. There are some confirming reports of problems
> with these drives under Linux (for example
> http://lkml.org/lkml/2007/3/4/178)
> so let's disable NCQ on these drives.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
