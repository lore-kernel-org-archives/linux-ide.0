From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Another libata TODO item
Date: Wed, 24 Aug 2005 12:53:43 -0400
Message-ID: <430CA617.6090106@pobox.com>
References: <430C10E7.9060502@pobox.com>	<20050824074116.GF24513@infradead.org> <430C271E.7060006@pobox.com> <52d5o31fce.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751170AbVHXQyD@vger.kernel.org>
In-Reply-To: <52d5o31fce.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Dreier <rolandd@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Roland Dreier wrote:
>     Jeff> In any case, I also contine to be skeptical of in-kernel
>     Jeff> logging subsystems.
> 
> Aren't you proposing a libata logging subsystem?

Look at net drivers.  Theres no real infrastructure beyond bit tests and 
printks.  I wouldn't call that a subsystem, so, I wouldn't call this one 
such either.

	Jeff
