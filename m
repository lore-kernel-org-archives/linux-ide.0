From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET 3/4] libata: prep for PMP support, take 4
Date: Tue, 10 Jul 2007 22:04:23 -0400
Message-ID: <46943AA7.9070203@garzik.org>
References: <11832855672398-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37862 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755865AbXGKCE0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 22:04:26 -0400
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Hello, all.
> 
> This is the fourth take of libata-pmp-prep patchset.  This patchset
> contains 12 patches implementing various stuff needed for PMP.
> 
> #01	: add PMP related constants
> #02-04	: various small stuff
> #05-06	: qc_defer mechanism implementation
> #07-11	: link/device quirks and EH fast-fail path - things needed to
> 	  handle quirky PMP fan-out links / pseudo devices.
> #12	: SATA SDB notify handler
> 
> Changes from the last take[L] are.
> 
> * PMP related constants patch moved here from pmp patchset
> * qc_defer CLEAR_EXCL fixed to clear excl_link iff it points to self
> * addition of various quirks/special case handling vital for
>   supporting first-gen PMP chips
> * generalized SDB notify handling
> 
> This patchset is against
> 
>   libata-dev#upstream (4e1ae96828f6cee7b89ab8ca474c150fe211afd8)
>   + [1] misc-updates patchset
>   + [2] libata-link patchset, take 4

seems generally OK to me


