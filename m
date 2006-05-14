From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 16/22] libata: implement new SCR handling and port on/offline
 functions
Date: Sat, 13 May 2006 21:35:20 -0400
Message-ID: <44668958.7060004@pobox.com>
References: <1147348791300-git-send-email-htejun@gmail.com> <44665314.4040805@pobox.com> <4466695B.4050204@gmail.com> <44668399.2060101@pobox.com> <446687FD.8070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42892 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750736AbWENBf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 21:35:28 -0400
In-Reply-To: <446687FD.8070406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> So, the current ata_port_on/off functions can be considered as including 
> both PATA and SATA implementation, where SATA implementation got 
> collapsed into it because PATA implementation is trivial.

ok, ACK this train of thought

