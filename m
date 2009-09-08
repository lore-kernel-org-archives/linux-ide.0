From: Fredrik Tuomas <fredrik.tuomas@gmail.com>
Subject: Re: Some of mine ST31000520AS drives unloads head very frequent and I
	cannot set APM on them
Date: Tue, 8 Sep 2009 11:52:37 +0200
Message-ID: <e44195c70909080252q18e26886p8adbf6183b70ebc2@mail.gmail.com>
References: <e44195c70909080124s62cc6841t617c2ce662222687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47554 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbZIHJwg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Sep 2009 05:52:36 -0400
Received: by bwz19 with SMTP id 19so2063641bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 08 Sep 2009 02:52:37 -0700 (PDT)
In-Reply-To: <e44195c70909080124s62cc6841t617c2ce662222687@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

In the pdf on

http://www.seagate.com/staticfiles/support/disc/manuals/desktop/Barracuda%20LP/100564361a.pdf

you can read that APM is not supported on the disk. Now I'm confused.
I can set APM on at least one of my drives. How can I prohibit the
excessive loading/unloading of the heads if APM not is supported?

I have set the spindown time do 1h with hdparm -S242 on all these drives.

/ Fredrik Tuomas
