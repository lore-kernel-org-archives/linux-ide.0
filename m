From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 13:47:48 -0500
Message-ID: <4D5432D4.60108@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <20110209153601.GJ3770@htj.dyndns.org> <4D52E180.6020908@garzik.org> <4D52EEEC.1020602@cfl.rr.com> <20110210094440.GL3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:64407 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1BJSrp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 13:47:45 -0500
In-Reply-To: <20110210094440.GL3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 4:44 AM, Tejun Heo wrote:
> I thought it would be a good and safe compromise for distros which
> don't want to unlock by default but look at where we are.  We just
> ended up with failures which are more obscure.  Your proposed addition
> will only push things further that direction.  It might not
> necessarily be a bad thing.  Maybe the level of obscurity then goes
> beyond certain level and we wouldn't have to care about that.

Exactly.  With this additional refinement, it should push the failure
cases so far into the obscure that we don't really need to worry about
it, and there isn't anything that can be done about it anyhow without
causing worse problems.

> But much better solution seems to be exporting the bios size to others
> and letting the ones which understand storage configuration better
> deal with it.  At the block or libata layer, we simply don't have
> enough information to make those decisions in a reliable manner.

Then you are back to doing something that from the perspective of the
standards, the bios, and Windows, is wrong and at least in theory can
cause data loss.  Why would that be better than unlocking when there is
good reason to believe that it 1) won't cause data loss, and 2) is
necessary to access user data?

My personal preference would be to get the HPA and partition table code
out of the kernel entirely and leave it up to udev and friends, which
have the ability to recognize complex situations like the disk being a
fakeraid member, and choose to ignore the partition table on the
underlying disk entirely, but that doesn't seem likely to happen soon.
