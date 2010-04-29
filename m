From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Thu, 29 Apr 2010 13:00:25 +0200
Message-ID: <871vdyh6ba.fsf@nemi.mork.no>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc>
	<4B96013F.1050904@kernel.org> <4B965DE7.7000109@teksavvy.com>
	<4B9881C8.10506@kernel.org> <4B9D0772.4080306@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49027 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933465Ab0D3S1i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Apr 2010 14:27:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1O7RTt-00026f-77
	for linux-ide@vger.kernel.org; Thu, 29 Apr 2010 13:00:33 +0200
Received: from nemi.mork.no ([148.122.252.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 29 Apr 2010 13:00:33 +0200
Received: from bjorn by nemi.mork.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 29 Apr 2010 13:00:33 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mark Lord <kernel@teksavvy.com> writes:

> No.  The vendor-unique commands appear to download a small firmware
> packet to the drive, which reprograms it for a longer "IDLE-3" timeou=
t.
>
> "IDLE-3" is what WD call this vendor-specific "powersaving" mode,
> and it is not intended to be adjustable.  Except via that little
> DOS utility hack, and even WD no longer make that available.

Just for storing a reference to this in Google:

WD still makes this utility available, but only for RE2-GP drives
AFAICS.  Don't know whether it still applies to other drives or if that
feature has been disabled.  I have not tried it myself on any drive...

Anyway, wdidle3_1_05.zip (presumably a newer version than
wdidle3_1_03.zip) can be downloaded from
http://support.wdc.com/product/download.asp?groupid=3D609&sid=3D113

Or if you want to click your way there: http://support.wdc.com/=20
-> Support -> Downloads -> SATA & SAS -> WD RE2-GP -> RE2GP Idle Mode U=
pdate Utility



Bj=C3=B8rn

