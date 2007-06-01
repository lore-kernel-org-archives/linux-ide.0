From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: HPT374 IDE problem with 2.6.21.* kernels
Date: Fri, 1 Jun 2007 13:46:07 -0700
Message-ID: <20070601134607.ce4a37bd.akpm@linux-foundation.org>
References: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:40969 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762874AbXFAUqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jun 2007 16:46:23 -0400
In-Reply-To: <Pine.LNX.4.62.0705301112170.1260@petra.hos.u-szeged.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Wed, 30 May 2007 11:30:00 +0200 (CEST)
Geller Sandor <wildy@petra.hos.u-szeged.hu> wrote:

> Hi,
> 
> I saw a similar report yesterday with '2.6.21.1 - 97% wait time on IDE 
> operations' subject.
> 
> After upgrading from 2.6.20.7 kernel to 2.6.21.1 my system started to 
> reset infrequenly the IDE bus. In the syslog DMA timeout, resetting IDE 
> bus messages appeared. I've changed the two disks attached to the HPT374 
> controller, and always the first disk had problems. I've replaced cables, 
> plugged the disks into other IDE ports, but it was only a matter of time 
> to experience an IDE reset. When I upgraded to 2.6.21.3 the resets became 
> much more frequent, this time even DMA was disabled too on the first disk. 
> I turned DMA back Manually with hdparm, and a few seconds of intense IO 
> activity resulted in another IDE reset.
> 
> Reverting back to 2.6.20.12 the problem seems to be gone. BTW I'm using 
> the PATA driver for the HTP374, not the libata one.
> 
> Is this a known problem/ is there a way I can help locating the cause of 
> the problem?
> 

(cc's added)
