From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 16:12:47 -0500
Message-ID: <4D53034F.2090005@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com> <AANLkTik58FyjV=uVB8fv9hY_+ZDtJb1CP+7vV=PXnuF-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:56586 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab1BIVMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 16:12:40 -0500
In-Reply-To: <AANLkTik58FyjV=uVB8fv9hY_+ZDtJb1CP+7vV=PXnuF-@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/9/2011 3:47 PM, Greg Freemyer wrote:
> I gather fakeraids now use a HPA protected to hold metadata for how
> the raid is built, but I may have that wrong.

No, fakeraid does not know or care about the HPA.  It still stores its
metadata at the end of the disk, as it appears when its size is reduced
by the HPA, if there is an HPA.  Most systems do not have an HPA, but
some quirky ones do.  Both the bios and the Windows fakeraid drivers
leave the HPA intact if the system bios saw fit to make one.  A stock
Linux kernel does the same, but Ubuntu kernels default to automatically
unlocking the HPA, which moves the location of the fakeraid metadata
relative to the end of the disk, so dmraid can not find it.  Of course
it also enables the user to write to an area of the disk that the bios
very clearly marked as off limits.
