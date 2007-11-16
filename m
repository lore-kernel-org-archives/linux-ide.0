From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: don't set PIO mode on pre-EIDE drives
Date: Fri, 16 Nov 2007 19:45:54 +0300
Message-ID: <473DC942.20803@ru.mvista.com>
References: <200711161626.25580.sshtylyov@ru.mvista.com> <20071116164240.40b02300@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7120 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752669AbXKPQpl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 11:45:41 -0500
In-Reply-To: <20071116164240.40b02300@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Alan Cox wrote:

>>Fix handling of  the PIO modes for the pre-EIDE drives that did not support
>>the PIO Flow Control Transfer Mode value (00001 nnn) of the Set Transfer Mode
>>feature by  skipping the actual mode programming.

> You also need to cater for CF 1.1 compliant devices which do not have set
> xfer mode.

    Do they have IORDY support?

WBR, Sergei
