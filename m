From: Tim Moore <linux-ide@nsr500.net>
Subject: Re: sata_sil 0.9 experience
Date: Thu, 02 Jun 2005 22:31:54 -0700
Message-ID: <429FEB4A.10702@nsr500.net>
References: <86298ca105060111511cfd1cf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:33497 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261282AbVFCFbz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Jun 2005 01:31:55 -0400
Received: from dsl081-056-134.sfo1.dsl.speakeasy.net (HELO [192.168.1.10]) ([64.81.56.134])
          (envelope-sender <linux-ide@nsr500.net>)
          by mail25.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 3 Jun 2005 05:31:53 -0000
In-Reply-To: <86298ca105060111511cfd1cf1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> ...
> Unfortunately, I was unable to just upgrade to 2.4.31 due to
> threads... when I compiled 2.4.31-rc1 and booted with it, BIND aka
> named would dump core, and upon investigation I discovered that the
> vanilla 2.4 kernel would not work right with RHEL3.  (I'm sure if I
> spent a bunch of time that there has to be a way to compile 2.4 so
> that it works with RHEL3, but I'm not really all that interested in
> that particular learning curve.)

search for LD_ASSUME_KERNEL=2.4.19; export LD_ASSUME_KERNEL

I run 2.4.30 on a RHEL3 base at work without a problem, including bluecurve.

Try /etc/csh.*, /etc/profile /etc/init.d/{nscd,ypbind,named} for starters.

sata_sil should compile too.

t.
