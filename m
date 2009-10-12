From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH 0/1] sata_mv: Prevent PIO commands to be defered too long if traffic in progress.
Date: Mon, 12 Oct 2009 15:43:59 -0700
Message-ID: <1255387440-13313-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:12833 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758124AbZJLWpO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2009 18:45:14 -0400
In-Reply-To: <>
References: <>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mlord@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I found a bug in the sata_mv driver, that defers PIO commands indefinitely
while there is a traffic on other ports of a sata port multiplier [PMP]:

without traffic:
time smartctl --all /dev/sdc > /dev/null
real    0m0.243s

with fio running and blasting read IOs on 5 drives behind the same port multiplier for 5 minutes:
real    4m59.353s

Obviously the PIO commands are defer while traffic is in progress.

With the patch following, smart_ctl return before fio complete. It still takes 4s, time for all NCQ commands to be flushed out.
real    0m4.074s

Gwendal.
