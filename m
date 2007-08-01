From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream 1/2] libata: don't skip EH report
 if action is pending
Date: Wed, 01 Aug 2007 14:56:57 +0900
Message-ID: <46B020A9.40009@gmail.com>
References: <20070731074203.GA13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:42989 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707AbXHAF5I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 01:57:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so84480rvb
        for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 22:57:06 -0700 (PDT)
In-Reply-To: <20070731074203.GA13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mikpe@it.uu.se

Tejun Heo wrote:
> Don't skip EH report if action is pending.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Jeff, this patch needs other changes to avoid exception message during
initial probing.  Please drop it for now and just apply the second patch.

Thanks.

-- 
tejun
