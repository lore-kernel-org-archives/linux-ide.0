From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: update Kconfig text to mark as deprecated
Date: Fri, 30 Oct 2009 00:33:37 +0000
Message-ID: <20091030003337.57b712e7@lxorguk.ukuu.org.uk>
References: <4AE64FCC.4030102@gmail.com>
	<20091029.031344.102288703.davem@davemloft.net>
	<51f3faa70910291719kecb5edcp3b8812981b69acb1@mail.gmail.com>
	<20091029.173028.248393897.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56210 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755430AbZJ3Aby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Oct 2009 20:31:54 -0400
In-Reply-To: <20091029.173028.248393897.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: hancockrwd@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> And I know I won't be the only person in this kind of situation.
> 
> So, proceeding in any other way is really a non-starter.

Then keep old IDE until the hardware rots. Its not worth contaminating
libata and the scsi core with magic glue that only Dave Miller uses ;)

Alan
