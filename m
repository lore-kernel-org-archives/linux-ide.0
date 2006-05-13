From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Sun, 14 May 2006 08:43:02 +0900
Message-ID: <44666F06.8000000@gmail.com>
References: <11473536881889-git-send-email-htejun@gmail.com> <44665D14.9030404@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:4165 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964808AbWEMXnI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 19:43:08 -0400
Received: by wr-out-0506.google.com with SMTP id 67so883208wri
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 16:43:07 -0700 (PDT)
In-Reply-To: <44665D14.9030404@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> General policy:  An LLDD should directly call a function it implements, 
> rather than a pointer found via one or more pointer de-refs.  Eliminates 
> the pointer derefs, and gives more information to the compiler (and/or 
> debugger).

I see.

-- 
tejun
