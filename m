From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: Fri, 7 Oct 2005 01:48:50 +0900
Message-ID: <20051006164850.GB8047@htj.dyndns.org>
References: <20051004221450.18205.qmail@science.horizon.com> <4344CC61.8070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:59184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751143AbVJFQs5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 12:48:57 -0400
Received: by wproxy.gmail.com with SMTP id i2so233925wra
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2005 09:48:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4344CC61.8070609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@horizon.com
Cc: linux-ide@vger.kernel.org

 Hi,

 I posted the patch to implement sil24 ->tf_read callback (and cc'd to
you) just now.  It should be applied on top of three patches I posted
the other day.

http://marc.theaimsgroup.com/?l=linux-ide&m=112856662723993&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=112856662716013&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=112856662708456&w=2

 After applying all four patches (above three plus the one I cc'd to
you), when you hit a SATA error, you'll get proper report.  And we
should be able to debug that from there.

 Thanks.

-- 
tejun
