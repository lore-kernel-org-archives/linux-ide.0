From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sis: Remove bogus cable match
Date: Fri, 05 Dec 2008 15:31:40 -0500
Message-ID: <49398FAC.2060301@garzik.org>
References: <20081205194117.17036.74479.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47317 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbYLEUbo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Dec 2008 15:31:44 -0500
In-Reply-To: <20081205194117.17036.74479.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kai@kaishome.de, linux-ide@vger.kernel.org

Alan Cox wrote:
> From: Alan Cox <alan@redhat.com>
> 
> Some systems report SIS 5513 as both vendor/id and subvendor/id string. In
> that case we can't distinguish the system by the id svid/sdid and in fact
> the entry here breaks some boxes. At some point we need to find another way
> to detect the Targa Visionary 1000, until then this a hang for some users with
> lower performance for others.
> 
> Closes: #12092
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Should that last sentence be "this SOLVES a hang"?

As it is currently worded, it is unclear what we are trading off with 
this patch...

Thanks,

	Jeff




