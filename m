From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for
 Intel ICH9
Date: Wed, 22 Nov 2006 10:43:26 +0900
Message-ID: <4563AB3E.9050305@gmail.com>
References: <39B20DF628532344BC7A2692CB6AEE07A5A356@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:32994 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161733AbWKVBne (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 20:43:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so46034uga
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 17:43:33 -0800 (PST)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07A5A356@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Gaston, Jason D wrote:
> I was thinking that if a functional difference was found, it would be
> easier to tweak.
> 
> There are differences between the ICH8 and ICH9 SATA controller.  For
> example, the PCS register now has port present bits that used to be
> reserved in ICH8.  I'm not sure how or if these could be used in
> ata_piix.

Separating ich9 out from ich8 isn't difficult.  Let's do that when there 
is need.  ata_piix always has been using the same entry if there is no 
code difference and I don't see any reason to depart from that with ich9.

Thanks.

-- 
tejun
