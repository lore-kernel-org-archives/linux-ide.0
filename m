From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID
	1520	SATA (HPT372N)
Date: Thu, 04 May 2006 23:25:05 +0100
Message-ID: <1146781505.24513.3.camel@localhost.localdomain>
References: <436FB350.6020309@inap.se>
	 <1131467876.25192.51.camel@localhost.localdomain>
	 <445A5BD5.2050508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52202 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751522AbWEDWOL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 May 2006 18:14:11 -0400
In-Reply-To: <445A5BD5.2050508@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Johan Palmqvist <johan.palmqvist@inap.se>, mlaks@verizon.net, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Iau, 2006-05-04 at 23:53 +0400, Sergei Shtylyov wrote:
>     I think I've dealt with this oops now, see my recent patches to this
> driver, particularly the one that reads the f_CNT value saved by BIOS...

I have them queued to review in depth, although in that specific case I
don't know if I can help - none of my cards set the BIOS provided
value..

