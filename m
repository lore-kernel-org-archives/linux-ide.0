From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCHSET] libata: improve ata_bus_probe failure handling, take
 2
Date: Tue, 04 Apr 2006 13:02:13 +0800
Message-ID: <4431FDD5.1090209@tw.ibm.com>
References: <11439680863256-git-send-email-htejun@gmail.com> <442FE142.7030304@pobox.com> <4430ECEF.30307@tw.ibm.com> <4430FB37.6040600@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:19852 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751290AbWDDFCd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Apr 2006 01:02:33 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3452RgC019152
	for <linux-ide@vger.kernel.org>; Tue, 4 Apr 2006 01:02:27 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3455cYa191910
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 23:05:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3452QGf022771
	for <linux-ide@vger.kernel.org>; Mon, 3 Apr 2006 23:02:27 -0600
In-Reply-To: <4430FB37.6040600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> 
> For the record, I do consider irq-pio upstream ready.  It still needs to
> wait for Tejun's EH work to make it upstream, to give upstream people
> the test sets of
> 
>     - prep EH (2.6.17-rc1)
>     - EH
>     - NCQ
>     - irq-pio
> 
> Since each of these sets is staged, upstream testers will be able to say
> "2.6.17-rc1 works, but 2.6.18-git1 doesn't", which gives us a lot of
> good info.
> 

Nice to see those features upstream. Thanks. :)

--
albert

