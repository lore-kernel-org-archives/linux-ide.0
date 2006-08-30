From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.18-rc5 - HPT302 wierdness
Date: Wed, 30 Aug 2006 11:01:44 +0100
Message-ID: <1156932104.6271.138.camel@localhost.localdomain>
References: <17652.55275.556545.19616@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49568 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750791AbWH3JkE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Aug 2006 05:40:04 -0400
In-Reply-To: <17652.55275.556545.19616@smtp.charter.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Maw, 2006-08-29 am 20:12 -0400, ysgrifennodd John Stoffel:
> The drives are identical, and bought at the same time, yet on bootup
> of 2.6.18-rc5, they show up with different values for CHS and for Max
> Request Size.

One is using LBA48 the other is not. Looks like you have two very
different firmwares

