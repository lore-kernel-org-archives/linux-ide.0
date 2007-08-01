From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream 2/2] libata: move EH repeat reporting
 into ata_eh_report()
Date: Wed, 01 Aug 2007 12:38:53 +0900
Message-ID: <46B0004D.3010808@gmail.com>
References: <200707312127.l6VLRfGR029509@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:63808 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbXHADkD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 23:40:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so62531rvb
        for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 20:40:02 -0700 (PDT)
In-Reply-To: <200707312127.l6VLRfGR029509@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This is with both 1/2 and 2/2 applied, with only 2/2 applied the
> "EH pending ..." is gone and the new "exception ... frozen" don't appear.

Thanks.  Right, I'll drop the first patch.

-- 
tejun
