From: Elmar Weber <lists@elmarweber.org>
Subject: Re: sata_sil: I/O error accessing drive with Sil3114 chipset
Date: Fri, 14 Apr 2006 15:54:53 +0200
Message-ID: <443FA9AD.50602@elmarweber.org>
References: <443DA1C4.3060201@elmarweber.org> <443E915F.8040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:8921 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1750731AbWDNNzP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Apr 2006 09:55:15 -0400
Received: from [192.168.1.20] (unknown [192.168.1.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by server.home (Postfix) with ESMTP id C4E7056FA5
	for <linux-ide@vger.kernel.org>; Fri, 14 Apr 2006 15:55:07 +0200 (CEST)
In-Reply-To: <443E915F.8040100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Can you please post the output of 'lspci -n'?

Sure,

--
server ~ # lspci -n
00:00.0 0580: 10de:005e (rev a3)
00:01.0 0601: 10de:0050 (rev a3)
00:01.1 0c05: 10de:0052 (rev a2)
00:02.0 0c03: 10de:005a (rev a2)
00:02.1 0c03: 10de:005b (rev a3)
00:04.0 0401: 10de:0059 (rev a2)
00:06.0 0101: 10de:0053 (rev f2)
00:07.0 0101: 10de:0054 (rev f3)
00:08.0 0101: 10de:0055 (rev f3)
00:09.0 0604: 10de:005c (rev a2)
00:0a.0 0680: 10de:0057 (rev a3)
00:0b.0 0604: 10de:005d (rev a3)
00:0c.0 0604: 10de:005d (rev a3)
00:0d.0 0604: 10de:005d (rev a3)
00:0e.0 0604: 10de:005d (rev a3)
00:18.0 0600: 1022:1100
00:18.1 0600: 1022:1101
00:18.2 0600: 1022:1102
00:18.3 0600: 1022:1103
01:00.0 0300: 10de:0161 (rev a1)
05:07.0 0200: 10ec:8139 (rev 10)
05:0a.0 0104: 1095:3114 (rev 02)
05:0b.0 0c00: 104c:8023
--

Hope it helps.



Thanks & bye,
Elmar

