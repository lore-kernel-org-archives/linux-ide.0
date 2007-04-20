From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: fix kernel oops with HPT302N
Date: Fri, 20 Apr 2007 21:54:52 +0200
Message-ID: <200704202154.52254.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200704182338.00604.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:35752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993319AbXDTUPP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 16:15:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so975041uga
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2007 13:15:14 -0700 (PDT)
In-Reply-To: <200704182338.00604.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: codermattie@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 18 April 2007, Sergei Shtylyov wrote:
> The driver crashes the kernel on HPT302N chips due to the missing initializer
> for 'hpt302n.settings' having been unfortunately overlooked so far. :-<
> 
> Much thanks to Mike Mattie for pin-pointing the reason of crash.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
