From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
Date: Mon, 4 Dec 2006 13:02:54 +0000
Message-ID: <20061204130254.424c7979@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061204124026.GB28159@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:31636 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1759702AbWLDM7H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 07:59:07 -0500
In-Reply-To: <20061204124026.GB28159@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Mon, 4 Dec 2006 13:40:26 +0100 (MET)
Olaf Hering <olaf@aepfle.de> wrote:

> 
> 
> the hald media changed polling does really confuse things.
> noone knows why the delays are needed, but they give us access to
> the CD.

Can you tell me what happens if you completely pull the reset out of the
dma_end function. Do you still need delays then.

