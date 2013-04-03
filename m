From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] pata_legacy: bogus clock in opti82c46x_set_piomode()
Date: Wed, 03 Apr 2013 19:56:27 -0400
Message-ID: <515CC1AB.60603@pobox.com>
References: <20130311114151.GB8235@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:62492 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759191Ab3DCX43 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:56:29 -0400
In-Reply-To: <20130311114151.GB8235@longonot.mountain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

On 03/11/2013 07:41 AM, Dan Carpenter wrote:
> "sysclk" is used as an index into a 4 element array.  My static
> checker complains because it can be out of bounds.  From the
> context, it looks like there is a right bit shift missing.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I don't have the hardware to test this.

applied (to #upstream)



