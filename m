From: "Jason Pfingstmann" <jason@pfingstmann.com>
Subject: Re: sata_sil - broke at some point
Date: Mon, 3 Jul 2006 00:01:47 -0700
Message-ID: <cec86d5f0607030001w2fb7c07fraa36aecc930de84b@mail.gmail.com>
References: <cec86d5f0607022158n713e0d73ue967ecb93eb3b1e2@mail.gmail.com>
	 <44A8AEAB.6080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:28526 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750983AbWGCHBs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:01:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so1260969pyg
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:01:48 -0700 (PDT)
In-Reply-To: <44A8AEAB.6080701@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 7/2/06, Tejun Heo <htejun@gmail.com> wrote:
> VIA chipset?  If so, the following message might be relevant.
>
> http://article.gmane.org/gmane.linux.ide/11733

Nope, I'm afraid not.  The only VIA device I have (from lspci |grep -i
via) is my firewire controller.  The SATA controller is a Silicon
Image 3112 based card (PCMCIA) and my onboard IDE controller is the
ATI IXP.  This is a laptop, btw, with an AMD64 mobile processor (my
system is compiled all 64-bit, retaining 32-bit compatibility though).

-Jason
