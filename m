From: Guido Diepen <guido@jcwodan.nl>
Subject: Re: Again problems with PDC20268 and vol_id
Date: Sat, 10 Mar 2007 10:57:28 +0100
Message-ID: <200703101057.32631.guido@jcwodan.nl>
References: <4964.131.211.80.61.1173446203.squirrel@hammerhead.dyndns.org> <20070309190856.c86efd73.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp20.nijmegen.internl.net ([217.149.192.18]:42089 "EHLO
	smtp20.nijmegen.internl.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbXCJJ5x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 04:57:53 -0500
In-Reply-To: <20070309190856.c86efd73.vsu@altlinux.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-ide@vger.kernel.org

Hi Sergey,

> Is the partition table correct?  Maybe the partition extends beyond
> the end of physical disk for some reason, and when the kernel tries to
> access last blocks of the partition, it actually tries to read sectors
> beyond the actual drive capacity, which fails and exposes broken error
> handling in the Promise IDE driver.
>
> I have added the linux-ide mailing list to Cc: - problems related to
> IDE/ATA drivers (both old IDE, which you are using currently, and
> newer libata) should be discussed there.

Last night I copied all data on the /dev/hdg2 partition to other partitions, 
removed the /dev/hdg2 partition and recreated it. Currently everything works 
flawless !!!

Apparently there is a bug in the promise IDE pdc202xx_new.c driver :)

Thank you very much for the help!!!

Regards,

Guido Diepen


-- 
Aviation is proof that given the will, we have the 
capacity to achieve the impossible.
     --Eddie Rickenbacker
