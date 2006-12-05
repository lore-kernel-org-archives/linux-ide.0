From: Mark Lord <liml@rtr.ca>
Subject: Re: -mm merge plans for 2.6.20
Date: Tue, 05 Dec 2006 10:00:38 -0500
Message-ID: <45758996.4080502@rtr.ca>
References: <20061204204024.2401148d.akpm@osdl.org>	<4574FC0A.8090607@garzik.org> <20061204214114.433485fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2205 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759846AbWLEPAk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Dec 2006 10:00:40 -0500
In-Reply-To: <20061204214114.433485fc.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Andrew Morton wrote:
> On Mon, 04 Dec 2006 23:56:42 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Andrew Morton wrote:
> 
>>> libata_resume_fix.patch
>> I thought this was resolved long ago?  Are there still open reports that 
>> this solves, where upstream doesn't work?
> 
> Heck, I don't know.

You probably pinched it from my website originally, and I nabbed it from
an LKML posting 18 months ago.  It's a patch that was required here back
in the 2.6.12 - 2.6.16 era, and it is no longer needed now.

Drop it.
