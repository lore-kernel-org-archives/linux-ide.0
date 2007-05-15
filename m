From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: remove init_dma() method
Date: Tue, 15 May 2007 23:40:42 +0200
Message-ID: <200705152340.42325.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200705120111.41950.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:36336 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760519AbXEPAq3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 20:46:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2831uga
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 17:46:29 -0700 (PDT)
In-Reply-To: <200705120111.41950.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 11 May 2007, Sergei Shtylyov wrote:
> Get rid of the init_dma() method (which had no particular reason to exist) by
> folding it into the init_hwif() method. While at it, also perform some cleanup
> in the latter method:
> 
> - get rid of the useless clearing of hwif->autodma;
> 
> - fold the serialization code into one 'if' statement;
> 
> - fold setting the drives' 'autotune' and 'autodma' fields into the single
>   statements...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
