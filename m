From: "Victor Porton,,," <porton@ex-code.com>
Subject: Feature request: HDD status
Date: Wed, 01 Mar 2006 04:40:26 +0500
Message-ID: <E1FEESA-0002vG-00@porton.narod.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.kam-telecom.ru ([86.109.192.26]:28334 "EHLO
	kt-sv-1.kam-telecom.ru") by vger.kernel.org with ESMTP
	id S932615AbWB1XlB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Feb 2006 18:41:01 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I want the following feature:

Linux would be able (if this is possible for software) to
deliver to the user the state of the HDD, whether it is
active.

I mean that Linux would have a module which would export to
user space a boolean flag (probably a semaphore) which would
be true while the HDD red lamp is shining and false while it
is dark.

That is I want sofrware to provide the same info as this
hadrware HDD indicator on the front panel of most PCs.

(Then a Gnome applet would show it.)

I just look under the table to check HDD status to often
and would instead like to see it on the monitor.

Just a little wish.
