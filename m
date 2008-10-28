From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] pata_ninja32: suspend/resume support
Date: Tue, 28 Oct 2008 00:42:02 -0400
Message-ID: <4906981A.2080301@garzik.org>
References: <20081017180655.7781.15021.stgit@localhost.localdomain> <20081017180826.7781.59704.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57071 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYJ1EmG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 00:42:06 -0400
In-Reply-To: <20081017180826.7781.59704.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> I had assumed that the standard recovery would be sufficient for this
> hardware but it isn't. Fix up the other registers on resume as needed. See
> bug #11735
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
> 
>  drivers/ata/pata_ninja32.c |   43 ++++++++++++++++++++++++++++++++++---------
>  1 files changed, 34 insertions(+), 9 deletions(-)

applied

patches 2-4 look interesting, but I paused to wait for comments (if 
any).  They look like material for at least a little bit of a linux-next 
time before going upstream, not really 2.6.28-rc1 [at the time] material 
IMO...

	Jeff



