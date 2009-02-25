From: Mike Cui <cuicui@gmail.com>
Subject: sata_promise fails to detect all 4 HDD on the TX4 since 2.6.26
Date: Tue, 24 Feb 2009 17:56:25 -0800
Message-ID: <7c8826910902241756j6e2d9c88pc293503e9cbf73ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.217.174]:52234 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbZBYB41 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2009 20:56:27 -0500
Received: by gxk22 with SMTP id 22so7934121gxk.13
        for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2009 17:56:25 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I tried to update to Ubuntu 8.10 from 8.04 last week, and noticed that
after the update the sata_promise driver can no longer detect all 4
HDDs that I have plugged into the SATAII300TX4 card. It always reports
that the link is down on the first port. I also tried booting a gentoo
kernel with 2.6.26, same problem. However, Ubuntu 8.04 with 2.6.25
seems fine. Is this a known problem?
