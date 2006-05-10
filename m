From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Wed, 10 May 2006 16:37:54 +0300
Message-ID: <41840b750605100637w2205bf71h6997aee691b3947c@mail.gmail.com>
References: <44614592.7080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:63711 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964962AbWEJNhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2006 09:37:55 -0400
Received: by wr-out-0506.google.com with SMTP id i12so137764wra
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 06:37:54 -0700 (PDT)
In-Reply-To: <44614592.7080301@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 5/10/06, Tejun Heo <htejun@gmail.com> wrote:
> git://htj.dyndns.org/libata-tj

With this kernel tree, ata_piix warmplug works perfectly with ICH6 on
ThinkPad T43.
At long last, I can now switch between the UltraBay DVD drive and
UltraBay HDD without rebooting!

On this machine the command for disabling the port is
# echo 1 > /sys/class/scsi_device/1\:0\:0\:0/device/delete
and the command for enabling and re-scanning is
# echo 0 0 0 >  /sys/class/scsi_host/host1/scan

Thanks for the excellent work!

  Shem
