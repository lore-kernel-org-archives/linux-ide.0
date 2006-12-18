From: Bob Stewart <bob@evoria.net>
Subject: Re: [PATCH 2/2] sata_inic162x: finally, driver for initio 162x SATA controllers
Date: Sun, 17 Dec 2006 16:25:48 -0800 (PST)
Message-ID: <10011.50132.qm@web810.biz.mail.mud.yahoo.com>
References: <20061217015008.GL5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web810.biz.mail.mud.yahoo.com ([209.191.90.83]:35349 "HELO
	web810.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753309AbWLRAcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Dec 2006 19:32:31 -0500
In-Reply-To: <20061217015008.GL5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, nabble@theanthonys.net, alan@lxorguk.ukuu.org.uk, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

Could someone give me a quick bootstrap?  I'm able to
compile and test the driver, but I simply cannot
figure out where to get the version of libata-dev that
matches the patches Tejun sent out.  I'm not even
quite certain which kernel I should be testing
against; I'm currently using 2.6.19.1.  Any sort of
bone would be really appreciated.

The driver is very unstable on my machine; going
quickly into repeated hard resets and attempts at
reducing the interface speed.  I am unable to
successfully make a filesystem on it.  Perhaps this is
because I'm not up-to-date on libata-dev?

Bob
