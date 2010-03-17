From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Intel X25-M and device-initiated interface power management
Date: Tue, 16 Mar 2010 18:10:51 -0600
Message-ID: <4BA01E0B.5050906@gmail.com>
References: <20100316220522.GA14120@x61.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44418 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab0CQAKz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2010 20:10:55 -0400
Received: by gyg8 with SMTP id 8so211060gyg.19
        for <linux-ide@vger.kernel.org>; Tue, 16 Mar 2010 17:10:54 -0700 (PDT)
In-Reply-To: <20100316220522.GA14120@x61.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-ide@vger.kernel.org

On 03/16/2010 04:05 PM, Tino Keitel wrote:
> Hi,
>
> I read that the Intel X25-M SSD consumes less than 0,3W during typical
> usage if DIPM is enabled.  This would give noticable power saving even
> compared to a spinned down hard disk.  I checked the hdparm -I output
> on my notebook with the current hard disk, and it shows this:
>
> *	Device-initiated interface power management
>
> When searching for the corresponding hdparm output with X25-M in
> google, I found only hdparm output with this feature unset.
>
> What can I expect with a X25-M on my hardware regarding DIPM? It is a
> ThinkPad X61s, lspci shows this:
>
> 00:1f.2 SATA controller [0106]: Intel Corporation 82801HBM/HEM
> (ICH8M/ICH8M-E) SATA AHCI Controller [8086:2829] (rev 03)
>
> Please CC: me in replies, as I'm not subscribed.

Have a look here:

http://www.thinkwiki.org/wiki/How_to_reduce_power_consumption#SATA_Link_Power_Management

Replace host0, host1, etc. with the appropriate numbers..
