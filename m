From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH try3] a better Silicon Image SATA mod15 write fix?
Date: Mon, 15 Mar 2004 14:14:28 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40560094.2040800@pobox.com>
References: <4055D032.1090708@pobox.com> <4055EF4F.8060803@pobox.com> <4055F045.40102@pobox.com> <40560C0E.7060500@tripnotik.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61599 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262727AbUCOTOl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Mar 2004 14:14:41 -0500
In-Reply-To: <40560C0E.7060500@tripnotik.dyndns.org>
List-Id: linux-ide@vger.kernel.org
To: Julien Didron <jdidron@tripnotik.dyndns.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Julien Didron wrote:
> Hello list,
> 
>    This driver works :o)
>    running hdparm gives those results :
>    Timing buffered disk reads:  170 MB in  3.00 seconds =  56.60 MB/sec 
> (with 2.6.4-bk4 and sata_sil.c try 3)
>    Timing buffered disk reads:  170 MB in  3.01 seconds =  56.56 MB/sec 
> (with 2.6.4-mm2)

Thanks much for testing.  Try3 had a nasty bug, though.

Can you test Try4 as well?

Regards and thanks again,

	Jeff



