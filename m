From: Tejun Heo <htejun@gmail.com>
Subject: Re: New probe code causes boot delay on empty ports
Date: Mon, 3 Apr 2006 01:49:36 +0900
Message-ID: <20060402164936.GA20570@htj.dyndns.org>
References: <442FF8C2.40201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932396AbWDBQtm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 12:49:42 -0400
Received: by wproxy.gmail.com with SMTP id i22so1167646wra
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 09:49:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <442FF8C2.40201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Apr 02, 2006 at 12:16:02PM -0400, Jeff Garzik wrote:
> 
> A previously fast-booting EM64T ICH6 AHCI box now pauses for 5 seconds, 
> when probing hits an empty port.

Yeap, aware of the problem.  Choices we have are...

1. don't delay too much between the softreset and the first hardreset
2. update AHCI softreset such that it succeeds if there's no device as
   other softresets do.
3. update reset mechanism such that reset methods return -ENODEV if
   it fails due to missing device such that we can skip retrying
   during probing and keep retrying during EH.

> Additionally, the probe code should IMO take into account the fact that 
> AHCI reset includes a COMRESET.

Hmmm....

-- 
tejun
