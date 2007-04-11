From: Chuck Ebbert <cebbert@redhat.com>
Subject: Loud "pop" coming from hard drive on reboot
Date: Wed, 11 Apr 2007 17:07:56 -0400
Message-ID: <461D4E2C.6000704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbXDKVIA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Apr 2007 17:08:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

When I reboot my notebook, it powers off and powers back on.
On poweroff a loud snapping noise seems to be coming from the
hard drive. Today I noticed there is no "shutdown: hda" on
the console when I reboot. Whne I do a normal poweroff the
message is displayed and there is no noise. Should the IDE
code be changed so it always shuts down the drive?
