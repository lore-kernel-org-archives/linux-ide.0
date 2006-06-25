From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: More information on ATI IXP failure in git9
Date: Sun, 25 Jun 2006 19:23:26 -0400
Message-ID: <449F1AEE.700@pobox.com>
References: <200606252359.27671.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63124 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965655AbWFYXXb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 19:23:31 -0400
In-Reply-To: <200606252359.27671.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Cc: Andi Kleen <ak@suse.de>

Andi created a patch at my suggestion:
http://one.firstfloor.org/~andi/sil-debug

and that got him mounting the device, but the EH was still giving him 
much pain:
http://one.firstfloor.org/~andi/sata-error-loop

It looks like some condition isn't getting ack'd...

	Jeff



