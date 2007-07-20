From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata [ata_piix] still no resume from S3 ?
Date: Fri, 20 Jul 2007 15:24:46 +0900
Message-ID: <46A0552E.30606@gmail.com>
References: <20070712162450.GA7132@0x82.com> <469744DB.5070600@gmail.com> <20070714210117.GA20723@0x82.com> <469DD216.5040305@gmail.com> <20070719092053.GA21254@0x82.com> <469F2E4A.1020502@gmail.com> <20070719150436.GA9006@0x82.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:49328 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbXGTG0D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 02:26:03 -0400
Received: by nz-out-0506.google.com with SMTP id s18so700769nze
        for <linux-ide@vger.kernel.org>; Thu, 19 Jul 2007 23:26:01 -0700 (PDT)
In-Reply-To: <20070719150436.GA9006@0x82.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?R=FAben_Fonseca?= <krani1@0x82.com>
Cc: Linux Kernel Mailling List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

R=FAben Fonseca wrote:
> I wish I could disable this card reader. It is built in on the hardwa=
re,
> and there are no drivers for Linux. There is no option on the BIOS to
> disable the device. Is there any way (kernel parameters, magic progra=
m,
> etc) to disable this device without opening my laptop to cut the wire=
s?
> :D

OIC.  How about not loading tifm_7xx1 module?  Does that make any
difference?

--=20
tejun
