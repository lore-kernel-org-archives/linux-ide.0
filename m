From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Tue, 29 May 2007 11:16:00 +0200
Message-ID: <465BEF50.8050207@gmail.com>
References: <46580134.7010107@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:15797 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011AbXE2LTs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 May 2007 07:19:48 -0400
Received: by py-out-1112.google.com with SMTP id a29so831976pyi
        for <linux-ide@vger.kernel.org>; Tue, 29 May 2007 04:19:47 -0700 (PDT)
In-Reply-To: <46580134.7010107@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Florian Effenberger wrote:
> Hi,
> 
> it seems that the speed is never lowered, I always see "SATA link up 3.0
> Gbps (SStatus 123 SControl 300)".
> 
> Can I manually lower the speed via a kernel parameter?

Currently, there is no mechanism to do that but hard drives usually have
dip switch to force 1.5Gbps.  Please try that.  If your harddrive
doesn't have that, please lemme know.  I'll prepare a simple patch.

Thanks.

-- 
tejun

