From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: No equivalent for ide-scsi available with the new PATA drivers?
Date: Mon, 23 Jul 2007 13:01:39 -0400
Message-ID: <46A4DEF3.4050106@redhat.com>
References: <46A4D91C.3090509@redhat.com> <20070723175239.54b721f1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756867AbXGWRBq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 13:01:46 -0400
In-Reply-To: <20070723175239.54b721f1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On 07/23/2007 12:52 PM, Alan Cox wrote:
>> People with IDE tape drives are complaining there's no ide-scsi
>> driver available anymore with the new PATA layer. Is anyone
>> working on one?
> 
> It would make no sense. The libata layer is already using the SCSI
> midlayer so compliant devices should already appear with the st driver.
> 
> We might need some tape detect logic, but I don't have any tape devices
> so its up to someone with a tape drive handy to help out...

I should have posted this earlier:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=243568
