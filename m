From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Mon, 30 Apr 2007 16:31:48 -0400
Message-ID: <46365234.6010804@garzik.org>
References: <20070429161542.GA12501@havoc.gtf.org> <46364901.4000907@redhat.com> <46364C04.4050208@garzik.org> <46364FFA.9050500@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42978 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946792AbXD3Ubv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Apr 2007 16:31:51 -0400
In-Reply-To: <46364FFA.9050500@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Stephen Clark wrote:
> Yeah the kernel will boot but the hd performance is sh*t on my laptop. I 
> am running FC6 with
> kernel 2.6.21 and without the combined_mode setting my disk performance 
> goes down to a
> whopping 1.25mb/sec from 44mb/sec when I boot with combined_mode=libata. 
> It make my
> system unusable!


No, that's the split-driver configuration that causes the slowdown.

Now that both drivers fully support the hardware, either driver can make 
things go full speed.

Please try testing the update first :)

	Jeff


