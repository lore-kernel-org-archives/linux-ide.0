From: jason <huzhijiang@gmail.com>
Subject: Re: IRQ problem with sata_sil
Date: Wed, 10 May 2006 09:11:53 +0800
Message-ID: <380087de0605091811w55ceb4ek1c52d0302e0170e1@mail.gmail.com>
References: <e3n4ru$ktd$1@sea.gmane.org>
	 <dd43dcfb0605080319t59c8d152lc12f872917d9c8bf@mail.gmail.com>
	 <e3p9um$nn8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:52840 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932073AbWEJBLx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2006 21:11:53 -0400
Received: by wr-out-0506.google.com with SMTP id i12so39486wra
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 18:11:53 -0700 (PDT)
In-Reply-To: <e3p9um$nn8$1@sea.gmane.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas STRANSKY <Nico@stransky.cx>
Cc: linux-ide@vger.kernel.org

Hi Nicolas,

You should also provide the following information.

# lspci
# lspci -vv -s 02:0c.0
# lspci -vv -s 02:05.0
# cat /proc/interrupts

BTW: Have you tried your SATA card with any other PCI slots? Or may be
a BIOS update or DSDT update could also solve the problem.



Yours,
jason
