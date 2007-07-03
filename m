From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/12] libata: schedule probing after SError access failure
 during autopsy
Date: Wed, 04 Jul 2007 00:05:06 +0900
Message-ID: <468A65A2.2060503@gmail.com>
References: <11832836183512-git-send-email-htejun@gmail.com> <468A5ECE.3010009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:2063 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbXGCPFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 11:05:12 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1245864nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 08:05:12 -0700 (PDT)
In-Reply-To: <468A5ECE.3010009@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> If SError isn't accessible, EH can't tell whether hotplug has happened
>> or not.  Report SError read failure with AC_ERR_OTHER and schedule
>> probing with hardreset.  This will be mainly useful for PMPs.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-eh.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> What if the LLDD told us hotplug happened?
> 
> Even though sata_promise has SError, it should be noted that hotplug
> under sata_promise is not signalled through normal means, but by a
> special vendor-specific register

Those two are independent and doesn't interfere with each other.  This
is just safeguard against PMP SCR read failures which might or might not
imply phy event.  ie. it's just another source of hotplug event.

-- 
tejun
