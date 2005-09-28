From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/ide/via entry
Date: Thu, 29 Sep 2005 00:00:17 +0100
Message-ID: <433B2081.9050607@gentoo.org>
References: <43146CC3.4010005@gentoo.org> <58cb370e05083008121f2eb783@mail.gmail.com> <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <433B16BD.7040409@gentoo.org> <20050928223718.GB7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:8551 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751217AbVI1XLT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Sep 2005 19:11:19 -0400
In-Reply-To: <20050928223718.GB7992@ftp.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

Hi Al,

(btw, original subject was wrong, I actually meant /proc/ide/via)

Al Viro wrote:
> Care to explain
> 	* where to get equivalent information?

I don't think there is anywhere else that provides the whole range, but I do 
question the usefulness of most of it :)

Here's my previous attempt at this patch:

	http://marc.theaimsgroup.com/?l=linux-ide&m=112630444000358&w=2

If you can point out a way to keep /proc/ide/via around without causing the 
kind of ugliness found above, then maybe Bart can be persuaded to keep it 
around :)

> 	* what hardware setup has more than one of those controllers?

I'm pushing to get a simple patch merged, which adds ID's for a VIA VT6410 
controller. Apparently these are available in PCI-card form as well as 
onboard-PCI-chip form. Bart raised the concern that this driver wouldn't cope 
well with 2 different controllers in use, so I'm trying to address this.

Thanks,
Daniel
