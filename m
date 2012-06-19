From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Highpoint DC7280
Date: Mon, 18 Jun 2012 21:28:01 -0600
Message-ID: <4FDFF1C1.4060808@gmail.com>
References: <4FDEDE3A.7030507@psi5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:40748 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2FSD2I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2012 23:28:08 -0400
Received: by ghrr11 with SMTP id r11so4291737ghr.19
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 20:28:06 -0700 (PDT)
In-Reply-To: <4FDEDE3A.7030507@psi5.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christian Brandt <brandtc@psi5.com>
Cc: linux-ide@vger.kernel.org

On 06/18/2012 01:52 AM, Christian Brandt wrote:
> My company got hold of a Highpoint DC7280 for evaluation purposes. As we
> weren't that much impressed - mostly due abysmal propetiary drivers and
> support - I got it as a toy gift to play at home.
>
> Abstract in novella form: it is a dirt cheap 32 Port SATA-Controller. It
> features eight Marvell Chips each with a four port SATA Port Multiplier.
> Highpoint has abandoned all support (as usual) right a week before
> releasing it and the driver - dated 2011-06 - needs even some fiddling
> to compile under 3.0. Then it crashed upon writing. Besides that it is
> not THAT bad... gets around 250MB/s per Controller even with all eight
> controllers under maximum load.
>
> Is anyone else poking it with a stick?
>
> [1] http://www.highpoint-tech.cn/PDF/DC7280/DC7280_DS.pdf
>
> [2]
> http://www.highpoint-tech.com/BIOS_Driver/DC7280/driver/Linux/dc7280-linux-src-v1.0-110621-1313.tar.gz
>   (if KERNELVERSION==2.6 then... ok, so much about that one...)
>

What does lspci -vv show for that board?

It looks like that driver contains a binary blob so who knows what it is 
actually doing internally.
