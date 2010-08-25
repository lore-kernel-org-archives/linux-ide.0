From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: promise sataII 150 TX4 issue
Date: Tue, 24 Aug 2010 22:24:55 -0600
Message-ID: <4C749B17.7070507@gmail.com>
References: <i4f6jk$969$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45389 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0HYEY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Aug 2010 00:24:58 -0400
Received: by iwn5 with SMTP id 5so234692iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 24 Aug 2010 21:24:58 -0700 (PDT)
In-Reply-To: <i4f6jk$969$1@dough.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kenneth johansson <ken@kenjo.org>
Cc: linux-ide@vger.kernel.org

On 08/17/2010 05:39 PM, kenneth johansson wrote:
> 00:0d.0 Mass storage controller: Promise Technology, Inc. PDC20518/
> PDC40518 (SATAII 150 TX4) (rev 02)
>
> I have a raid5 with 3 disks in and have started so see some weired
> problems.First I thought it was the disk since it was always the same but
> after changing the disk I now have the same problems but another disk so
> I'm starting to suspect a driver issue.
>
> The only disk I have in the system is connected to this pci card and the
> problem is always with the disk named sda regardless if it is connected
> to the first sata port or the second and first is empty.
> I have switch power cables and sata cables around but problem is not
> moving from sda.
>
> problem seen on kernel version vmlinuz-2.6.35,vmlinuz-2.6.33.3. was
> running vmlinuz-2.6.28.7 for about a year before that without any problem.
>
> Now it took about two month before sda got kicked out of the raid on
> 2.6.33.3 but 2.6.35 have not lasted more than a few days.
>
> -------------------------------------------
> Aug 15 20:27:22 amd kernel: [171585.020040] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x180000 action 0x6 frozen
> Aug 15 20:29:15 amd kernel: [171585.020080] ata1: SError: { 10B8B Dispar }
> Aug 15 20:29:15 amd kernel: [171585.020100] ata1.00: failed command: WRITE DMA EXT
> Aug 15 20:29:15 amd kernel: [171585.020125] ata1.00: cmd 35/00:f8:3f:bb:a1/00:03:73:00:00/e0 tag 0 dma 520192 out
> Aug 15 20:29:15 amd kernel: [171585.020127]          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)

The controller's reporting errors on the SATA link. I would still tend 
to suspect some kind of hardware issue - maybe that port connector is 
bad on the card or something? I would be surprised if a driver fault 
could cause this to be reported spuriously.
