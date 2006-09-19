From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fix libata resource conflict for legacy mode
Date: Tue, 19 Sep 2006 00:27:07 -0400
Message-ID: <450F719B.1020002@garzik.org>
References: <m3ac4xiacr.fsf@anduin.mandriva.com> <450EA3BA.8010100@gmail.com> <m3zmcxgqu6.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48540 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752047AbWISE1O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 00:27:14 -0400
In-Reply-To: <m3zmcxgqu6.fsf@anduin.mandriva.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Arnaud Patard wrote:
> When the libata is trying to handle legacy ide ports (0x1f0 for instance), it
> doesn't take care if the resource has childs or not. 
> The result is that this situation :
> 0100-01fe : pnp 00:09
>   0170-0177 : libata
>   01f0-01f7 : libata
> 
> is seen as conflict, which is wrong.
> The proposed fix is to detect childs and in this case, look at which child is
> conflicting.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>


Applied.  For the future, please inline both the patch description, and 
the patch itself.  I had to apply this manually, rather than use the 
usual scripts.

For more info read:
Documentation/SubmittingPatches
http://linux.yyz.us/patch-format.html

	Jeff


