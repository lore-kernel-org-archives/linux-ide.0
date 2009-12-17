From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_octeon_cf.c: use resource_size()
Date: Thu, 17 Dec 2009 01:03:11 -0500
Message-ID: <4B29C99F.2020700@garzik.org>
References: <BD79186B4FD85F4B8E60E381CAEE190901FB0FB6@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33634 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZLQGDO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:03:14 -0500
Received: by yxe17 with SMTP id 17so1658359yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 16 Dec 2009 22:03:14 -0800 (PST)
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901FB0FB6@mi8nycmail19.Mi8.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-ide@vger.kernel.org

On 12/10/2009 08:03 PM, H Hartley Sweeten wrote:
> It appears the size for cs1 is calculated using the wrong resource.
> Use the function resource_size to get the correct value.
>
> Signed-off-by: H Hartley Sweeten<hsweeten@visionengravers.com>

applied


