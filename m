From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.24 1/1] sata_sil24: prevent hba lockup when pass-through
 ATA commands are used
Date: Wed, 09 Jan 2008 23:53:58 -0500
Message-ID: <4785A4E6.90107@garzik.org>
References: <e7510f760801010850l11b14086oc80ebe5b1f738eb5@mail.gmail.com> <47842EAD.9010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50241 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518AbYAJEyC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 23:54:02 -0500
In-Reply-To: <47842EAD.9010302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gwendal Grignou <gwendal@google.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Gwendal Grignou wrote:
>> Fix commands timeout with Sil3124/3132 based HBA when pass-through ATA
>> commands [where ATA_QCFLAG_RESULT_TF is set] are used while other
>> commands are active on other devices
>> connected to the same port with a Port Multiplier.
>> Due to a hardware bug, these commands must be sent alone, like ATAPI commands.
> 
> Thanks a lot.  You forgot S-O-B.
> 
> Acked-by: Tejun Heo <htejun@gmail.com>
> 
> Jeff, please queue this for 2.6.24.  Gwendal, IIRC you guys use lots of
> PMPs on your server farms, right?  How is the current code working
> there?  Do you guys see any detection problems?

hrm, I don't see the original message in my inbox.  Would one of you 
mind resending the original?

	Jeff



