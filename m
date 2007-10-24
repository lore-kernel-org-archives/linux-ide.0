From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RESEND] libata: kill confusing @action local variable
 from	ata_eh_reset()
Date: Wed, 24 Oct 2007 15:06:36 +0900
Message-ID: <471EE0EC.9050301@gmail.com>
References: <20071024060138.GC11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:53234 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbXJXGGm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 02:06:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so84526rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 23:06:42 -0700 (PDT)
In-Reply-To: <20071024060138.GC11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Local variable @action in ata_eh_reset() is used only once after
> assignment and as all other operations are done on ehc->i.action
> directly, it can be a bit confusing.  Kill it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Eeeek, I take this patch back.  I'll post another one soon.  Sorry about 
the confusion.

-- 
tejun
