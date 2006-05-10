From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Wed, 10 May 2006 19:44:47 +0300
Message-ID: <41840b750605100944p7482fa12m315844b43df8b9a6@mail.gmail.com>
References: <44614592.7080301@gmail.com>
	 <41840b750605100637w2205bf71h6997aee691b3947c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:28361 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965009AbWEJQos convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2006 12:44:48 -0400
Received: by wr-out-0506.google.com with SMTP id i12so180148wra
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 09:44:47 -0700 (PDT)
In-Reply-To: <41840b750605100637w2205bf71h6997aee691b3947c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, igorr@ifi.uio.no

Hi,

For the record, lest anyone burns his laptop:

On 5/10/06, Shem Multinymous <multinymous@gmail.com> wrote:
> With this kernel tree, ata_piix warmplug works perfectly with ICH6 on
> ThinkPad T43.
> At long last, I can now switch between the UltraBay DVD drive and
> UltraBay HDD without rebooting!
>
> On this machine the command for disabling the port is
> # echo 1 > /sys/class/scsi_device/1\:0\:0\:0/device/delete

On ThinkPads, before pulling out the drive you also need to run
# echo eject >  /proc/acpi/ibm/bay
to electrically shut down the UltraBay PATA port. This interface is
provided by the ibm-acpi module.

  Shem
