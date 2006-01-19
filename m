From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATA passthrough questions
Date: Thu, 19 Jan 2006 12:54:03 +0100
Message-ID: <58cb370e0601190354g54d54f3j4fdb5240ccd21917@mail.gmail.com>
References: <867ae21dff5bea23500e8489161916d3@Netcell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.195]:34356 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161202AbWASLyF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jan 2006 06:54:05 -0500
Received: by uproxy.gmail.com with SMTP id s2so190860uge
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2006 03:54:03 -0800 (PST)
In-Reply-To: <867ae21dff5bea23500e8489161916d3@Netcell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Gillette <Matt.Gillette@netcell.com>
Cc: linux-ide@vger.kernel.org

Hi,

On 1/9/06, Matt Gillette <Matt.Gillette@netcell.com> wrote:
> Hi,
>
> I have a few questions about ata passthrough. Our controller creates
> its own ATA commands to configure the device, so I need full access to
> the taskfile when sending commands to the controller/drive.

What do you need to configure using non-standard commands?  RAID?

> Could someone tell me why CONFIG_IDE_TASKFILE is disabled by default?

Well, because it is experimental/dangerous/unfinished.
However some distributions enable it by default.

> Is www.kernel.org/pub/linux/kernel/people/jgarzik/libata the place to
> get information on libata? Or are there other places anyone can
> recommend?After glancing at the pdf, it looks like the function

http://linux.yyz.us/sata/

> HDIO_DRIVE_TASKFILE is called ata_tf_to_host in libata - is this
> right?Does this command need to be enabled in the kernel configuration
> options ala CONFIG_IDE_TASKFILE? Is there any open source code that
> uses theata_tf_to_host command so I can see it in action?

Do you need to this from driver of from user-space application?

If the former please give some link to the source code
so we could see what libata functions are needed.

If the latter than are using ATA pass-through interface
you need to issue specially prepared SG_IO ioctl instead.

Thanks,
Bartlomiej
