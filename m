From: Thomas DEBESSE <thomas.debesse+debian@gmail.com>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
 ahci module deactivate hotplug support (regression from lenny)
Date: Mon, 15 Nov 2010 14:43:55 +0100
Message-ID: <AANLkTinKLP=Y2gqS3KvqnUndTXq2Mixp=-Uh2RtgssXd@mail.gmail.com>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet>
	<1285799230.28504.105.camel@localhost>
	<4CAA04FB.7070402@gmail.com>
	<20101004175438.GZ5947@vostochny.stro.at>
	<AANLkTikVYpaYd4xOeBeWu9aHieJ+P1nTLJ_eoGyXC2K0@mail.gmail.com>
	<20101005090522.GA5947@vostochny.stro.at>
	<AANLkTimUEpq1V=eSammBk9M0GHVRjZgfSBCjXQ36o95_@mail.gmail.com>
	<20101006183321.GU13095@decadent.org.uk>
	<AANLkTikhmG_mBrCAun+0SWAu0WQGrnVrgOHdpteBk3eU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53895 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab0KONn4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Nov 2010 08:43:56 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so5181352bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 15 Nov 2010 05:43:55 -0800 (PST)
In-Reply-To: <AANLkTikhmG_mBrCAun+0SWAu0WQGrnVrgOHdpteBk3eU@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 598518@bugs.debian.org
Cc: Ben Hutchings <ben@decadent.org.uk>, maximilian attems <max@stro.at>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

2010/10/20 Thomas DEBESSE <thomas.debesse+debian@gmail.com>:
> I've just installed a fresh Squeeze and I got the new kernel :
> I have the 2.6.32-25, wich was announced to solve the problem,
> and yes this new one put modules.order in initramfs
> but the wrong module is always loaded :
> This bug is not fixed.

The previous test was done with a livecd installing 2.6.32-24 then
upgrading to 2.6.32-25.
I've done another test with another fresh install but using a livecd
with 2.6.32-25 kernel.
The good module is loaded without modifying aliases.conf.

This bug seems fixed, but there is some persistence when upgrading
from previously installed Squeeze distros.


Thanx.
