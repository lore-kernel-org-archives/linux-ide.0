From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Marvel PMP SATA controller
Date: Wed, 29 Sep 2010 15:56:45 -0400
Message-ID: <4CA399FD.6030904@teksavvy.com>
References: <4CA2E33B.70001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:24427 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754201Ab0I2T4r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2010 15:56:47 -0400
In-Reply-To: <4CA2E33B.70001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10-09-29 02:56 AM, Richard wrote:
> Morning all,
>
> Using the Marvel Port Multiplier I am stuck trying to get it working with some Hard drives.


Err.. just plug some drives into it, and then plug it (the PMP) into
a SATA controller that supports PMP (eg. the Marvell ones, newer AHCI, some Sil ones, etc..).

What are you trying to do?
