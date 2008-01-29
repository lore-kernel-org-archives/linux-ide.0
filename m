From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 29 Jan 2008 18:38:24 +0000
Message-ID: <20080129183824.0c47fa00@core>
References: <200801251512.09836.asalnikov@ru.mvista.com>
	<479F7236.40404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55228 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750760AbYA2Smp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 13:42:45 -0500
In-Reply-To: <479F7236.40404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com


>     Needless parens all over the code like this...
>     Also, you could have made it either 2 (getting rid of |= operator) or 4 
> lines (read/write, &=, and |=).

	mode |= dev << 4;

