From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Thu, 24 Feb 2005 13:29:31 +0800
Message-ID: <421D663B.5050107@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D41C2.3030909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:28159 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261788AbVBXFbQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 00:31:16 -0500
In-Reply-To: <421D41C2.3030909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>


Jeff Garzik wrote:

>> No problem reading/writing it. However, I have to remove the pre ATA-3 
>> check code before testing it.
> 
> Now that CHS support is present, I am OK with removing the "pre ATA-3" 
> version check.
> 

I'll remove this check in the IDP patch and resubmit the patch.

Albert


