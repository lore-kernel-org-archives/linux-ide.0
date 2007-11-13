From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata , Silicon Image 3124
Date: Tue, 13 Nov 2007 10:22:20 +0900
Message-ID: <4738FC4C.7050103@gmail.com>
References: <4738A231.5010700@kasimir-mueller.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.180]:43024 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbXKMBW3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 20:22:29 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688231roc
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 17:22:28 -0800 (PST)
In-Reply-To: <4738A231.5010700@kasimir-mueller.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-15?Q?Kasimir_M=FCller?= <kjm@kasimir-mueller.de>
Cc: linux-ide@vger.kernel.org

Kasimir M=FCller wrote:
> Nov 12 19:28:42 linux kernel: ata6.02: cmd
> ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
> Nov 12 19:28:42 linux kernel:          res
> 40/00:00:09:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)

That's flush timing out, which isn't good.

1. Are the errors localized to ata6.02?

2. Is FLUSH always involved (ie. is cmd always ea)?

3. If you disable NCQ, what do errors look like?

--=20
tejun
