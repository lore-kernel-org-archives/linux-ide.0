From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
 init model
Date: Wed, 09 Aug 2006 08:54:22 -0400
Message-ID: <44D9DAFE.8040600@rtr.ca>
References: <1154919840689-git-send-email-htejun@gmail.com> <44D96E8E.9020801@pobox.com> <44D9782A.30405@gmail.com> <44D98388.8030005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:39055 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750723AbWHIMyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 08:54:24 -0400
In-Reply-To: <44D98388.8030005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

>Its a bit confusing because "PCI IDE" is often used to refer to the legacy IDE shadow register >interface.  I started to use "bmdma" to describe the interface, but it drives Alan crazy  :) 

Yes, it would do that, because the official specification for those interfaces
is the "PCI IDE Controller Specification".  Need a copy?

Cheers
