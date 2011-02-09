From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 14:39:44 -0500
Message-ID: <4D52ED80.1080900@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <20110209153601.GJ3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:55730 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1BITjg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 14:39:36 -0500
In-Reply-To: <20110209153601.GJ3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/9/2011 10:36 AM, Tejun Heo wrote:
> Agreed.  We're screwed whether we unlock or leave it alone.  I think
> the best way is to export the original size via sysfs and always
> unlock and let dmraid and whatever stuff which expects metadata at the
> end use the bios size.  I seem to recall actually implementing it.
> Wondering where it went....

I am now confused since you are the author of
d8d9129ea28e2177749627c82962feb26e8d11e9, which seems to be entirely
aimed at NOT always unlocking by default, as Ubuntu has been doing, and
instead only unlock if it seems needed to access user data.  I like the
idea, but it gets false positives for dmraid users, so it should be
refined a bit.
