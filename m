From: "Matthew Stoltenberg" <d3matt@gmail.com>
Subject: Re: pata_marvell woes
Date: Mon, 29 Sep 2008 08:26:27 -0500
Message-ID: <3c1bc2140809290626m43f874bw3aca5976da1be35e@mail.gmail.com>
References: <3c1bc2140809281827h2154039rec8e65482e54a0f4@mail.gmail.com>
	 <20080929100957.7cf41fdf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44259 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYI2N03 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Sep 2008 09:26:29 -0400
Received: by gxk9 with SMTP id 9so10414998gxk.13
        for <linux-ide@vger.kernel.org>; Mon, 29 Sep 2008 06:26:28 -0700 (PDT)
In-Reply-To: <20080929100957.7cf41fdf@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Mon, Sep 29, 2008 at 4:09 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sun, 28 Sep 2008 20:27:52 -0500
> "Matthew Stoltenberg" <d3matt@gmail.com> wrote:
>
>> Hey Alan, Jeff, and the linux-ide ML,
>>
>> I'm having trouble with a Marvell pata controller.  It's on an Asus
>> P5Q PRO.  It's an intel P45 based board with an added PATA controller.
>>  The manual (and website) says that the chip a Marvell 88SE6111.
>
> Known bug. Should be fixed in 2.6.27rc. Jeff merged some stuff which broke
> the PATA support on the Marvell chips. 2.6.27 merges some changes so that
> you now get AHCI if you are using just the SATA ports (best choice), or
> pata_marvell if you are using the PATA port as well.

I tried rc7 and it looks like it's working.  Thanks for the quick response.

Now to get the happy little nvidia driver to work with rc7 :-/

Matt
