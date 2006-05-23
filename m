From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ICH8 ATA mode on 2.4
Date: Tue, 23 May 2006 16:55:23 -0400
Message-ID: <447376BB.6050805@pobox.com>
References: <D80BC16BC8FCD744B8D4B7BA4F5B13B001474257@ausx3mps313.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19918 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932198AbWEWUz0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 May 2006 16:55:26 -0400
In-Reply-To: <D80BC16BC8FCD744B8D4B7BA4F5B13B001474257@ausx3mps313.aus.amer.dell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bryan_Kemp@Dell.com
Cc: linux-ide@vger.kernel.org

Bryan_Kemp@Dell.com wrote:
> Jeff,
> Hi, my name is Bryan and I develop a small linux based OS used in 
> manufacturing here at Dell. I have some new systems based on the ICH8 

Neat!


> Chipset that I need to support with the 2.4 kernel. I had noticed the 
> 2820, 2825 and 2828 pci information is in the 2.6.17-rc4 kernel source. 
> Are you planning on adding that support back to the 2.4 code base?

Unfortunately not.  For the purposes of libata, and also for the 2.4.x 
kernel series in general, it is in strict maintenance mode, with only 
severe bug fixes being addressed.

If you, or others, wanted to backport the current libata to 2.4.x, you 
would certainly have my blessing.  I just don't have time for 2.4.x at 
all, particularly as recent libata changes have made the backport more 
difficult than it was in the past.

	Jeff


