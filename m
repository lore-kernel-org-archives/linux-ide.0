From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil24 EH complete
Date: Sat, 09 May 2009 10:41:06 +0900
Message-ID: <4A04DF32.4050305@kernel.org>
References: <alpine.DEB.2.00.0905060004100.15177@dirac.rather.puzzling.org> <4A00DA98.5060201@kernel.org> <alpine.DEB.2.00.0905061038340.14678@dirac.rather.puzzling.org> <alpine.DEB.2.00.0905090005560.24222@dirac.rather.puzzling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37753 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbZEIBn2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 21:43:28 -0400
In-Reply-To: <alpine.DEB.2.00.0905090005560.24222@dirac.rather.puzzling.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Tim Connors wrote:
>>> Hmm... "ata1.00: configured for UDMA/100" means libata part of
>>> configuration went okay but it looks like SCSI probing didn't kick in
>>> for reason.  Is this always reproducible?
>> 100% of time if it is plugged in after boot.
> 
> Hah, I lied.  Not 100% of the time.
> 
> With *some* combination perhaps of
>> for host in 0 1 2 3 ; do ; echo "- - -" > /sys/class/scsi_host/host$host/scan ; done
> and
>> scsiadd -s
> when the drive is plugged in and when it isn't plugged in (or maybe even
> just leaving it alone) and plugging and unplugging it repeadedly,
> eventually (maybe 20% of the time?) it comes good:

I can reliably reproduce it here.  Heh... interesting.  I'll dig in.

Thanks.

-- 
tejun
