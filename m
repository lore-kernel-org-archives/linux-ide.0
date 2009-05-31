From: Jiri Slaby <jirislaby@gmail.com>
Subject: broken ide-tape
Date: Sun, 31 May 2009 16:52:08 +0200
Message-ID: <4A229998.6070808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:31131 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781AbZEaOxb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2009 10:53:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

ide-tape is broken since commit 346331f82823682fb5c2df6e827db25d95cc2e92
(ide-tape: remove atomic test/set macros for packet commands)
from Apr 18 2008.

The commit introduced flags which are defined as (1 << nr) and uses them
in {clear,set,test}_bit. And hence it must oops on each do_request.

Is it worth fixing (something like ilog2 added to each bit operation) or
is a complete removal of the driver better "fix"?
