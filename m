From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Fri, 11 Feb 2011 13:16:10 -0500
Message-ID: <4D557CEA.5020406@cfl.rr.com>
References: <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com> <20110209211351.3d7eff85@lxorguk.ukuu.org.uk> <4D5306F8.6050106@cfl.rr.com> <20110209213904.4aff945d@lxorguk.ukuu.org.uk> <4D532FFC.2020503@cfl.rr.com> <20110210124644.0cec1287@lxorguk.ukuu.org.uk> <4D543572.4010807@cfl.rr.com> <20110210191919.GN3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:56830 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893Ab1BKSQN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2011 13:16:13 -0500
In-Reply-To: <20110210191919.GN3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 2:19 PM, Tejun Heo wrote:
> Unlocking doesn't equal thrashing and if root wants to ignore BIOS
> suggestions, root shall be able to.

There is a big difference between root choosing to override and the
kernel blindly doing it by default.  When you do it by default, then the
user creates a partition using the protected area, you trash whatever
the bios was storing there.

> That's something BIOS writers should deal with.  Report it to them.
> Distros can be nice and lock it again during shutdown sequence from
> userland too but I don't think it's something which should dictate the
> decisions.

The BIOS dealing with it isn't going to happen because of the "it works
with windows" malaise.  Userland handling it won't work when you sysrq-b
or similar.
