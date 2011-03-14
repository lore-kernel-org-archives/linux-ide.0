From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] driver/FSL SATA: Update RX_WATER_MARK for TRANSCFG
Date: Mon, 14 Mar 2011 14:08:34 +0300
Message-ID: <4D7DF732.3000504@ru.mvista.com>
References: <1299470290-3451-1-git-send-email-prabhakar@freescale.com> <4D7DBE60.1040609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42712 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab1CNLKD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 07:10:03 -0400
Received: by wwk4 with SMTP id 4so1468006wwk.1
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2011 04:10:02 -0700 (PDT)
In-Reply-To: <4D7DBE60.1040609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Prabhakar Kushwaha <prabhakar@freescale.com>, linux-ide@vger.kernel.org, meet2prabhu@gmail.com

Hello.

On 14-03-2011 10:06, Jeff Garzik wrote:

>> RX_WATER_MARK sets the number of locations in Rx FIFO that can be used before
>> the transport layer instructs the link layer to transmit HOLDS. Note that it
>> can take some time for the HOLDs to get to the other end, and that in the
>> interim there must be enough room in the FIFO to absorb all data that could
>> arrive.

>> Update the new recommended value to 16.

>> Signed-off-by: Prabhakar Kushwaha<prabhakar@freescale.com>
>> ---
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (branch
>> master)

>> This patch is already gone through review of linuxppc-dev mail list.

>> drivers/ata/sata_fsl.c | 12 ++++++++++++
>> 1 files changed, 12 insertions(+), 0 deletions(-)

> applied

    Jeff, how about my sata_dwc_460ex patches?

http://marc.info/?l=linux-ide&m=129624104118401
http://marc.info/?l=linux-ide&m=129624121818608
http://marc.info/?l=linux-ide&m=129624134518793
http://marc.info/?l=linux-ide&m=129624141318888

WBR, Sergei
