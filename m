From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: remove IRQ mask clearing from init_controller()
Date: Wed, 09 Aug 2006 13:01:49 +0900
Message-ID: <44D95E2D.1070808@gmail.com>
References: <20060807023904.GA28202@htj.dyndns.org> <44D95BD9.7030702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:56402 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030363AbWHIEBz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 00:01:55 -0400
Received: by wx-out-0506.google.com with SMTP id s14so77573wxc
        for <linux-ide@vger.kernel.org>; Tue, 08 Aug 2006 21:01:54 -0700 (PDT)
In-Reply-To: <44D95BD9.7030702@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Initial IRQ mask clearing is done by libata-core by freezing all ports
>> prior to requesting IRQ.  Remove redundant IRQ clearing from
>> init_controller().
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> is this for upstream (2.6.19) or upstream-fixes (2.6.18-rc)?

It's for #upstream.

-- 
tejun
