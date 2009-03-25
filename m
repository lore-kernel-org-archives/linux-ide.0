From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] libata: Improve timeout handling
Date: Tue, 24 Mar 2009 22:51:27 -0400
Message-ID: <49C99C2F.9010703@garzik.org>
References: <20090324101952.9152.30261.stgit@localhost.localdomain> <20090324102324.9152.78865.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52094 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbZCYCvc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:51:32 -0400
In-Reply-To: <20090324102324.9152.78865.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> On a timeout call a device specific handler early in the recovery so that
> we can complete and process successful commands which timed out due to IRQ
> loss or the like rather more elegantly.
> 
> [Revised to exclude the timeout handling on a few devices that inherit from
>  SFF but are not SFF enough to use the default timeout handler]
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied

let's see what explodes!  :)


