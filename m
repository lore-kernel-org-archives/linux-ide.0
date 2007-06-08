From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix] hpt366: disallow Ultra133 for HPT374
Date: Fri, 8 Jun 2007 14:44:12 +0200
Message-ID: <200706081444.12625.bzolnier@gmail.com>
References: <200706062353.28707.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:48267 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968540AbXFHNJW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 09:09:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so950418ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 06:09:21 -0700 (PDT)
In-Reply-To: <200706062353.28707.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: wildy@petra.hos.u-szeged.hu, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 06 June 2007, Sergei Shtylyov wrote:
> Eliminate UltraATA/133 support for HPT374 -- the chip isn't capable of this mode
> according to the manual, and doesn't even seem to tolerate 66 MHz DPLL clock...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
