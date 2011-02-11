From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Fri, 11 Feb 2011 13:30:22 -0500
Message-ID: <4D55803E.7030106@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com> <20110209214118.GA7196@atj.dyndns.org> <4D5332D2.5090701@cfl.rr.com> <4D534378.3050304@gmail.com> <20110210091325.GK3770@htj.dyndns.org> <4D54387F.3030809@cfl.rr.com> <20110210193235.GO3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:59899 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757888Ab1BKSa2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 13:30:28 -0500
In-Reply-To: <20110210193235.GO3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 2:32 PM, Tejun Heo wrote:
> RAID.  The partition based detection is flimsy by nature.  Block layer
> doesn't have enough information to make the decision reliably.

So are you suggesting that the decision be done via udev?  Perhaps that
is the best thing to do...

> I don't know.  I think I explained as well as I could and it seems the
> biggest barrier to reaching agreement seems your attachment to BIOS
> features/requirements, which I frankly can't understand or appreciate.

You don't understand why users get upset that Linux breaks their system?

>>> Hotplugging and being able to move hard drives between different
>>> machines, and in general behaving consistently across different
>>> hardware configurations have way higher priority than trying to avoid
>>
>> Your auto unlock change seems to address that issue just fine.
> 
> If it did that just fine, this thread wouldn't exist.  I think we just
> should agree to disagree.  I'm not buying most of your arguments and
> you seem to be doing likewise.

This thread exists because it does not address an issue that is not in
that list you mentioned, and then it is no worse than before the change
( where it never auto unlocked ).

