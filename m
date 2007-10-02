From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 02 Oct 2007 09:11:30 +0900
Message-ID: <47018CB2.8020008@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FDE1A7.6030102@gmail.com> <4700F6BE.3060904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:55313 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbXJBANM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 20:13:12 -0400
Received: by an-out-0708.google.com with SMTP id d31so582887and
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 17:13:11 -0700 (PDT)
In-Reply-To: <4700F6BE.3060904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Polling PMP 2.6.24 is completely unacceptable.  It screws the 2.6.24 SAS
> driver releases out of PMP.

Not merging PMP has about the same effect for SAS, right?

> I pulled your last PMP patchset, and will now endeavor to fix the API
> prior to 2.6.24 merge window opening.

I have a preliminary patch.  The patch is pretty simple too.  I'll
submit after some testing but I'm not sure whether doing this right
before the merge window is a good idea.  I'd prefer not to support PMP
on SAS for 2.6.24.

> Linux high level message-submit / message-complete APIs should never
> _require_ polling, even if its 100% polling under the hood.  There are
> far too many cases in the field where you don't have direct access to
> hardware registers to poll.  Or such polling would interfere with the
> operation of other ports.  Or any of a myriad of other reasons.

I don't think that's true for actual ATA controllers but, for SAS,
probably true.  Is the frozen reset mechanism a headache too for SAS?

Thanks.

-- 
tejun
