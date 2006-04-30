From: jason <huzhijiang@gmail.com>
Subject: Re: sata_sil24 resetting controller...
Date: Sun, 30 Apr 2006 10:22:39 +0800
Message-ID: <380087de0604291922u476f23bdsf9cd95081e1378a5@mail.gmail.com>
References: <20060427185813.GB6039@l4x.org> <4451594D.5060705@gmail.com>
	 <4452AFAF.3000101@l4x.org> <4452B165.6090905@gmail.com>
	 <445329A0.8020001@vip.cybercity.dk> <44533AA0.5060002@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:8802 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750882AbWD3CWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Apr 2006 22:22:39 -0400
Received: by wproxy.gmail.com with SMTP id i11so393487wra
        for <linux-ide@vger.kernel.org>; Sat, 29 Apr 2006 19:22:39 -0700 (PDT)
In-Reply-To: <44533AA0.5060002@l4x.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>
Cc: mogensv@vip.cybercity.dk, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jan Dittmer wrote


> I shifted the sata card into a 66MHz, 32bit PCI slot now and the
> problems went away. Just for the record, this is an Asus PU-DLS
> mainboard with E7501 chipset. Now I can dd from all devices without
> any error messages, giving me about 360mb/s continuous throughput for
> 6 devices which isn't that bad I suppose.
> The card gets assigned irq 22 in both configurations but in the
> latter the irq is shared with the on-board usb-uhci controller
> which somehow seems to work better...

push a 64bit+ 133Mhz+ non bridge PCI-X device into a 32bit slot? Is it right?
I am confused...

--
Yours,
jason
