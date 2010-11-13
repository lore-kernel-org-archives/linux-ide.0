From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export ahci eSATA attribute
Date: Sat, 13 Nov 2010 00:30:28 -0500
Message-ID: <4CDE2274.8060807@garzik.org>
References: <4CDB63E7.1040106@cfl.rr.com> <4CDB79CA.6000606@garzik.org> <4CDE20CF.3010708@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56931 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0KMFab (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Nov 2010 00:30:31 -0500
Received: by vws13 with SMTP id 13so1239948vws.19
        for <linux-ide@vger.kernel.org>; Fri, 12 Nov 2010 21:30:31 -0800 (PST)
In-Reply-To: <4CDE20CF.3010708@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-ide@vger.kernel.org

On 11/13/2010 12:23 AM, Phillip Susi wrote:
> How about this one?

As you noted in your previous mail, the entire PORT_CMD is already 
exported as a attribute.  I don't see much point in exporting this 
information a second time.

One way or another, userspace must handle AHCI-specific hardware details.

	Jeff


