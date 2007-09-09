From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Re: Maxtor 6L200M0 sata irq timeouts
Date: Sun, 9 Sep 2007 18:20:56 +0200
Message-ID: <a5d587fb0709090920y1241a528x4f5a1141026256a7@mail.gmail.com>
References: <a5d587fb0709090234x1942e987u4187bf0dbe977a06@mail.gmail.com>
	 <6b9952490709090740t188d5b71x26b90421bfe948bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:36844 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749AbXIIQU7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2007 12:20:59 -0400
Received: by nf-out-0910.google.com with SMTP id f5so641893nfh
        for <linux-ide@vger.kernel.org>; Sun, 09 Sep 2007 09:20:57 -0700 (PDT)
In-Reply-To: <6b9952490709090740t188d5b71x26b90421bfe948bf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>, linux-ide@vger.kernel.org

Hello

(please CC me when replying)

On 09/09/2007, Joris <joris@v5.be> wrote:
> Hi,
>
> Just a note to let you know you're not alone.
> I have the same problem, and someone else reported something simelar.
>
> What sata controller are you using?

The via onboard controller on the via chipset board and the Intel ICH7
integrated controller with this board. Looks like it is the drive and
the used controller does not make any difference.

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controller IDE (rev 01)

Thanks

Michal
