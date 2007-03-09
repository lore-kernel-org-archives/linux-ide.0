From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_cmd640: Multiple updates
Date: Fri, 09 Mar 2007 08:01:56 -0500
Message-ID: <45F15AC4.7080600@garzik.org>
References: <20070307164329.752993ff@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55814 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767245AbXCINB7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 08:01:59 -0500
In-Reply-To: <20070307164329.752993ff@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> Add suspend/resume support
> Write 0x5B to 0 not 0x5C
> 
> The former is important as we must kill the FIFO on a resume
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


